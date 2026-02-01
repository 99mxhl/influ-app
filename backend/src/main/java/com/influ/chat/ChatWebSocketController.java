package com.influ.chat;

import com.influ.chat.dto.MessageResponse;
import com.influ.chat.dto.SendMessageRequest;
import com.influ.common.exception.ResourceNotFoundException;
import com.influ.deal.Deal;
import com.influ.deal.DealRepository;
import com.influ.user.User;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;

import java.util.UUID;

@Slf4j
@Controller
@RequiredArgsConstructor
public class ChatWebSocketController {

    private final ChatService chatService;
    private final DealRepository dealRepository;
    private final SimpMessagingTemplate messagingTemplate;

    @MessageMapping("/chat/{dealId}")
    public void sendMessage(
            @DestinationVariable UUID dealId,
            @Payload SendMessageRequest request,
            Authentication authentication) {

        User user = (User) authentication.getPrincipal();
        Deal deal = dealRepository.findByIdWithDetails(dealId)
                .orElseThrow(() -> new ResourceNotFoundException("Deal", "id", dealId));

        if (!deal.getInfluencer().getId().equals(user.getId()) &&
                !deal.getClient().getId().equals(user.getId())) {
            throw new AccessDeniedException("You don't have access to this conversation");
        }

        MessageResponse message = chatService.sendMessage(user, dealId, request);

        // Send to both participants
        String destination = "/topic/deal." + dealId;
        messagingTemplate.convertAndSend(destination, message);

        log.debug("Message sent to deal {} by user {}", dealId, user.getEmail());
    }

    public void broadcastToConversation(UUID dealId, MessageResponse message) {
        String destination = "/topic/deal." + dealId;
        messagingTemplate.convertAndSend(destination, message);
    }
}
