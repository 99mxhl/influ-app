import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/theme.dart';
import '../../../../shared/models/enums.dart';
import '../../../../shared/widgets/widgets.dart';
import '../../../campaigns/data/models/campaign.dart';
import '../../../campaigns/providers/campaigns_provider.dart';

/// Discover screen for influencers to browse available campaigns
/// Matches Figma design
class DiscoverScreen extends ConsumerStatefulWidget {
  const DiscoverScreen({super.key});

  @override
  ConsumerState<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends ConsumerState<DiscoverScreen> {
  String _selectedCategory = 'All';

  final List<String> _categories = [
    'All',
    'Fashion',
    'Beauty',
    'Tech',
    'Gaming',
    'Fitness',
    'Food',
    'Travel',
    'Lifestyle',
  ];

  List<Campaign> _filterCampaigns(List<Campaign> campaigns) {
    if (_selectedCategory == 'All') return campaigns;
    return campaigns.where((campaign) {
      return campaign.categories
          .any((c) => c.toLowerCase() == _selectedCategory.toLowerCase());
    }).toList();
  }

  String _formatTimeAgo(DateTime? date) {
    if (date == null) return '';
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inDays == 0) return 'Today';
    if (diff.inDays == 1) return '1 day ago';
    if (diff.inDays < 7) return '${diff.inDays} days ago';
    if (diff.inDays < 14) return '1 week ago';
    return '${diff.inDays ~/ 7} weeks ago';
  }

  String _formatDeadline(DateTime? date) {
    if (date == null) return 'TBD';
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final campaignsState = ref.watch(campaignsProvider);

    // Load campaigns on first build if not already loaded
    if (!campaignsState.hasLoaded && !campaignsState.isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(campaignsProvider.notifier).loadCampaigns();
      });
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Browse Campaigns',
                    style: AppTypography.h3.copyWith(color: AppColors.gray900),
                  ),
                  // Notification bell with badge
                  Stack(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(LucideIcons.bell, color: AppColors.gray700),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: AppColors.error,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Category filter chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: _categories.map((category) {
                  final isSelected = _selectedCategory == category;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedCategory = category),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primary : AppColors.gray100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          category,
                          style: AppTypography.bodySmall.copyWith(
                            color: isSelected ? Colors.white : AppColors.gray700,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 16),

            // Campaign list
            Expanded(
              child: _buildCampaignList(campaignsState),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCampaignList(CampaignsState campaignsState) {
    if (campaignsState.isLoading && !campaignsState.hasLoaded) {
      return const Center(child: LoadingIndicator());
    }

    if (campaignsState.error != null) {
      return AppErrorWidget(
        message: campaignsState.error!,
        onRetry: () => ref.read(campaignsProvider.notifier).loadCampaigns(refresh: true),
      );
    }

    final filtered = _filterCampaigns(campaignsState.campaigns);

    if (filtered.isEmpty) {
      return const EmptyStateWidget(
        icon: LucideIcons.search,
        title: 'No campaigns found',
        message: 'Check back later for new opportunities',
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(campaignsProvider.notifier).loadCampaigns(refresh: true),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: filtered.length,
        itemBuilder: (context, index) {
          final campaign = filtered[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _CampaignCard(
              campaign: campaign,
              timeAgo: _formatTimeAgo(campaign.createdAt),
              deadline: _formatDeadline(campaign.endDate),
              colorIndex: index,
              onTap: () => context.push('/campaigns/${campaign.id}'),
            ),
          );
        },
      ),
    );
  }
}

class _CampaignCard extends StatelessWidget {
  final Campaign campaign;
  final String timeAgo;
  final String deadline;
  final int colorIndex;
  final VoidCallback onTap;

  const _CampaignCard({
    required this.campaign,
    required this.timeAgo,
    required this.deadline,
    required this.colorIndex,
    required this.onTap,
  });

  Color get _avatarColor {
    final colors = [
      AppColors.info,      // Blue
      AppColors.secondary, // Cyan
      AppColors.success,   // Green
      AppColors.warning,   // Orange
      AppColors.primary,   // Purple
      AppColors.error,     // Red
    ];
    return colors[colorIndex % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: AppRadius.card,
          border: Border.all(color: AppColors.gray200),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title row with avatar
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Colored avatar
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _avatarColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      (campaign.clientName ?? 'B')[0].toUpperCase(),
                      style: AppTypography.body.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Campaign title
                      Text(
                        campaign.title,
                        style: AppTypography.body.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.gray900,
                        ),
                      ),
                      const SizedBox(height: 2),
                      // Brand name (client display name)
                      Text(
                        campaign.clientName ?? 'Brand',
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.gray500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Description
            if (campaign.description != null && campaign.description!.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                campaign.description!,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.gray600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],

            const SizedBox(height: 12),

            // Budget and Deadline row
            Row(
              children: [
                // Budget
                Expanded(
                  child: Row(
                    children: [
                      Icon(LucideIcons.dollarSign, size: 14, color: AppColors.success),
                      const SizedBox(width: 4),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Budget',
                            style: AppTypography.caption.copyWith(
                              color: AppColors.gray500,
                            ),
                          ),
                          Text(
                            '\$${campaign.budgetMin.toInt()} - \$${campaign.budgetMax.toInt()}',
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.gray900,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Deadline
                Expanded(
                  child: Row(
                    children: [
                      Icon(LucideIcons.calendar, size: 14, color: AppColors.info),
                      const SizedBox(width: 4),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Deadline',
                            style: AppTypography.caption.copyWith(
                              color: AppColors.gray500,
                            ),
                          ),
                          Text(
                            deadline,
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.gray900,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Platform badges
            if (campaign.platforms.isNotEmpty) ...[
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                runSpacing: 8,
                children: campaign.platforms.map((platform) => _PlatformLabel(platform: platform)).toList(),
              ),
            ],

            const SizedBox(height: 12),

            // Applicants and time
            Row(
              children: [
                Icon(LucideIcons.users, size: 14, color: AppColors.gray500),
                const SizedBox(width: 4),
                Text(
                  '${campaign.applicantCount} applicants',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.gray500,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  timeAgo,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.gray500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Platform label with colored icon and text (no background)
class _PlatformLabel extends StatelessWidget {
  final Platform platform;

  const _PlatformLabel({required this.platform});

  Color get _iconColor {
    switch (platform) {
      case Platform.instagram:
        return AppColors.instagram;
      case Platform.youtube:
        return AppColors.youtube;
      case Platform.twitter:
        return AppColors.xTwitter;
      case Platform.tiktok:
        return AppColors.tiktok;
    }
  }

  String get _label {
    switch (platform) {
      case Platform.instagram:
        return 'Instagram';
      case Platform.youtube:
        return 'YouTube';
      case Platform.twitter:
        return 'X';
      case Platform.tiktok:
        return 'TikTok';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildIcon(),
        const SizedBox(width: 4),
        Text(
          _label,
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.gray700,
          ),
        ),
      ],
    );
  }

  Widget _buildIcon() {
    switch (platform) {
      case Platform.tiktok:
        return Image.asset('assets/icons/tt-50.png', width: 14, height: 14);
      case Platform.twitter:
        return Image.asset('assets/icons/icons8-x-50.png', width: 14, height: 14);
      case Platform.youtube:
        return SvgPicture.asset('assets/icons/icons8-youtube.svg', width: 14, height: 14);
      case Platform.instagram:
        return Icon(LucideIcons.instagram, size: 14, color: _iconColor);
    }
  }
}
