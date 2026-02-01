package com.influ.notification;

import com.influ.common.entity.BaseEntity;
import com.influ.user.User;
import jakarta.persistence.*;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.SQLRestriction;

import java.time.Instant;
import java.util.UUID;

@Entity
@Table(name = "notifications")
@SQLRestriction("deleted_at IS NULL")
@Getter
@Setter
@NoArgsConstructor
public class Notification extends BaseEntity {

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private NotificationType type;

    @Size(max = 255, message = "Title must not exceed 255 characters")
    @Column(nullable = false)
    private String title;

    @Size(max = 10000, message = "Description must not exceed 10000 characters")
    @Column(nullable = false, columnDefinition = "TEXT")
    private String description;

    @Size(max = 500, message = "Action URL must not exceed 500 characters")
    @Column(name = "action_url")
    private String actionUrl;

    @Column(name = "reference_id")
    private UUID referenceId;

    @Column(name = "read_at")
    private Instant readAt;

    public Notification(User user, NotificationType type, String title, String description) {
        this.user = user;
        this.type = type;
        this.title = title;
        this.description = description;
    }

    public boolean isRead() {
        return readAt != null;
    }

    public void markAsRead() {
        if (readAt == null) {
            readAt = Instant.now();
        }
    }
}
