package com.influ.notification;

import java.time.Instant;
import java.util.UUID;

public record NotificationResponse(
    UUID id,
    NotificationType type,
    String title,
    String description,
    String actionUrl,
    UUID referenceId,
    boolean read,
    Instant readAt,
    Instant createdAt
) {}
