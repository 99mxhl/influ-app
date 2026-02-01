package com.influ.deal.dto;

import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
public class ProposeTermsRequest {

    @NotNull(message = "Amount is required")
    @DecimalMin(value = "0.01", message = "Amount must be positive")
    private BigDecimal amount;

    @Size(max = 10000, message = "Deliverables must not exceed 10000 characters")
    private String deliverables;

    @Size(max = 5000, message = "Notes must not exceed 5000 characters")
    private String notes;
}
