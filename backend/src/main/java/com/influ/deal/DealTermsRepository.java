package com.influ.deal;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface DealTermsRepository extends JpaRepository<DealTerms, UUID> {

    @Query("""
        SELECT dt FROM DealTerms dt
        WHERE dt.deal.id = :dealId
        ORDER BY dt.version DESC
    """)
    List<DealTerms> findByDealIdOrderByVersionDesc(UUID dealId);

    @Query("""
        SELECT dt FROM DealTerms dt
        WHERE dt.deal.id = :dealId AND dt.status = 'PROPOSED'
        ORDER BY dt.version DESC
        LIMIT 1
    """)
    Optional<DealTerms> findLatestProposedByDealId(UUID dealId);

    @Query(value = "SELECT COALESCE(MAX(version), 0) + 1 FROM deal_terms WHERE deal_id = :dealId FOR UPDATE", nativeQuery = true)
    Integer getNextVersion(UUID dealId);
}
