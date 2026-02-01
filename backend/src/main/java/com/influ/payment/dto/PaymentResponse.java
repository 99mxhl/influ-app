package com.influ.payment.dto;

import com.influ.payment.PaymentStatus;
import lombok.Builder;
import lombok.Getter;

import java.math.BigDecimal;
import java.time.Instant;
import java.util.UUID;

@Getter
@Builder
public class PaymentResponse {

    private UUID id;
    private UUID dealId;
    private BigDecimal amount;
    private BigDecimal platformFee;
    private BigDecimal influencerPayout;
    private PaymentStatus status;
    private String stripePaymentIntentId;
    private Instant createdAt;
    private Instant updatedAt;
}
