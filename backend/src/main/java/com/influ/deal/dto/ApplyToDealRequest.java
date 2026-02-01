package com.influ.deal.dto;

import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.util.UUID;

@Getter
@Setter
public class ApplyToDealRequest {

    @NotNull(message = "Campaign ID is required")
    private UUID campaignId;

    @DecimalMin(value = "0.01", message = "Proposed amount must be positive")
    private BigDecimal proposedAmount;

    @Size(max = 10000, message = "Deliverables must not exceed 10000 characters")
    private String deliverables;

    @Size(max = 5000, message = "Notes must not exceed 5000 characters")
    private String notes;
}
