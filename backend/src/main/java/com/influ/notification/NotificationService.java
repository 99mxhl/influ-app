package com.influ.notification;

import com.influ.common.exception.ResourceNotFoundException;
import com.influ.common.exception.UnauthorizedException;
import com.influ.user.User;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

@Service
@RequiredArgsConstructor
public class NotificationService {

    private final NotificationRepository notificationRepository;
    private final NotificationMapper notificationMapper;

    @Transactional(readOnly = true)
    public Page<NotificationResponse> getUserNotifications(User user, Pageable pageable) {
        return notificationRepository.findByUserId(user.getId(), pageable)
                .map(notificationMapper::toResponse);
    }

    @Transactional(readOnly = true)
    public long getUnreadCount(User user) {
        return notificationRepository.countUnreadByUserId(user.getId());
    }

    @Transactional
    public void markAsRead(User user, UUID notificationId) {
        Notification notification = notificationRepository.findByIdForUpdate(notificationId)
                .orElseThrow(() -> new ResourceNotFoundException("Notification", "id", notificationId));

        if (!notification.getUser().getId().equals(user.getId())) {
            throw new UnauthorizedException("You don't have access to this notification");
        }

        notification.markAsRead();
        notificationRepository.save(notification);
    }

    @Transactional
    public void markAllAsRead(User user) {
        notificationRepository.markAllAsReadByUserId(user.getId());
    }

    @Transactional
    public Notification createNotification(User user, NotificationType type, String title, String description) {
        Notification notification = new Notification(user, type, title, description);
        return notificationRepository.save(notification);
    }

    @Transactional
    public Notification createNotification(User user, NotificationType type, String title,
                                          String description, String actionUrl, UUID referenceId) {
        Notification notification = new Notification(user, type, title, description);
        notification.setActionUrl(actionUrl);
        notification.setReferenceId(referenceId);
        return notificationRepository.save(notification);
    }
}
