package com.influ.payment;

import com.influ.common.dto.ApiResponse;
import com.influ.payment.dto.ConnectAccountResponse;
import com.influ.payment.dto.CreatePaymentIntentResponse;
import com.influ.payment.dto.PaymentResponse;
import com.influ.user.User;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequestMapping("/api/payments")
@RequiredArgsConstructor
@Tag(name = "Payments", description = "Payment management endpoints")
public class PaymentController {

    private final PaymentService paymentService;

    @PostMapping("/connect-account")
    @Operation(summary = "Create Stripe Connect account for influencer")
    public ApiResponse<ConnectAccountResponse> createConnectAccount(
            @AuthenticationPrincipal User user,
            @RequestParam String returnUrl,
            @RequestParam String refreshUrl) {
        return ApiResponse.success(paymentService.createConnectAccount(user, returnUrl, refreshUrl));
    }

    @PostMapping("/{dealId}/intent")
    @Operation(summary = "Create payment intent for a deal")
    public ApiResponse<CreatePaymentIntentResponse> createPaymentIntent(
            @AuthenticationPrincipal User client,
            @PathVariable UUID dealId) {
        return ApiResponse.success(paymentService.createPaymentIntent(client, dealId));
    }

    @PostMapping("/{dealId}/capture")
    @Operation(summary = "Capture payment (hold in escrow)")
    public ApiResponse<PaymentResponse> capturePayment(@PathVariable UUID dealId) {
        return ApiResponse.success(paymentService.capturePayment(dealId));
    }

    @PostMapping("/{dealId}/release")
    @Operation(summary = "Release payment to influencer")
    public ApiResponse<PaymentResponse> releasePayment(
            @AuthenticationPrincipal User client,
            @PathVariable UUID dealId) {
        return ApiResponse.success(paymentService.releasePayment(client, dealId));
    }

    @GetMapping("/{dealId}")
    @Operation(summary = "Get payment status for a deal")
    public ApiResponse<PaymentResponse> getPayment(
            @AuthenticationPrincipal User user,
            @PathVariable UUID dealId) {
        return ApiResponse.success(paymentService.getPayment(user, dealId));
    }
}
