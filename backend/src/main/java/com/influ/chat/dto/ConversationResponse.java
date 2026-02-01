package com.influ.chat.dto;

import lombok.Builder;
import lombok.Getter;

import java.time.Instant;
import java.util.UUID;

@Getter
@Builder
public class ConversationResponse {

    private UUID id;
    private UUID dealId;
    private String dealTitle;
    private UUID influencerId;
    private String influencerDisplayName;
    private UUID clientId;
    private String clientDisplayName;
    private MessageResponse lastMessage;
    private long unreadCount;
    private Instant createdAt;
}
