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

    @Query("""
        SELECT c FROM Campaign c
        JOIN FETCH c.client cl
        JOIN FETCH cl.profile
        WHERE c.client.id = :clientId
        ORDER BY c.createdAt DESC
    """)
    Page<Campaign> findByClientId(UUID clientId, Pageable pageable);

    @Query("""
        SELECT c FROM Campaign c
        JOIN FETCH c.client cl
        JOIN FETCH cl.profile
        WHERE c.status = :status
        ORDER BY c.createdAt DESC
    """)
    Page<Campaign> findByStatus(CampaignStatus status, Pageable pageable);

    @Query("""
        SELECT c FROM Campaign c
        JOIN FETCH c.client cl
        JOIN FETCH cl.profile
        WHERE c.status = 'ACTIVE'
        ORDER BY c.createdAt DESC
    """)
    Page<Campaign> findAllActive(Pageable pageable);

    @Query("""
        SELECT c FROM Campaign c
        JOIN FETCH c.client cl
        JOIN FETCH cl.profile
        ORDER BY c.createdAt DESC
    """)
    Page<Campaign> findAllNotDeleted(Pageable pageable);
}
