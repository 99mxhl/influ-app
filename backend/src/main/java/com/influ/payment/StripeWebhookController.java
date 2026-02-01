package com.influ.payment;

import com.influ.config.StripeConfig;
import com.stripe.exception.SignatureVerificationException;
import com.stripe.model.Event;
import com.stripe.model.PaymentIntent;
import com.stripe.net.Webhook;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RestController
@RequestMapping("/api/webhooks")
@RequiredArgsConstructor
public class StripeWebhookController {

    private static final String EVENT_PAYMENT_INTENT_SUCCEEDED = "payment_intent.succeeded";
    private static final String EVENT_PAYMENT_INTENT_FAILED = "payment_intent.payment_failed";

    private final StripeConfig stripeConfig;
    private final StripeEventRepository stripeEventRepository;
    private final PaymentService paymentService;

    @PostMapping("/stripe")
    public ResponseEntity<String> handleStripeWebhook(
            @RequestBody String payload,
            @RequestHeader("Stripe-Signature") String sigHeader) {

        Event event;
        try {
            event = Webhook.constructEvent(payload, sigHeader, stripeConfig.getWebhookSecret());
        } catch (SignatureVerificationException e) {
            log.warn("Invalid Stripe signature: {}", e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Invalid signature");
        }

        // Idempotency: Save event first to prevent race condition (unique constraint on event_id)
        try {
            stripeEventRepository.save(new StripeEvent(event.getId(), event.getType()));
        } catch (DataIntegrityViolationException e) {
            log.info("Duplicate event received: {}", event.getId());
            return ResponseEntity.ok("Event already processed");
        }

        try {
            handleEvent(event);
            return ResponseEntity.ok("Event processed");

        } catch (Exception e) {
            log.error("Error processing webhook event: {}", event.getId(), e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Processing error");
        }
    }

    private void handleEvent(Event event) {
        switch (event.getType()) {
            case EVENT_PAYMENT_INTENT_SUCCEEDED -> {
                PaymentIntent paymentIntent = (PaymentIntent) event.getDataObjectDeserializer()
                        .getObject().orElse(null);
                if (paymentIntent != null) {
                    log.info("Payment succeeded: {}", paymentIntent.getId());
                    paymentService.handlePaymentIntentSucceededInternal(paymentIntent.getId());
                }
            }
            case EVENT_PAYMENT_INTENT_FAILED -> {
                PaymentIntent paymentIntent = (PaymentIntent) event.getDataObjectDeserializer()
                        .getObject().orElse(null);
                if (paymentIntent != null) {
                    String failureMessage = paymentIntent.getLastPaymentError() != null
                            ? paymentIntent.getLastPaymentError().getMessage()
                            : "Payment failed";
                    log.warn("Payment failed: {} - {}", paymentIntent.getId(), failureMessage);
                    paymentService.handlePaymentIntentFailed(paymentIntent.getId(), failureMessage);
                }
            }
            default -> log.debug("Unhandled event type: {}", event.getType());
        }
    }
}
