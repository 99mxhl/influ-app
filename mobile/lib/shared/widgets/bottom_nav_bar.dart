import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../core/theme/theme.dart';
import '../models/enums.dart';

/// Navigation item definition
class NavItem {
  final String label;
  final IconData icon;
  final IconData? activeIcon;
  final int? badge;

  const NavItem({
    required this.label,
    required this.icon,
    this.activeIcon,
    this.badge,
  });
}

/// Bottom navigation bar matching Figma design
class InfluBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final UserType userType;
  final int? messageBadge;

  const InfluBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.userType,
    this.messageBadge,
  });

  List<NavItem> get _items {
    if (userType == UserType.influencer) {
      return [
        const NavItem(label: 'Home', icon: LucideIcons.home),
        const NavItem(label: 'Discover', icon: LucideIcons.compass),
        NavItem(label: 'Messages', icon: LucideIcons.messageSquare, badge: messageBadge),
        const NavItem(label: 'Applications', icon: LucideIcons.briefcase),
        const NavItem(label: 'Profile', icon: LucideIcons.user),
      ];
    } else {
      return [
        const NavItem(label: 'Home', icon: LucideIcons.home),
        const NavItem(label: 'Campaigns', icon: LucideIcons.briefcase),
        NavItem(label: 'Messages', icon: LucideIcons.messageSquare, badge: messageBadge),
        const NavItem(label: 'Search', icon: LucideIcons.search),
        const NavItem(label: 'Profile', icon: LucideIcons.user),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border(
          top: BorderSide(color: AppColors.gray200),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_items.length, (index) {
              final item = _items[index];
              final isActive = currentIndex == index;

              return _NavBarItem(
                item: item,
                isActive: isActive,
                onTap: () => onTap(index),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final NavItem item;
  final bool isActive;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.item,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppRadius.button,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon with badge
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Icon(
                      item.activeIcon ?? item.icon,
                      color: isActive ? AppColors.primary : AppColors.gray500,
                      size: 24,
                    ),
                    if (item.badge != null && item.badge! > 0)
                      Positioned(
                        right: -6,
                        top: -4,
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
                            item.badge! > 9 ? '9+' : item.badge.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                // Label
                Text(
                  item.label,
                  style: AppTypography.caption.copyWith(
                    color: isActive ? AppColors.primary : AppColors.gray600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Scaffold with bottom navigation
class InfluScaffold extends StatelessWidget {
  final Widget body;
  final int currentIndex;
  final ValueChanged<int> onNavTap;
  final UserType userType;
  final int? messageBadge;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;

  const InfluScaffold({
    super.key,
    required this.body,
    required this.currentIndex,
    required this.onNavTap,
    required this.userType,
    this.messageBadge,
    this.appBar,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: body,
      bottomNavigationBar: InfluBottomNavBar(
        currentIndex: currentIndex,
        onTap: onNavTap,
        userType: userType,
        messageBadge: messageBadge,
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
