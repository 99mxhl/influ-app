package com.influ.deal.dto;

import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.util.UUID;

@Getter
@Setter
public class InviteToDealRequest {

    @NotNull(message = "Campaign ID is required")
    private UUID campaignId;

    @NotNull(message = "Influencer ID is required")
    private UUID influencerId;

    @DecimalMin(value = "0.01", message = "Proposed amount must be positive")
    private BigDecimal proposedAmount;

    private String deliverables;

    private String notes;
}
