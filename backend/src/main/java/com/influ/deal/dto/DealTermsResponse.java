package com.influ.deal.dto;

import com.fasterxml.jackson.databind.JsonNode;
import com.influ.deal.DealTermsStatus;
import lombok.Builder;
import lombok.Getter;

import java.math.BigDecimal;
import java.time.Instant;
import java.util.UUID;

@Getter
@Builder
public class DealTermsResponse {

    private UUID id;
    private UUID dealId;
    private Integer version;
    private UUID proposedById;
    private String proposedByDisplayName;
    private BigDecimal amount;
    private JsonNode deliverables;  // Parsed JSON array, not a string
    private String notes;
    private DealTermsStatus status;
    private Instant createdAt;
}
