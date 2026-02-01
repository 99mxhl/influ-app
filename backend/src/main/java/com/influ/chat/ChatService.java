package com.influ.chat;

import com.influ.chat.dto.ConversationResponse;
import com.influ.chat.dto.MessageResponse;
import com.influ.chat.dto.SendMessageRequest;
import com.influ.common.dto.PageResponse;
import com.influ.common.exception.ResourceNotFoundException;
import com.influ.deal.Deal;
import com.influ.deal.DealRepository;
import com.influ.user.User;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class ChatService {

    private final ConversationRepository conversationRepository;
    private final MessageRepository messageRepository;
    private final DealRepository dealRepository;
    private final ChatMapper chatMapper;

    @Transactional
    public Conversation getOrCreateConversation(UUID dealId) {
        return conversationRepository.findByDealId(dealId)
                .orElseGet(() -> {
                    Deal deal = dealRepository.findByIdWithDetails(dealId)
                            .orElseThrow(() -> new ResourceNotFoundException("Deal", "id", dealId));
                    Conversation conversation = new Conversation(deal);
                    return conversationRepository.save(conversation);
                });
    }

    @Transactional
    public MessageResponse sendMessage(User sender, UUID dealId, SendMessageRequest request) {
        Deal deal = getDealWithAccess(dealId, sender);
        Conversation conversation = getOrCreateConversation(dealId);

        Message message = new Message();
        message.setConversation(conversation);
        message.setSender(sender);
        message.setType(request.getType() != null ? request.getType() : MessageType.TEXT);
        message.setContent(request.getContent());
        message.setReferenceId(request.getReferenceId());
        message = messageRepository.save(message);

        return chatMapper.toMessageResponse(message);
    }

    @Transactional
    public MessageResponse sendSystemMessage(UUID dealId, String content) {
        Conversation conversation = getOrCreateConversation(dealId);
        Message message = Message.systemMessage(conversation, content);
        message = messageRepository.save(message);
        return chatMapper.toMessageResponse(message);
    }

    @Transactional(readOnly = true)
    public PageResponse<MessageResponse> getMessages(User user, UUID dealId, Pageable pageable) {
        getDealWithAccess(dealId, user);

        Page<Message> messages = messageRepository.findByDealId(dealId, pageable);
        return PageResponse.from(
                messages,
                messages.getContent().stream()
                        .map(chatMapper::toMessageResponse)
                        .toList()
        );
    }

    @Transactional
    public void markAsRead(User user, UUID dealId) {
        Deal deal = getDealWithAccess(dealId, user);
        Conversation conversation = conversationRepository.findByDealId(dealId).orElse(null);
        if (conversation != null) {
            messageRepository.markAsRead(conversation.getId(), user.getId(), Instant.now());
        }
    }

    @Transactional(readOnly = true)
    public ConversationResponse getConversation(User user, UUID dealId) {
        Deal deal = getDealWithAccess(dealId, user);
        Conversation conversation = conversationRepository.findByDealId(dealId)
                .orElseGet(() -> {
                    Conversation newConv = new Conversation(deal);
                    return conversationRepository.save(newConv);
                });

        Page<Message> lastMessagePage = messageRepository.findByDealId(dealId, Pageable.ofSize(1));
        MessageResponse lastMessage = lastMessagePage.hasContent()
                ? chatMapper.toMessageResponse(lastMessagePage.getContent().get(0))
                : null;

        long unreadCount = conversation.getId() != null
                ? messageRepository.countUnread(conversation.getId(), user.getId())
                : 0;

        return ConversationResponse.builder()
                .id(conversation.getId())
                .dealId(deal.getId())
                .dealTitle(deal.getCampaign().getTitle())
                .influencerId(deal.getInfluencer().getId())
                .influencerDisplayName(deal.getInfluencer().getProfile() != null
                        ? deal.getInfluencer().getProfile().getDisplayName() : null)
                .clientId(deal.getClient().getId())
                .clientDisplayName(deal.getClient().getProfile() != null
                        ? deal.getClient().getProfile().getDisplayName() : null)
                .lastMessage(lastMessage)
                .unreadCount(unreadCount)
                .createdAt(conversation.getCreatedAt())
                .build();
    }

    @Transactional(readOnly = true)
    public PageResponse<ConversationResponse> getUserConversations(User user, Pageable pageable) {
        Page<Conversation> conversations = conversationRepository.findByUserId(user.getId(), pageable);

        return PageResponse.from(
                conversations,
                conversations.getContent().stream()
                        .map(conv -> {
                            Deal deal = conv.getDeal();
                            Page<Message> lastMessagePage = messageRepository.findByDealId(deal.getId(), Pageable.ofSize(1));
                            MessageResponse lastMessage = lastMessagePage.hasContent()
                                    ? chatMapper.toMessageResponse(lastMessagePage.getContent().get(0))
                                    : null;
                            long unreadCount = messageRepository.countUnread(conv.getId(), user.getId());

                            return ConversationResponse.builder()
                                    .id(conv.getId())
                                    .dealId(deal.getId())
                                    .dealTitle(deal.getCampaign().getTitle())
                                    .influencerId(deal.getInfluencer().getId())
                                    .influencerDisplayName(deal.getInfluencer().getProfile() != null
                                            ? deal.getInfluencer().getProfile().getDisplayName() : null)
                                    .clientId(deal.getClient().getId())
                                    .clientDisplayName(deal.getClient().getProfile() != null
                                            ? deal.getClient().getProfile().getDisplayName() : null)
                                    .lastMessage(lastMessage)
                                    .unreadCount(unreadCount)
                                    .createdAt(conv.getCreatedAt())
                                    .build();
                        })
                        .toList()
        );
    }

    private Deal getDealWithAccess(UUID dealId, User user) {
        Deal deal = dealRepository.findByIdWithDetails(dealId)
                .orElseThrow(() -> new ResourceNotFoundException("Deal", "id", dealId));

        if (!deal.getInfluencer().getId().equals(user.getId()) &&
                !deal.getClient().getId().equals(user.getId())) {
            throw new AccessDeniedException("You don't have access to this conversation");
        }

        return deal;
    }
}
