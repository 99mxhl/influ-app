import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/theme.dart';
import '../../../../shared/models/enums.dart';
import '../../../../shared/widgets/widgets.dart';
import '../../../auth/providers/auth_provider.dart';

/// Home screen matching Figma design 1:1
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final user = authState.user;

    if (user == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final isInfluencer = user.type == UserType.influencer;
    final displayName = user.profile?.displayName ?? user.email.split('@').first;
    final firstName = displayName.split(' ').first;

    return Scaffold(
      backgroundColor: AppColors.elevated,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // App Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    // Profile avatar + Home text
                    GestureDetector(
                      onTap: () => context.go(AppRoutes.profile),
                      child: Row(
                        children: [
                          UserAvatar(
                            imageUrl: user.profile?.avatarUrl,
                            name: displayName,
                            size: AvatarSize.sm,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Home',
                            style: AppTypography.h3.copyWith(
                              color: AppColors.gray900,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    // Notifications
                    Stack(
                      children: [
                        IconButton(
                          onPressed: () => context.push(AppRoutes.notifications),
                          icon: Icon(
                            LucideIcons.bell,
                            color: AppColors.gray700,
                          ),
                        ),
                        Positioned(
                          right: 8,
                          top: 8,
                          child: Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                              color: AppColors.error,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '3',
                                style: AppTypography.caption.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Padding(
                padding: AppSpacing.page,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Welcome card
                    WelcomeCard(
                      greeting: _getGreeting(),
                      name: firstName,
                      subtitle: 'Welcome back to your dashboard',
                    ),
                    AppSpacing.gapV6,

                    // Stats row
                    Row(
                      children: isInfluencer
                          ? [
                              Expanded(
                                child: _buildStatCard(
                                  context,
                                  label: 'Active Deals',
                                  value: '3',
                                  icon: LucideIcons.briefcase,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _buildStatCard(
                                  context,
                                  label: 'Pending Payments',
                                  value: '\$2,450',
                                  icon: LucideIcons.dollarSign,
                                  iconColor: AppColors.success,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _buildStatCard(
                                  context,
                                  label: 'Average Rating',
                                  value: '4.8',
                                  icon: LucideIcons.star,
                                  iconColor: AppColors.warning,
                                ),
                              ),
                            ]
                          : [
                              Expanded(
                                child: _buildStatCard(
                                  context,
                                  label: 'Active Campaigns',
                                  value: '5',
                                  icon: LucideIcons.fileText,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _buildStatCard(
                                  context,
                                  label: 'Pending Approvals',
                                  value: '8',
                                  icon: LucideIcons.clock,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _buildStatCard(
                                  context,
                                  label: 'Total Spent',
                                  value: '\$12,500',
                                  icon: LucideIcons.dollarSign,
                                ),
                              ),
                            ],
                    ),
                    AppSpacing.gapV6,

                    // Action Required section
                    _ActionRequiredSection(isInfluencer: isInfluencer),
                    AppSpacing.gapV6,

                    // Active Deals section
                    _ActiveDealsSection(isInfluencer: isInfluencer),
                    AppSpacing.gapV6,

                    // Recent Messages section
                    _RecentMessagesSection(),
                    AppSpacing.gapV6,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 18) return 'Good afternoon';
    return 'Good evening';
  }

  Widget _buildStatCard(
    BuildContext context, {
    required String label,
    required String value,
    required IconData icon,
    Color? iconColor,
  }) {
    return Container(
      height: 90,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: AppRadius.card,
        border: Border.all(color: AppColors.gray200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  label,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.gray500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 4),
              Icon(icon, size: 16, color: iconColor ?? AppColors.gray600),
            ],
          ),
          const Spacer(),
          Text(
            value,
            style: AppTypography.h2.copyWith(
              color: AppColors.gray900,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

/// Action Required section
class _ActionRequiredSection extends StatelessWidget {
  final bool isInfluencer;

  const _ActionRequiredSection({required this.isInfluencer});

  @override
  Widget build(BuildContext context) {
    final actionItems = isInfluencer
        ? [
            _ActionItem(
              title: 'Content submission due',
              campaignName: 'Summer Fashion Campaign',
              brandContact: 'FashionHub • Alex Thompson',
              dueDate: 'Due in 2 days',
              urgent: true,
            ),
            _ActionItem(
              title: 'New terms proposal',
              campaignName: 'TechCorp Spring Campaign',
              brandContact: 'TechCorp • Sarah Chen',
              dueDate: 'Pending review',
              urgent: false,
            ),
          ]
        : [
            _ActionItem(
              title: 'Review submitted content',
              campaignName: 'Summer Fashion Campaign',
              brandContact: 'Sarah Johnson • 3 deliverables',
              dueDate: 'Submitted today',
              urgent: true,
            ),
            _ActionItem(
              title: 'New applications',
              campaignName: 'Holiday Campaign',
              brandContact: '12 influencers applied',
              dueDate: 'Review applications',
              urgent: false,
            ),
          ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Action Required',
              style: AppTypography.h4.copyWith(color: AppColors.gray900),
            ),
            AppSpacing.gapH2,
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: AppColors.error,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${actionItems.length}',
                  style: AppTypography.caption.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        AppSpacing.gapV3,
        ...actionItems.map((item) => _buildActionCard(context, item)),
      ],
    );
  }

  Widget _buildActionCard(BuildContext context, _ActionItem item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () => context.push('/deals/1'),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: AppRadius.card,
            border: Border.all(color: AppColors.gray200),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.only(top: 6),
                decoration: BoxDecoration(
                  color: item.urgent ? AppColors.error : AppColors.warning,
                  shape: BoxShape.circle,
                ),
              ),
              AppSpacing.gapH3,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: AppTypography.body.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.gray900,
                      ),
                    ),
                    const SizedBox(height: 2), // 2px gap below title
                    Text(
                      item.campaignName,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.gray600,
                      ),
                    ),
                    const SizedBox(height: 2), // 2px gap below campaign name
                    Text(
                      item.brandContact,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.gray500,
                      ),
                    ),
                    const SizedBox(height: 8), // 8px gap before due date
                    Text(
                      item.dueDate,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.gray500,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                LucideIcons.chevronRight,
                size: 20,
                color: AppColors.gray400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionItem {
  final String title;
  final String campaignName;
  final String brandContact;
  final String dueDate;
  final bool urgent;

  const _ActionItem({
    required this.title,
    required this.campaignName,
    required this.brandContact,
    required this.dueDate,
    required this.urgent,
  });
}

/// Active Deals section
class _ActiveDealsSection extends StatelessWidget {
  final bool isInfluencer;

  const _ActiveDealsSection({required this.isInfluencer});

  @override
  Widget build(BuildContext context) {
    final deals = [
      _DealItem(
        name: isInfluencer ? 'TechCorp' : 'Sarah Johnson',
        campaign: isInfluencer ? 'Spring Product Launch' : 'Summer Fashion Campaign',
        status: 'Active',
        lastActivity: '2 hours ago',
      ),
      _DealItem(
        name: isInfluencer ? 'BeautyBrand' : 'Mike Chen',
        campaign: isInfluencer ? 'Skincare Review' : 'Tech Review Series',
        status: 'Content Submitted',
        lastActivity: '1 day ago',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Active Deals',
              style: AppTypography.h4.copyWith(color: AppColors.gray900),
            ),
            GestureDetector(
              onTap: () => context.go(AppRoutes.deals),
              child: Text(
                'See All',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        AppSpacing.gapV3,
        ...deals.map((deal) => _buildDealCard(context, deal)),
      ],
    );
  }

  Widget _buildDealCard(BuildContext context, _DealItem deal) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () => context.push('/deals/1'),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: AppRadius.card,
            border: Border.all(color: AppColors.gray200),
          ),
          child: Row(
            children: [
              UserAvatar(
                name: deal.name,
                size: AvatarSize.md,
              ),
              AppSpacing.gapH3,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      deal.name,
                      style: AppTypography.body.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.gray900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      deal.campaign,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.gray600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        StatusBadge(
                          status: deal.status == 'Active'
                              ? BadgeStatus.success
                              : BadgeStatus.warning,
                          label: deal.status,
                          size: BadgeSize.sm,
                        ),
                        AppSpacing.gapH2,
                        Text(
                          '• ${deal.lastActivity}',
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.gray500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(
                LucideIcons.chevronRight,
                size: 20,
                color: AppColors.gray400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DealItem {
  final String name;
  final String campaign;
  final String status;
  final String lastActivity;

  const _DealItem({
    required this.name,
    required this.campaign,
    required this.status,
    required this.lastActivity,
  });
}

/// Recent Messages section
class _RecentMessagesSection extends StatelessWidget {
  const _RecentMessagesSection();

  @override
  Widget build(BuildContext context) {
    final messages = [
      _MessageItem(
        name: 'Alex Thompson',
        message: 'Sounds great! Let me know when...',
        time: '10m ago',
        unread: true,
      ),
      _MessageItem(
        name: 'Emma Wilson',
        message: "I've uploaded the content for...",
        time: '1h ago',
        unread: false,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Messages',
              style: AppTypography.h4.copyWith(color: AppColors.gray900),
            ),
            GestureDetector(
              onTap: () => context.push('/messages'),
              child: Text(
                'See All',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        AppSpacing.gapV3,
        ...messages.map((msg) => _buildMessageCard(context, msg)),
      ],
    );
  }

  Widget _buildMessageCard(BuildContext context, _MessageItem msg) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () => context.push('/messages/1'),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: msg.unread ? AppColors.infoLight : AppColors.card,
            borderRadius: AppRadius.card,
            border: Border.all(
              color: msg.unread ? AppColors.info : AppColors.gray200,
            ),
          ),
          child: Row(
            children: [
              UserAvatar(
                name: msg.name,
                size: AvatarSize.md,
                isOnline: msg.unread,
              ),
              AppSpacing.gapH3,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      msg.name,
                      style: AppTypography.body.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.gray900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      msg.message,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.gray600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    msg.time,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.gray500,
                    ),
                  ),
                  if (msg.unread) ...[
                    const SizedBox(height: 6),
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: AppColors.unread,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '1',
                          style: AppTypography.caption.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MessageItem {
  final String name;
  final String message;
  final String time;
  final bool unread;

  const _MessageItem({
    required this.name,
    required this.message,
    required this.time,
    required this.unread,
  });
}
