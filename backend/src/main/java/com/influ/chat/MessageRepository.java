package com.influ.chat;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import java.time.Instant;
import java.util.UUID;

public interface MessageRepository extends JpaRepository<Message, UUID> {

    @Query("""
        SELECT m FROM Message m
        LEFT JOIN FETCH m.sender
        WHERE m.conversation.id = :conversationId
        ORDER BY m.createdAt DESC
    """)
    Page<Message> findByConversationId(UUID conversationId, Pageable pageable);

    @Query("""
        SELECT m FROM Message m
        LEFT JOIN FETCH m.sender
        WHERE m.conversation.deal.id = :dealId
        ORDER BY m.createdAt DESC
    """)
    Page<Message> findByDealId(UUID dealId, Pageable pageable);

    @Modifying(clearAutomatically = true)
    @Query("""
        UPDATE Message m
        SET m.readAt = :readAt
        WHERE m.conversation.id = :conversationId
        AND m.sender.id != :userId
        AND m.readAt IS NULL
    """)
    void markAsRead(UUID conversationId, UUID userId, Instant readAt);

    @Query("""
        SELECT COUNT(m)
        FROM Message m
        WHERE m.conversation.id = :conversationId
        AND m.sender.id != :userId
        AND m.readAt IS NULL
    """)
    long countUnread(UUID conversationId, UUID userId);
}
