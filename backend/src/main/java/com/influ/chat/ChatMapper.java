package com.influ.chat;

import com.influ.chat.dto.MessageResponse;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface ChatMapper {

    @Mapping(target = "conversationId", source = "conversation.id")
    @Mapping(target = "senderId", source = "sender.id")
    @Mapping(target = "senderDisplayName", source = "sender.profile.displayName")
    MessageResponse toMessageResponse(Message message);
}
