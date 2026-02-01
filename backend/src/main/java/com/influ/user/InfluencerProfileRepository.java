package com.influ.user;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.Optional;
import java.util.UUID;

public interface InfluencerProfileRepository extends JpaRepository<InfluencerProfile, UUID> {

    Optional<InfluencerProfile> findByUserId(UUID userId);

    @Query("""
        SELECT ip FROM InfluencerProfile ip
        JOIN FETCH ip.user u
        JOIN FETCH u.profile p
        WHERE u.deletedAt IS NULL
        ORDER BY ip.avgRating DESC NULLS LAST
    """)
    Page<InfluencerProfile> findAllActiveInfluencers(Pageable pageable);

    @Query("""
        SELECT ip FROM InfluencerProfile ip
        JOIN FETCH ip.user u
        JOIN FETCH u.profile p
        WHERE u.deletedAt IS NULL
        AND :category MEMBER OF ip.categories
        ORDER BY ip.avgRating DESC NULLS LAST
    """)
    Page<InfluencerProfile> findByCategory(String category, Pageable pageable);
}
