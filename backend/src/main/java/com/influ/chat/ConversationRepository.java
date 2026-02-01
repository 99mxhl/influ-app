package com.influ.chat;

import com.influ.chat.dto.ConversationWithStats;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
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

    /**
     * Fetches conversations with stats (last message, unread count) in a single query.
     * Avoids N+1 problem in getUserConversations.
     */
    @Query(value = """
        SELECT
            c.id as conversationId,
            c.created_at as conversationCreatedAt,
            d.id as dealId,
            camp.title as dealTitle,
            i.id as influencerId,
            ip.display_name as influencerDisplayName,
            cl.id as clientId,
            clp.display_name as clientDisplayName,
            lm.id as lastMessageId,
            lm.sender_id as lastMessageSenderId,
            lmp.display_name as lastMessageSenderDisplayName,
            lm.type as lastMessageType,
            lm.content as lastMessageContent,
            lm.created_at as lastMessageCreatedAt,
            COALESCE(unread.cnt, 0) as unreadCount
        FROM conversations c
        JOIN deals d ON c.deal_id = d.id
        JOIN campaigns camp ON d.campaign_id = camp.id
        JOIN users i ON d.influencer_id = i.id
        LEFT JOIN profiles ip ON i.id = ip.user_id
        JOIN users cl ON d.client_id = cl.id
        LEFT JOIN profiles clp ON cl.id = clp.user_id
        LEFT JOIN LATERAL (
            SELECT m.id, m.sender_id, m.type, m.content, m.created_at
            FROM messages m
            WHERE m.conversation_id = c.id AND m.deleted_at IS NULL
            ORDER BY m.created_at DESC
            LIMIT 1
        ) lm ON true
        LEFT JOIN profiles lmp ON lm.sender_id = lmp.user_id
        LEFT JOIN LATERAL (
            SELECT COUNT(*) as cnt
            FROM messages m
            WHERE m.conversation_id = c.id
              AND m.read_at IS NULL
              AND m.deleted_at IS NULL
              AND (m.sender_id IS NULL OR m.sender_id != :userId)
        ) unread ON true
        WHERE (d.influencer_id = :userId OR d.client_id = :userId)
          AND c.deleted_at IS NULL
          AND d.deleted_at IS NULL
        ORDER BY COALESCE(lm.created_at, c.created_at) DESC
        LIMIT :limit OFFSET :offset
        """, nativeQuery = true)
    List<ConversationWithStats> findByUserIdWithStats(UUID userId, int limit, int offset);

    @Query(value = """
        SELECT COUNT(*)
        FROM conversations c
        JOIN deals d ON c.deal_id = d.id
        WHERE (d.influencer_id = :userId OR d.client_id = :userId)
          AND c.deleted_at IS NULL
          AND d.deleted_at IS NULL
        """, nativeQuery = true)
    long countByUserId(UUID userId);

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
