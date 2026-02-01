package com.influ.payment;

import com.influ.common.exception.BusinessRuleViolationException;
import com.influ.common.exception.ResourceNotFoundException;
import com.influ.config.StripeConfig;
import com.influ.deal.Deal;
import com.influ.deal.DealRepository;
import com.influ.deal.DealService;
import com.influ.deal.DealStatus;
import com.influ.payment.dto.ConnectAccountResponse;
import com.influ.payment.dto.CreatePaymentIntentResponse;
import com.influ.payment.dto.PaymentResponse;
import com.influ.user.User;
import com.influ.user.UserRepository;
import com.influ.user.UserType;
import com.stripe.exception.StripeException;
import com.stripe.model.Account;
import com.stripe.model.AccountLink;
import com.stripe.model.PaymentIntent;
import com.stripe.model.Transfer;
import com.stripe.param.AccountCreateParams;
import com.stripe.param.AccountLinkCreateParams;
import com.stripe.param.PaymentIntentCreateParams;
import com.stripe.param.TransferCreateParams;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.UUID;

@Slf4j
@Service
@RequiredArgsConstructor
public class PaymentService {

    private final PaymentRepository paymentRepository;
    private final DealRepository dealRepository;
    private final UserRepository userRepository;
    private final DealService dealService;
    private final StripeConfig stripeConfig;
    private final PaymentMapper paymentMapper;

    @Transactional
    public ConnectAccountResponse createConnectAccount(User user, String returnUrl, String refreshUrl) {
        if (user.getType() != UserType.INFLUENCER) {
            throw new BusinessRuleViolationException("Only influencers can create Connect accounts");
        }

        if (user.getStripeAccountId() != null) {
            throw new BusinessRuleViolationException("Connect account already exists");
        }

        String idempotencyKey = "connect_account_" + user.getId();
        Account account = null;

        try {
            AccountCreateParams accountParams = AccountCreateParams.builder()
                    .setType(AccountCreateParams.Type.EXPRESS)
                    .setEmail(user.getEmail())
                    .setCapabilities(AccountCreateParams.Capabilities.builder()
                            .setTransfers(AccountCreateParams.Capabilities.Transfers.builder()
                                    .setRequested(true)
                                    .build())
                            .build())
                    .build();

            account = Account.create(accountParams, com.stripe.net.RequestOptions.builder()
                    .setIdempotencyKey(idempotencyKey)
                    .build());

            AccountLinkCreateParams linkParams = AccountLinkCreateParams.builder()
                    .setAccount(account.getId())
                    .setRefreshUrl(refreshUrl)
                    .setReturnUrl(returnUrl)
                    .setType(AccountLinkCreateParams.Type.ACCOUNT_ONBOARDING)
                    .build();

            AccountLink accountLink = AccountLink.create(linkParams);

            // Only save user after all Stripe operations succeed
            user.setStripeAccountId(account.getId());
            userRepository.save(user);

            return ConnectAccountResponse.builder()
                    .accountId(account.getId())
                    .onboardingUrl(accountLink.getUrl())
                    .build();

        } catch (StripeException e) {
            log.error("Failed to create Connect account", e);
            throw new BusinessRuleViolationException("Failed to create payment account: " + e.getMessage());
        }
    }

