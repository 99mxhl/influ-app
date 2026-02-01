package com.influ.chat.dto;

import com.influ.chat.MessageType;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

import java.util.UUID;

@Getter
@Setter
public class SendMessageRequest {

    @NotBlank(message = "Content is required")
    @Size(min = 1, max = 5000, message = "Message must be between 1 and 5000 characters")
    private String content;

    private MessageType type = MessageType.TEXT;

    private UUID referenceId;
}
