package com.influ.user.dto;

import lombok.Builder;
import lombok.Getter;

import java.math.BigDecimal;
import java.util.List;

@Getter
@Builder
public class InfluencerProfileResponse {

    private List<String> categories;
    private BigDecimal baseRate;
    private String instagramHandle;
    private Integer instagramFollowers;
    private String tiktokHandle;
    private Integer tiktokFollowers;
    private String youtubeHandle;
    private Integer youtubeFollowers;
    private String twitterHandle;
    private Integer twitterFollowers;
    private BigDecimal avgRating;
    private Integer totalRatings;
    private Integer completedDeals;
}
