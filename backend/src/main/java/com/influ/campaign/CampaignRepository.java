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
        JOIN FETCH c.client
        WHERE c.id = :id AND c.deletedAt IS NULL
    """)
    Optional<Campaign> findByIdWithClient(UUID id);

    @Query("""
        SELECT c FROM Campaign c
        WHERE c.client.id = :clientId AND c.deletedAt IS NULL
        ORDER BY c.createdAt DESC
    """)
    Page<Campaign> findByClientId(UUID clientId, Pageable pageable);

    @Query("""
        SELECT c FROM Campaign c
        WHERE c.status = :status AND c.deletedAt IS NULL
        ORDER BY c.createdAt DESC
    """)
    Page<Campaign> findByStatus(CampaignStatus status, Pageable pageable);

    @Query("""
        SELECT c FROM Campaign c
        WHERE c.status = 'ACTIVE' AND c.deletedAt IS NULL
        ORDER BY c.createdAt DESC
    """)
    Page<Campaign> findAllActive(Pageable pageable);

    @Query("""
        SELECT c FROM Campaign c
        WHERE c.deletedAt IS NULL
        ORDER BY c.createdAt DESC
    """)
    Page<Campaign> findAllNotDeleted(Pageable pageable);
}
