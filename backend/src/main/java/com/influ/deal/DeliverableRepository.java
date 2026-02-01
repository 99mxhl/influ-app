package com.influ.deal;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface DeliverableRepository extends JpaRepository<Deliverable, UUID> {

    @Query("""
        SELECT d FROM Deliverable d
        WHERE d.deal.id = :dealId AND d.deletedAt IS NULL
        ORDER BY d.createdAt ASC
    """)
    List<Deliverable> findByDealId(UUID dealId);

    @Query("""
        SELECT d FROM Deliverable d
        JOIN FETCH d.deal
        WHERE d.id = :id AND d.deletedAt IS NULL
    """)
    Optional<Deliverable> findByIdWithDeal(UUID id);

    @Query("""
        SELECT CASE WHEN COUNT(d) > 0 THEN true ELSE false END
        FROM Deliverable d
        WHERE d.deal.id = :dealId
        AND d.status NOT IN ('APPROVED')
        AND d.deletedAt IS NULL
    """)
    boolean hasUncompletedDeliverables(UUID dealId);

    @Query("""
        SELECT COUNT(d)
        FROM Deliverable d
        WHERE d.deal.id = :dealId
        AND d.status = 'APPROVED'
        AND d.deletedAt IS NULL
    """)
    long countApprovedDeliverables(UUID dealId);

    @Query("""
        SELECT COUNT(d)
        FROM Deliverable d
        WHERE d.deal.id = :dealId
        AND d.deletedAt IS NULL
    """)
    long countTotalDeliverables(UUID dealId);
}