    @Transactional
    public CreatePaymentIntentResponse createPaymentIntent(User client, UUID dealId) {
        Deal deal = dealRepository.findByIdWithDetails(dealId)
                .orElseThrow(() -> new ResourceNotFoundException("Deal", "id", dealId));

        if (!deal.getClient().getId().equals(client.getId())) {
            throw new AccessDeniedException("Only the client can initiate payment");
        }

        if (deal.getStatus() != DealStatus.TERMS_ACCEPTED) {
            throw new BusinessRuleViolationException("Deal terms must be accepted before payment");
        }

        if (deal.getAgreedAmount() == null) {
            throw new BusinessRuleViolationException("Deal has no agreed amount");
        }

        Payment existingPayment = paymentRepository.findByDealId(dealId).orElse(null);
        if (existingPayment != null && existingPayment.getStatus() != PaymentStatus.FAILED) {
            throw new BusinessRuleViolationException("Payment already exists for this deal");
        }

        // Re-verify deal state to prevent race conditions
        Deal freshDeal = dealRepository.findByIdWithDetails(dealId)
                .orElseThrow(() -> new ResourceNotFoundException("Deal", "id", dealId));
        if (freshDeal.getStatus() != DealStatus.TERMS_ACCEPTED) {
            throw new BusinessRuleViolationException("Deal is no longer in a valid state for payment");
        }

        BigDecimal amount = deal.getAgreedAmount();
        BigDecimal platformFee = amount.multiply(stripeConfig.getPlatformFeePercent())
                .setScale(2, RoundingMode.HALF_UP);
        BigDecimal influencerPayout = amount.subtract(platformFee)
                .setScale(2, RoundingMode.HALF_UP);

        String idempotencyKey = "payment_intent_" + dealId + "_" + System.currentTimeMillis();

        try {
            PaymentIntentCreateParams params = PaymentIntentCreateParams.builder()
                    .setAmount(amount.setScale(2, RoundingMode.HALF_UP).multiply(new BigDecimal("100")).longValue())
                    .setCurrency("usd")
                    .setAutomaticPaymentMethods(
                            PaymentIntentCreateParams.AutomaticPaymentMethods.builder()
                                    .setEnabled(true)
                                    .build())
                    .putMetadata("deal_id", dealId.toString())
                    .setCaptureMethod(PaymentIntentCreateParams.CaptureMethod.MANUAL)
                    .build();

            PaymentIntent paymentIntent = PaymentIntent.create(params, com.stripe.net.RequestOptions.builder()
                    .setIdempotencyKey(idempotencyKey)
                    .build());

            Payment payment = existingPayment != null ? existingPayment : new Payment();
            payment.setDeal(deal);
            payment.setAmount(amount);
            payment.setPlatformFee(platformFee);
            payment.setInfluencerPayout(influencerPayout);
            payment.setStatus(PaymentStatus.PENDING);
            payment.setStripePaymentIntentId(paymentIntent.getId());
            payment = paymentRepository.save(payment);

            return CreatePaymentIntentResponse.builder()
                    .paymentId(payment.getId())
                    .clientSecret(paymentIntent.getClientSecret())
                    .paymentIntentId(paymentIntent.getId())
                    .build();

        } catch (StripeException e) {
            log.error("Failed to create payment intent", e);
            throw new BusinessRuleViolationException("Failed to initiate payment: " + e.getMessage());
        }
    }

    @Transactional
    public PaymentResponse capturePayment(User client, UUID dealId) {
        Payment payment = paymentRepository.findByDealId(dealId)
                .orElseThrow(() -> new ResourceNotFoundException("Payment", "dealId", dealId));

        // Authorization check - only the deal's client can capture payment
        if (!payment.getDeal().getClient().getId().equals(client.getId())) {
            throw new AccessDeniedException("Only the deal's client can capture payment");
        }

        if (payment.getStatus() != PaymentStatus.PENDING) {
            throw new BusinessRuleViolationException("Payment cannot be captured in current status: " + payment.getStatus());
        }

        try {
            PaymentIntent paymentIntent = PaymentIntent.retrieve(payment.getStripePaymentIntentId());
            paymentIntent.capture();

            payment.setStatus(PaymentStatus.ESCROW_HELD);
            payment = paymentRepository.save(payment);

            dealService.activateDeal(dealId);

            log.info("Payment captured for deal {}", dealId);
            return paymentMapper.toPaymentResponse(payment);

        } catch (StripeException e) {
            log.error("Failed to capture payment", e);
            payment.setStatus(PaymentStatus.FAILED);
            payment.setFailureReason(e.getMessage());
            paymentRepository.save(payment);
            throw new BusinessRuleViolationException("Failed to capture payment: " + e.getMessage());
        }
    }

