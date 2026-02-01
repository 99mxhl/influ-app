package com.influ.payment.dto;

import lombok.Builder;
import lombok.Getter;

import java.util.UUID;

@Getter
@Builder
public class CreatePaymentIntentResponse {

    private UUID paymentId;
    private String clientSecret;
    private String paymentIntentId;
}
