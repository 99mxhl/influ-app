package com.influ.chat;

import com.influ.common.entity.BaseEntity;
import com.influ.user.User;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.SQLRestriction;

import java.util.UUID;

@Entity
@Table(name = "messages")
@SQLRestriction("deleted_at IS NULL")
@Getter
@Setter
@NoArgsConstructor
public class Message extends BaseEntity {

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "conversation_id", nullable = false)
    private Conversation conversation;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "sender_id")
    private User sender;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private MessageType type = MessageType.TEXT;

    @Column(nullable = false, columnDefinition = "TEXT")
    private String content;

    @Column(name = "reference_id")
    private UUID referenceId;

    @Column(name = "read_at")
    private java.time.Instant readAt;

    public Message(Conversation conversation, User sender, MessageType type, String content) {
        this.conversation = conversation;
        this.sender = sender;
        this.type = type;
        this.content = content;
    }

    public static Message systemMessage(Conversation conversation, String content) {
        Message message = new Message();
        message.setConversation(conversation);
        message.setType(MessageType.SYSTEM);
        message.setContent(content);
        return message;
    }
}
