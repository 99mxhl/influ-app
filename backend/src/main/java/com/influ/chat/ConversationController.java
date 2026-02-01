package com.influ.chat;

import com.influ.chat.dto.ConversationResponse;
import com.influ.common.dto.ApiResponse;
import com.influ.common.dto.PageResponse;
import com.influ.user.User;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/conversations")
@RequiredArgsConstructor
@Validated
@Tag(name = "Conversations", description = "Conversation listing endpoints")
public class ConversationController {

    private final ChatService chatService;

    @GetMapping
    @Operation(summary = "Get all conversations for current user")
    public ApiResponse<PageResponse<ConversationResponse>> getConversations(
            @AuthenticationPrincipal User user,
            @PageableDefault(size = 20) Pageable pageable) {
        return ApiResponse.success(chatService.getUserConversations(user, pageable));
    }
}
