package com.influ.notification;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
public interface NotificationRepository extends JpaRepository<Notification, UUID> {

    @Query("SELECT n FROM Notification n WHERE n.id = :id AND n.deletedAt IS NULL")
    Optional<Notification> findByIdActive(@Param("id") UUID id);

    @Query("SELECT n FROM Notification n WHERE n.user.id = :userId AND n.deletedAt IS NULL ORDER BY n.createdAt DESC")
    Page<Notification> findByUserId(@Param("userId") UUID userId, Pageable pageable);

    @Query("SELECT COUNT(n) FROM Notification n WHERE n.user.id = :userId AND n.readAt IS NULL AND n.deletedAt IS NULL")
    long countUnreadByUserId(@Param("userId") UUID userId);

    /**
     * Bulk update that bypasses optimistic locking (@Version).
     * Acceptable for mark-as-read where concurrent modifications are idempotent.
     */
    @Modifying(clearAutomatically = true)
    @Query("UPDATE Notification n SET n.readAt = CURRENT_TIMESTAMP WHERE n.user.id = :userId AND n.readAt IS NULL AND n.deletedAt IS NULL")
    void markAllAsReadByUserId(@Param("userId") UUID userId);
}
