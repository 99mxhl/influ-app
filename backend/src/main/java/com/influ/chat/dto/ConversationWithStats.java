package com.influ.chat.dto;

import java.time.Instant;
import java.util.UUID;

/**
 * Projection interface for conversation with pre-computed stats.
 * Used to avoid N+1 queries when fetching user conversations.
 */
public interface ConversationWithStats {
    UUID getConversationId();
    Instant getConversationCreatedAt();
    UUID getDealId();
    String getDealTitle();
    UUID getInfluencerId();
    String getInfluencerDisplayName();
    UUID getClientId();
    String getClientDisplayName();

    // Last message fields
    UUID getLastMessageId();
    UUID getLastMessageSenderId();
    String getLastMessageSenderDisplayName();
    String getLastMessageType();
    String getLastMessageContent();
    Instant getLastMessageCreatedAt();

    // Stats
    Long getUnreadCount();
}