    @Transactional
    public PaymentResponse releasePayment(User client, UUID dealId) {
        // Use pessimistic lock to prevent concurrent release attempts
        Payment payment = paymentRepository.findByDealIdForUpdate(dealId)
                .orElseThrow(() -> new ResourceNotFoundException("Payment", "dealId", dealId));

        Deal deal = payment.getDeal();

        if (!deal.getClient().getId().equals(client.getId())) {
            throw new AccessDeniedException("Only the client can release payment");
        }

        if (deal.getStatus() != DealStatus.COMPLETED) {
            throw new BusinessRuleViolationException("Deal must be completed before releasing payment");
        }

        if (payment.getStatus() != PaymentStatus.ESCROW_HELD) {
            throw new BusinessRuleViolationException("Payment is not in escrow");
        }

        User influencer = deal.getInfluencer();
        if (influencer.getStripeAccountId() == null) {
            throw new BusinessRuleViolationException("Influencer has not set up payment account");
        }

        String idempotencyKey = "transfer_" + payment.getId() + "_" + dealId;

        try {
            TransferCreateParams params = TransferCreateParams.builder()
                    .setAmount(payment.getInfluencerPayout().setScale(2, RoundingMode.HALF_UP)
                            .multiply(new BigDecimal("100")).longValue())
                    .setCurrency("usd")
                    .setDestination(influencer.getStripeAccountId())
                    .putMetadata("deal_id", dealId.toString())
                    .putMetadata("payment_id", payment.getId().toString())
                    .build();

            Transfer transfer = Transfer.create(params, com.stripe.net.RequestOptions.builder()
                    .setIdempotencyKey(idempotencyKey)
                    .build());

            payment.setStatus(PaymentStatus.RELEASED);
            payment.setStripeTransferId(transfer.getId());
            payment = paymentRepository.save(payment);

            log.info("Payment released for deal {}", dealId);
            return paymentMapper.toPaymentResponse(payment);

        } catch (StripeException e) {
            log.error("Failed to release payment", e);
            payment.setStatus(PaymentStatus.FAILED);
            payment.setFailureReason("Transfer failed: " + e.getMessage());
            paymentRepository.save(payment);
            throw new BusinessRuleViolationException("Failed to release payment: " + e.getMessage());
        }
    }

    @Transactional(readOnly = true)
    public PaymentResponse getPayment(User user, UUID dealId) {
        Deal deal = dealRepository.findByIdWithDetails(dealId)
                .orElseThrow(() -> new ResourceNotFoundException("Deal", "id", dealId));

        if (!deal.getClient().getId().equals(user.getId()) &&
                !deal.getInfluencer().getId().equals(user.getId())) {
            throw new AccessDeniedException("You don't have access to this payment");
        }

        Payment payment = paymentRepository.findByDealId(dealId)
                .orElseThrow(() -> new ResourceNotFoundException("Payment", "dealId", dealId));

        return paymentMapper.toPaymentResponse(payment);
    }

    /**
     * Internal method called by webhook after Stripe signature verification.
     * Skips user authorization since the webhook has already been verified.
     */
    @Transactional
    public void handlePaymentIntentSucceededInternal(String paymentIntentId) {
        Payment payment = paymentRepository.findByStripePaymentIntentId(paymentIntentId).orElse(null);
        if (payment != null && payment.getStatus() == PaymentStatus.PENDING) {
            capturePaymentInternal(payment);
        }
    }

    /**
     * Internal capture method that skips authorization.
     * Only called from verified webhook handlers.
     */
    private void capturePaymentInternal(Payment payment) {
        try {
            PaymentIntent paymentIntent = PaymentIntent.retrieve(payment.getStripePaymentIntentId());
            paymentIntent.capture();

            payment.setStatus(PaymentStatus.ESCROW_HELD);
            paymentRepository.save(payment);

            dealService.activateDeal(payment.getDeal().getId());

            log.info("Payment captured internally for deal {}", payment.getDeal().getId());

        } catch (StripeException e) {
            log.error("Failed to capture payment internally", e);
            payment.setStatus(PaymentStatus.FAILED);
            payment.setFailureReason(e.getMessage());
            paymentRepository.save(payment);
        }
    }

    @Transactional
    public void handlePaymentIntentFailed(String paymentIntentId, String failureMessage) {
        Payment payment = paymentRepository.findByStripePaymentIntentId(paymentIntentId).orElse(null);
        if (payment != null) {
            payment.setStatus(PaymentStatus.FAILED);
            payment.setFailureReason(failureMessage);
            paymentRepository.save(payment);
            log.warn("Payment failed for intent {}: {}", paymentIntentId, failureMessage);
        }
    }
}
