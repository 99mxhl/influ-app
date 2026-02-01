import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/theme.dart';
import '../../../../shared/widgets/widgets.dart';
import '../../data/models/notification.dart';
import '../../providers/notification_provider.dart';

/// Notifications screen with real API integration
class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationsAsync = ref.watch(notificationsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(LucideIcons.arrowLeft, color: AppColors.gray900),
        ),
        title: Text(
          'Notifications',
          style: AppTypography.h3.copyWith(color: AppColors.gray900),
        ),
        centerTitle: true,
        actions: [
          notificationsAsync.whenOrNull(
                data: (notifications) {
                  final unreadCount = notifications.where((n) => !n.read).length;
                  if (unreadCount > 0) {
                    return TextButton(
                      onPressed: () {
                        ref.read(notificationsProvider.notifier).markAllAsRead();
                      },
                      child: Text(
                        'Mark all read',
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }
                  return null;
                },
              ) ??
              const SizedBox.shrink(),
        ],
      ),
      body: notificationsAsync.when(
        loading: () => const Center(child: LoadingIndicator()),
        error: (error, _) => AppErrorWidget(
          message: error.toString(),
          onRetry: () => ref.read(notificationsProvider.notifier).refresh(),
        ),
        data: (notifications) {
          if (notifications.isEmpty) {
            return _buildEmptyState();
          }

          final grouped = _groupNotifications(notifications);

          return RefreshIndicator(
            onRefresh: () => ref.read(notificationsProvider.notifier).refresh(),
            child: ListView.builder(
              itemCount: grouped.length,
              itemBuilder: (context, sectionIndex) {
                final group = grouped.keys.elementAt(sectionIndex);
                final items = grouped[group]!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: Text(
                        group.toUpperCase(),
                        style: AppTypography.overline.copyWith(
                          color: AppColors.gray600,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    ...items.map((notification) => _NotificationItem(
                          notification: notification,
                          onTap: () {
                            ref
                                .read(notificationsProvider.notifier)
                                .markAsRead(notification.id);
                            if (notification.actionUrl != null) {
                              context.push(notification.actionUrl!);
                            }
                          },
                        )),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }

  Map<String, List<AppNotification>> _groupNotifications(
      List<AppNotification> notifications) {
    final grouped = <String, List<AppNotification>>{};
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    for (final notification in notifications) {
      String group;
      if (notification.createdAt != null) {
        final notificationDate = DateTime(
          notification.createdAt!.year,
          notification.createdAt!.month,
          notification.createdAt!.day,
        );
        final diff = today.difference(notificationDate).inDays;

        if (diff == 0) {
          group = 'Today';
        } else if (diff == 1) {
          group = 'Yesterday';
        } else if (diff < 7) {
          group = 'This Week';
        } else {
          group = 'Older';
        }
      } else {
        group = 'Today';
      }

      grouped.putIfAbsent(group, () => []);
      grouped[group]!.add(notification);
    }

    return grouped;
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: AppSpacing.page,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              LucideIcons.bell,
              size: 64,
              color: AppColors.gray300,
            ),
            AppSpacing.gapV4,
            Text(
              'No notifications yet',
              style: AppTypography.h3.copyWith(color: AppColors.gray900),
            ),
            AppSpacing.gapV2,
            Text(
              "You'll see updates on your deals, messages, and payments here",
              style: AppTypography.body.copyWith(color: AppColors.gray600),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationItem extends StatelessWidget {
  final AppNotification notification;
  final VoidCallback onTap;

  const _NotificationItem({
    required this.notification,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: notification.read ? Colors.transparent : AppColors.infoLight,
          border: Border(
            bottom: BorderSide(color: AppColors.gray200),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _getIconColor(notification.type)
                    .withOpacity(notification.read ? 0.6 : 1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  _getIcon(notification.type),
                  size: 20,
                  color: Colors.white,
                ),
              ),
            ),
            AppSpacing.gapH3,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          notification.title,
                          style: AppTypography.body.copyWith(
                            fontWeight:
                                notification.read ? FontWeight.w500 : FontWeight.w600,
                            color: AppColors.gray900,
                          ),
                        ),
                      ),
                      if (!notification.read) ...[
                        AppSpacing.gapH2,
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: AppColors.unread,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notification.description,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.gray600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatTimestamp(notification.createdAt),
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.gray500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIcon(NotificationType type) {
    switch (type) {
      case NotificationType.message:
        return LucideIcons.messageSquare;
      case NotificationType.deal:
        return LucideIcons.fileText;
      case NotificationType.payment:
        return LucideIcons.dollarSign;
      case NotificationType.application:
        return LucideIcons.inbox;
      case NotificationType.invitation:
        return LucideIcons.mail;
      case NotificationType.review:
        return LucideIcons.star;
      case NotificationType.system:
        return LucideIcons.info;
    }
  }

  Color _getIconColor(NotificationType type) {
    switch (type) {
      case NotificationType.message:
        return AppColors.info;
      case NotificationType.deal:
        return AppColors.primary;
      case NotificationType.payment:
        return AppColors.success;
      case NotificationType.application:
        return AppColors.warning;
      case NotificationType.invitation:
        return AppColors.secondary;
      case NotificationType.review:
        return AppColors.accent;
      case NotificationType.system:
        return AppColors.gray600;
    }
  }

  String _formatTimestamp(DateTime? timestamp) {
    if (timestamp == null) return '';

    final now = DateTime.now();
    final diff = now.difference(timestamp);

    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays == 1) return 'Yesterday';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${timestamp.day}/${timestamp.month}';
  }
}
