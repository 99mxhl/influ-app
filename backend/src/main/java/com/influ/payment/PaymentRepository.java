package com.influ.payment;

import org.springframework.data.jpa.repository.JpaRepository;
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
}
