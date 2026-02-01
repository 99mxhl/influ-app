package com.influ.user;

import com.influ.common.entity.BaseEntity;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "influencer_profiles")
@Getter
@Setter
@NoArgsConstructor
public class InfluencerProfile extends BaseEntity {

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false, unique = true)
    private User user;

    @ElementCollection(fetch = FetchType.EAGER)
    @CollectionTable(name = "influencer_categories", joinColumns = @JoinColumn(name = "influencer_profile_id"))
    @Column(name = "category")
    private List<String> categories = new ArrayList<>();

    @Column(name = "base_rate", precision = 10, scale = 2)
    private BigDecimal baseRate;

    @Column(name = "instagram_handle")
    private String instagramHandle;

    @Column(name = "instagram_followers")
    private Integer instagramFollowers;

    @Column(name = "tiktok_handle")
    private String tiktokHandle;

    @Column(name = "tiktok_followers")
    private Integer tiktokFollowers;

    @Column(name = "youtube_handle")
    private String youtubeHandle;

    @Column(name = "youtube_followers")
    private Integer youtubeFollowers;

    @Column(name = "twitter_handle")
    private String twitterHandle;

    @Column(name = "twitter_followers")
    private Integer twitterFollowers;

    @Column(name = "avg_rating", precision = 3, scale = 2)
    private BigDecimal avgRating;

    @Column(name = "total_ratings")
    private Integer totalRatings = 0;

    @Column(name = "total_earnings", precision = 12, scale = 2)
    private BigDecimal totalEarnings = BigDecimal.ZERO;

    @Column(name = "completed_deals")
    private Integer completedDeals = 0;
}
