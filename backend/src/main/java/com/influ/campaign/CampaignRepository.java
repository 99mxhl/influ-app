package com.influ.campaign;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.Optional;
import java.util.UUID;

public interface CampaignRepository extends JpaRepository<Campaign, UUID> {

    @Query("""
        SELECT c FROM Campaign c
        JOIN FETCH c.client cl
        JOIN FETCH cl.profile
        WHERE c.id = :id
    """)
    Optional<Campaign> findByIdWithClient(UUID id);

    // Paginated queries use simple queries without JOIN FETCH to avoid in-memory pagination
    Page<Campaign> findByClientIdOrderByCreatedAtDesc(UUID clientId, Pageable pageable);

    Page<Campaign> findByStatusOrderByCreatedAtDesc(CampaignStatus status, Pageable pageable);
}
