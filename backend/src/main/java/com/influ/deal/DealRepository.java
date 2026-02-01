package com.influ.deal;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.Optional;
import java.util.UUID;

public interface DealRepository extends JpaRepository<Deal, UUID> {

    @Query("""
        SELECT d FROM Deal d
        JOIN FETCH d.campaign
        JOIN FETCH d.influencer i
        LEFT JOIN FETCH i.profile
        JOIN FETCH d.client c
        LEFT JOIN FETCH c.profile
        LEFT JOIN FETCH d.termsList t
        LEFT JOIN FETCH t.proposedBy pb
        LEFT JOIN FETCH pb.profile
        WHERE d.id = :id
    """)
    Optional<Deal> findByIdWithDetails(UUID id);

    @Query("""
        SELECT d FROM Deal d
        WHERE d.influencer.id = :influencerId AND d.deletedAt IS NULL
        ORDER BY d.createdAt DESC
    """)
    Page<Deal> findByInfluencerId(UUID influencerId, Pageable pageable);

    @Query("""
        SELECT d FROM Deal d
        WHERE d.client.id = :clientId AND d.deletedAt IS NULL
        ORDER BY d.createdAt DESC
    """)
    Page<Deal> findByClientId(UUID clientId, Pageable pageable);

    @Query("""
        SELECT d FROM Deal d
        WHERE d.campaign.id = :campaignId AND d.deletedAt IS NULL
        ORDER BY d.createdAt DESC
    """)
    Page<Deal> findByCampaignId(UUID campaignId, Pageable pageable);

    @Query("""
        SELECT d FROM Deal d
        WHERE (d.influencer.id = :userId OR d.client.id = :userId) AND d.deletedAt IS NULL
        ORDER BY d.createdAt DESC
    """)
    Page<Deal> findByUserId(UUID userId, Pageable pageable);

    @Query("""
        SELECT CASE WHEN COUNT(d) > 0 THEN true ELSE false END
        FROM Deal d
        WHERE d.campaign.id = :campaignId
        AND d.influencer.id = :influencerId
        AND d.deletedAt IS NULL
        AND d.status NOT IN ('CANCELLED', 'COMPLETED')
    """)
    boolean existsActiveDeal(UUID campaignId, UUID influencerId);
}
