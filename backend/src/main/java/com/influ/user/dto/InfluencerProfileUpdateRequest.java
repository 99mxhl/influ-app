package com.influ.user.dto;

import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.util.List;

@Getter
@Setter
public class InfluencerProfileUpdateRequest {

    @Size(max = 10, message = "Cannot have more than 10 categories")
    private List<@Size(max = 50, message = "Category name must be at most 50 characters") String> categories;

    @DecimalMin(value = "0.0", message = "Base rate must be positive")
    private BigDecimal baseRate;

    @Size(max = 100, message = "Handle must be at most 100 characters")
    @Pattern(regexp = "^[a-zA-Z0-9._]*$", message = "Handle contains invalid characters")
    private String instagramHandle;

    @Min(value = 0, message = "Followers count must be positive")
    private Integer instagramFollowers;

    @Size(max = 100, message = "Handle must be at most 100 characters")
    @Pattern(regexp = "^[a-zA-Z0-9._]*$", message = "Handle contains invalid characters")
    private String tiktokHandle;

    @Min(value = 0, message = "Followers count must be positive")
    private Integer tiktokFollowers;

    @Size(max = 100, message = "Handle must be at most 100 characters")
    @Pattern(regexp = "^[a-zA-Z0-9._]*$", message = "Handle contains invalid characters")
    private String youtubeHandle;

    @Min(value = 0, message = "Followers count must be positive")
    private Integer youtubeFollowers;

    @Size(max = 100, message = "Handle must be at most 100 characters")
    @Pattern(regexp = "^[a-zA-Z0-9._]*$", message = "Handle contains invalid characters")
    private String twitterHandle;

    @Min(value = 0, message = "Followers count must be positive")
    private Integer twitterFollowers;
}
