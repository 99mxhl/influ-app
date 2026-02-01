package com.influ.campaign.dto;

import com.influ.campaign.CampaignStatus;
import com.influ.campaign.Platform;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

@Getter
@Setter
public class CreateCampaignRequest {

    @NotBlank(message = "Title is required")
    @Size(max = 200, message = "Title must be at most 200 characters")
    private String title;

    @Size(max = 2000, message = "Description must be at most 2000 characters")
    private String description;

    @DecimalMin(value = "0.0", message = "Budget must be positive")
    private BigDecimal budgetMin;

    @DecimalMin(value = "0.0", message = "Budget must be positive")
    private BigDecimal budgetMax;

    private CampaignStatus status;

    private LocalDate startDate;

    private LocalDate endDate;

    @Size(max = 10, message = "Cannot have more than 10 categories")
    private List<String> categories;

    @Size(max = 6, message = "Cannot have more than 6 platforms")
    private List<Platform> platforms;

    @Size(max = 2000, message = "Requirements must be at most 2000 characters")
    private String requirements;

    @Size(max = 1000, message = "Target audience must be at most 1000 characters")
    private String targetAudience;
}
