import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../core/theme/theme.dart';
import 'user_avatar.dart';

/// Custom app bar matching Figma design
class InfluAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? subtitle;
  final bool showBack;
  final VoidCallback? onBack;
  final bool showNotifications;
  final int notificationCount;
  final VoidCallback? onNotificationsPressed;
  final bool showOptions;
  final VoidCallback? onOptionsPressed;
  final Widget? leading;
  final List<Widget>? actions;
  final bool transparent;

  const InfluAppBar({
    super.key,
    this.title,
    this.subtitle,
    this.showBack = false,
    this.onBack,
    this.showNotifications = false,
    this.notificationCount = 0,
    this.onNotificationsPressed,
    this.showOptions = false,
    this.onOptionsPressed,
    this.leading,
    this.actions,
    this.transparent = false,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: transparent ? Colors.transparent : AppColors.background,
        border: transparent
            ? null
            : Border(
                bottom: BorderSide(color: AppColors.gray200),
              ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              // Left section
              if (showBack)
                _AppBarIconButton(
                  icon: LucideIcons.arrowLeft,
                  onPressed: onBack ?? () => Navigator.of(context).maybePop(),
                  tooltip: 'Go back',
                ),
              if (leading != null) leading!,
              if ((showBack || leading != null) && title != null)
                AppSpacing.gapH3,

              // Title section
              if (title != null)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title!,
                        style: AppTypography.h3.copyWith(
                          color: AppColors.gray900,
                        ),
                      ),
                      if (subtitle != null)
                        Text(
                          subtitle!,
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.gray500,
                          ),
                        ),
                    ],
                  ),
                )
              else
                const Spacer(),

              // Right section
              if (actions != null) ...actions!,
              if (showNotifications)
                _NotificationButton(
                  count: notificationCount,
                  onPressed: onNotificationsPressed,
                ),
              if (showOptions)
                _AppBarIconButton(
                  icon: LucideIcons.moreVertical,
                  onPressed: onOptionsPressed,
                  tooltip: 'More options',
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// App bar icon button
class _AppBarIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;

  const _AppBarIconButton({
    required this.icon,
    this.onPressed,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    Widget button = Material(
      color: Colors.transparent,
      borderRadius: AppRadius.button,
      child: InkWell(
        onTap: onPressed,
        borderRadius: AppRadius.button,
        child: SizedBox(
          width: 40,
          height: 40,
          child: Icon(
            icon,
            color: AppColors.gray700,
            size: 20,
          ),
        ),
      ),
    );

    if (tooltip != null) {
      return Tooltip(message: tooltip!, child: button);
    }
    return button;
  }
}

/// Notification button with badge
class _NotificationButton extends StatelessWidget {
  final int count;
  final VoidCallback? onPressed;

  const _NotificationButton({
    required this.count,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: count > 0 ? '$count notifications' : 'Notifications',
      child: Material(
        color: Colors.transparent,
        borderRadius: AppRadius.button,
        child: InkWell(
          onTap: onPressed,
          borderRadius: AppRadius.button,
          child: SizedBox(
            width: 40,
            height: 40,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  LucideIcons.bell,
                  color: AppColors.gray700,
                  size: 20,
                ),
                if (count > 0)
                  Positioned(
                    right: 6,
                    top: 6,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.unread,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        count > 9 ? '9+' : count.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Home app bar with avatar and notifications
class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? avatarUrl;
  final String userName;
  final bool verified;
  final VoidCallback? onAvatarPressed;
  final int notificationCount;
  final VoidCallback? onNotificationsPressed;

  const HomeAppBar({
    super.key,
    this.avatarUrl,
    required this.userName,
    this.verified = false,
    this.onAvatarPressed,
    this.notificationCount = 0,
    this.onNotificationsPressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return InfluAppBar(
      title: 'Home',
      leading: GestureDetector(
        onTap: onAvatarPressed,
        child: UserAvatar(
          imageUrl: avatarUrl,
          name: userName,
          size: AvatarSize.sm,
          verified: verified,
        ),
      ),
      showNotifications: true,
      notificationCount: notificationCount,
      onNotificationsPressed: onNotificationsPressed,
    );
  }
}
