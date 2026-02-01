package com.influ.chat;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.Optional;
import java.util.UUID;

public interface ConversationRepository extends JpaRepository<Conversation, UUID> {

    @Query("""
        SELECT c FROM Conversation c
        JOIN FETCH c.deal d
        JOIN FETCH d.influencer i
        LEFT JOIN FETCH i.profile
        JOIN FETCH d.client cl
        LEFT JOIN FETCH cl.profile
        JOIN FETCH d.campaign
        WHERE d.influencer.id = :userId OR d.client.id = :userId
        ORDER BY c.updatedAt DESC
    """)
    Page<Conversation> findByUserId(UUID userId, Pageable pageable);

    @Query("""
        SELECT c FROM Conversation c
        JOIN FETCH c.deal d
        JOIN FETCH d.influencer
        JOIN FETCH d.client
        WHERE c.deal.id = :dealId
    """)
    Optional<Conversation> findByDealId(UUID dealId);

    @Query("""
        SELECT c FROM Conversation c
        JOIN FETCH c.deal d
        JOIN FETCH d.influencer
        JOIN FETCH d.client
        WHERE c.id = :id
    """)
    Optional<Conversation> findByIdWithDeal(UUID id);

    boolean existsByDealId(UUID dealId);
}
