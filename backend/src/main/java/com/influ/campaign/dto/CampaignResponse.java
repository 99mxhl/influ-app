package com.influ.campaign.dto;

import com.influ.campaign.CampaignStatus;
import com.influ.campaign.Platform;
import lombok.Builder;
import lombok.Getter;

import java.math.BigDecimal;
import java.time.Instant;
import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

@Getter
@Builder
public class CampaignResponse {

    private UUID id;
    private UUID clientId;
    private String clientDisplayName;
    private String title;
    private String description;
    private BigDecimal budgetMin;
    private BigDecimal budgetMax;
    private CampaignStatus status;
    private LocalDate startDate;
    private LocalDate endDate;
    private List<String> categories;
    private List<Platform> platforms;
    private String requirements;
    private String targetAudience;
    private Instant createdAt;
    private Instant updatedAt;
}
