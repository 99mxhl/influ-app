package com.influ.notification;

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
import org.springframework.web.bind.annotation.*;

import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/api/notifications")
@RequiredArgsConstructor
@Validated
@Tag(name = "Notifications", description = "Notification management endpoints")
public class NotificationController {

    private final NotificationService notificationService;

    @GetMapping
    @Operation(summary = "Get all notifications for current user")
    public ApiResponse<PageResponse<NotificationResponse>> getNotifications(
            @AuthenticationPrincipal User user,
            @PageableDefault(size = 20) Pageable pageable) {
        return ApiResponse.success(PageResponse.from(notificationService.getUserNotifications(user, pageable)));
    }

    @GetMapping("/unread-count")
    @Operation(summary = "Get unread notification count")
    public ApiResponse<Map<String, Long>> getUnreadCount(@AuthenticationPrincipal User user) {
        return ApiResponse.success(Map.of("count", notificationService.getUnreadCount(user)));
    }

    @PostMapping("/{id}/read")
    @Operation(summary = "Mark a notification as read")
    public ApiResponse<Void> markAsRead(
            @AuthenticationPrincipal User user,
            @PathVariable UUID id) {
        notificationService.markAsRead(user, id);
        return ApiResponse.success(null);
    }

    @PostMapping("/read-all")
    @Operation(summary = "Mark all notifications as read")
    public ApiResponse<Void> markAllAsRead(@AuthenticationPrincipal User user) {
        notificationService.markAllAsRead(user);
        return ApiResponse.success(null);
    }
}
