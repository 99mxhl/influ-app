package com.influ.user.dto;

import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.util.List;

@Getter
@Setter
public class InfluencerProfileUpdateRequest {

    @Size(max = 10, message = "Cannot have more than 10 categories")
    private List<String> categories;

    @DecimalMin(value = "0.0", message = "Base rate must be positive")
    private BigDecimal baseRate;

    private String instagramHandle;
    private Integer instagramFollowers;

    private String tiktokHandle;
    private Integer tiktokFollowers;

    private String youtubeHandle;
    private Integer youtubeFollowers;

    private String twitterHandle;
    private Integer twitterFollowers;
}
