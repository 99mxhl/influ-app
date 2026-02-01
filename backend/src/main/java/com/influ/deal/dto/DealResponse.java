package com.influ.deal.dto;

import com.influ.deal.DealStatus;
import lombok.Builder;
import lombok.Getter;

import java.math.BigDecimal;
import java.time.Instant;
import java.util.List;
import java.util.UUID;

@Getter
@Builder
public class DealResponse {

    private UUID id;
    private UUID campaignId;
    private String campaignTitle;
    private UUID influencerId;
    private String influencerDisplayName;
    private UUID clientId;
    private String clientDisplayName;
    private DealStatus status;
    private BigDecimal agreedAmount;
    private BigDecimal platformFee;
    private String notes;
    private DealTermsResponse currentTerms;
    private List<DeliverableResponse> deliverables;
    private Instant createdAt;
    private Instant updatedAt;
}
