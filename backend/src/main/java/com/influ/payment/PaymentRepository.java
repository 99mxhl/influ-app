package com.influ.payment;

import jakarta.persistence.LockModeType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Lock;
import org.springframework.data.jpa.repository.Query;

import java.util.Optional;
import java.util.UUID;

public interface PaymentRepository extends JpaRepository<Payment, UUID> {

    Optional<Payment> findByDealId(UUID dealId);

    Optional<Payment> findByStripePaymentIntentId(String paymentIntentId);

    @Query("""
        SELECT p FROM Payment p
        JOIN FETCH p.deal d
        JOIN FETCH d.influencer
        JOIN FETCH d.client
        WHERE p.id = :id
    """)
    Optional<Payment> findByIdWithDeal(UUID id);

    @Lock(LockModeType.PESSIMISTIC_WRITE)
    @Query("""
        SELECT p FROM Payment p
        JOIN FETCH p.deal d
        JOIN FETCH d.influencer i
        LEFT JOIN FETCH i.profile
        JOIN FETCH d.client
        WHERE p.deal.id = :dealId AND p.deletedAt IS NULL
    """)
    Optional<Payment> findByDealIdForUpdate(UUID dealId);
}
