package com.influ.chat.dto;

import com.influ.chat.MessageType;
import lombok.Builder;
import lombok.Getter;

import java.time.Instant;
import java.util.UUID;

@Getter
@Builder
public class MessageResponse {

    private UUID id;
    private UUID conversationId;
    private UUID senderId;
    private String senderDisplayName;
    private MessageType type;
    private String content;
    private UUID referenceId;
    private Instant createdAt;
    private Instant readAt;
}
