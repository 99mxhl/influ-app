package com.influ.chat;

import com.influ.chat.dto.ConversationResponse;
import com.influ.chat.dto.MessageResponse;
import com.influ.chat.dto.SendMessageRequest;
import com.influ.common.dto.ApiResponse;
import com.influ.common.dto.PageResponse;
import com.influ.user.User;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequestMapping("/api/deals/{dealId}")
@RequiredArgsConstructor
@Validated
@Tag(name = "Chat", description = "Chat and messaging endpoints")
public class ChatController {

    private final ChatService chatService;

    @GetMapping("/conversation")
    @Operation(summary = "Get conversation for a deal")
    public ApiResponse<ConversationResponse> getConversation(
            @AuthenticationPrincipal User user,
            @PathVariable UUID dealId) {
        return ApiResponse.success(chatService.getConversation(user, dealId));
    }

    @GetMapping("/messages")
    @Operation(summary = "Get messages for a deal")
    public ApiResponse<PageResponse<MessageResponse>> getMessages(
            @AuthenticationPrincipal User user,
            @PathVariable UUID dealId,
            @PageableDefault(size = 50) Pageable pageable) {
        return ApiResponse.success(chatService.getMessages(user, dealId, pageable));
    }

    @PostMapping("/messages")
    @Operation(summary = "Send a message (REST fallback)")
    public ApiResponse<MessageResponse> sendMessage(
            @AuthenticationPrincipal User user,
            @PathVariable UUID dealId,
            @Valid @RequestBody SendMessageRequest request) {
        return ApiResponse.success(chatService.sendMessage(user, dealId, request));
    }

    @PostMapping("/messages/read")
    @Operation(summary = "Mark messages as read")
    public ApiResponse<Void> markAsRead(
            @AuthenticationPrincipal User user,
            @PathVariable UUID dealId) {
        chatService.markAsRead(user, dealId);
        return ApiResponse.success();
    }
}
