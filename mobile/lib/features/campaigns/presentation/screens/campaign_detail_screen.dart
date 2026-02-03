import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/theme.dart';
import '../../../../shared/models/enums.dart';
import '../../../../shared/widgets/widgets.dart';
import '../../../auth/providers/auth_provider.dart';
import '../../../deals/providers/deals_provider.dart';
import '../../data/campaign_repository.dart';
import '../../data/models/campaign.dart';
import '../../providers/campaigns_provider.dart';

/// Campaign detail screen matching Figma design 1:1
class CampaignDetailScreen extends ConsumerStatefulWidget {
  final String campaignId;

  const CampaignDetailScreen({
    super.key,
    required this.campaignId,
  });

  @override
  ConsumerState<CampaignDetailScreen> createState() =>
      _CampaignDetailScreenState();
}

class _CampaignDetailScreenState extends ConsumerState<CampaignDetailScreen> {
  bool _isApplying = false;
  bool _hasApplied = false;
  bool _isBookmarked = false;
  bool _isUpdatingStatus = false;

  // Mock data for fields not in backend yet
  static const _mockData = _MockCampaignData(
    personName: 'Emily Rodriguez',
    daysRemaining: 40,
    applicants: 24,
    minFollowers: '10,000+',
    location: 'US, UK, Canada',
    audienceAgeRange: '18-35',
    engagementRate: '3%+',
    deliverables: [
      '3 Instagram feed posts showcasing different outfits',
      '5 Instagram Stories featuring styling tips',
      '2 TikTok videos (30-60 seconds each)',
      'Product tags and links in all content',
      'Usage rights for brand reposting',
    ],
    timeline: [
      _TimelineItem(
        title: 'Application Deadline',
        date: 'Feb 15, 2026',
        color: AppColors.primary,
        icon: LucideIcons.calendar,
      ),
      _TimelineItem(
        title: 'Creator Selection',
        date: 'Feb 20, 2026',
        color: AppColors.warning,
        icon: LucideIcons.users,
      ),
      _TimelineItem(
        title: 'Content Creation Period',
        date: 'Feb 25 - Mar 10, 2026',
        color: AppColors.success,
        icon: LucideIcons.penTool,
      ),
      _TimelineItem(
        title: 'Posting Schedule',
        date: 'Mar 11 - Mar 15, 2026',
        color: AppColors.secondary,
        icon: LucideIcons.send,
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    final campaignAsync = ref.watch(campaignByIdProvider(widget.campaignId));
    final authState = ref.watch(authStateProvider);
    final isInfluencer = authState.user?.type == UserType.influencer;
    final currentUserId = authState.user?.id;

    return Scaffold(
      backgroundColor: AppColors.card,
      appBar: AppBar(
        backgroundColor: AppColors.card,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft, color: AppColors.gray700),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Campaign Details',
          style: AppTypography.bodyLarge.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.gray900,
          ),
        ),
        centerTitle: false,
      ),
      body: campaignAsync.when(
        loading: () => const Center(child: LoadingIndicator()),
        error: (error, _) => AppErrorWidget(
          message: error.toString(),
          onRetry: () => ref.invalidate(campaignByIdProvider(widget.campaignId)),
        ),
        data: (campaign) => Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // White header section
                    Container(
                      color: AppColors.card,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title section with avatar + title + icons
                          _buildTitleSection(campaign),
                          AppSpacing.gapV4,

                          // Info cards grid (4 separate cards)
                          _buildInfoCardsGrid(campaign),
                        ],
                      ),
                    ),

                    // Gray content section
                    Container(
                      color: AppColors.elevated,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // About This Campaign
                          if (campaign.description != null) ...[
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildSectionTitle('About This Campaign'),
                                  AppSpacing.gapV3,
                                  Text(
                                    campaign.description!,
                                    style: AppTypography.bodySmall.copyWith(
                                      color: AppColors.gray700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(height: 1, color: AppColors.gray200),
                          ],

                          // Requirements
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: _buildRequirementsSection(campaign),
                          ),
                          const Divider(height: 1, color: AppColors.gray200),

                          // Deliverables
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: _buildDeliverablesSection(),
                          ),
                          const Divider(height: 1, color: AppColors.gray200),

                          // Campaign Timeline
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: _buildTimelineSection(),
                          ),
                          AppSpacing.gapV4,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Sticky action bar
            _buildActionBar(
              campaign: campaign,
              isInfluencer: isInfluencer,
              currentUserId: currentUserId,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleSection(Campaign campaign) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UserAvatar(
          name: campaign.clientDisplayName ?? 'Brand',
          size: AvatarSize.lg,
          verified: true,
        ),
        AppSpacing.gapH3,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                campaign.title,
                style: AppTypography.bodyLarge.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.gray900,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                campaign.clientDisplayName ?? 'Brand',
                style: AppTypography.bodySmall.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.gray900,
                ),
              ),
              Text(
                _mockData.personName,
                style: AppTypography.caption.copyWith(
                  color: AppColors.gray600,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          icon: Icon(
            _isBookmarked ? LucideIcons.bookmarkMinus : LucideIcons.bookmark,
            color: _isBookmarked ? AppColors.primary : AppColors.gray500,
            size: 20,
          ),
          onPressed: () => setState(() => _isBookmarked = !_isBookmarked),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
        ),
        IconButton(
          icon: const Icon(LucideIcons.share2, color: AppColors.gray500, size: 20),
          onPressed: _handleShare,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
        ),
      ],
    );
  }

  Widget _buildInfoCardsGrid(Campaign campaign) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _InfoCard(
                icon: LucideIcons.dollarSign,
                iconColor: AppColors.success,
                label: 'Budget',
                value: '\$${campaign.budgetMin.toStringAsFixed(0)} - \$${campaign.budgetMax.toStringAsFixed(0)}',
              ),
            ),
            AppSpacing.gapH3,
            Expanded(
              child: _InfoCard(
                icon: LucideIcons.calendar,
                iconColor: AppColors.warning,
                label: 'Deadline',
                value: '${_mockData.daysRemaining} days left',
              ),
            ),
          ],
        ),
        AppSpacing.gapV3,
        Row(
          children: [
            Expanded(
              child: _PlatformsCard(
                label: 'Platforms',
                platforms: campaign.platforms,
              ),
            ),
            AppSpacing.gapH3,
            Expanded(
              child: _InfoCard(
                icon: LucideIcons.users,
                iconColor: AppColors.primary,
                label: 'Applicants',
                value: '${_mockData.applicants}',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: AppTypography.bodyLarge.copyWith(
        fontWeight: FontWeight.w600,
        color: AppColors.gray900,
      ),
    );
  }

  Widget _buildDeliverablesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Deliverables'),
        AppSpacing.gapV3,
        ..._mockData.deliverables.map((deliverable) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  LucideIcons.check,
                  size: 16,
                  color: AppColors.success,
                ),
                AppSpacing.gapH3,
                Expanded(
                  child: Text(
                    deliverable,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.gray700,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildRequirementsSection(Campaign campaign) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Requirements'),
        AppSpacing.gapV3,
        // Row 1: Minimum Followers | Location
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _RequirementRow(
                icon: LucideIcons.users,
                iconColor: AppColors.primary,
                title: 'Minimum Followers',
                value: _mockData.minFollowers,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _RequirementRow(
                icon: LucideIcons.mapPin,
                iconColor: const Color(0xFFEF4444),
                title: 'Location',
                value: _mockData.location,
              ),
            ),
          ],
        ),
        AppSpacing.gapV3,
        // Row 2: Audience Age Range | Engagement Rate
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _RequirementRow(
                customIcon: Image.asset(
                  'assets/icons/icons8-goal-48.png',
                  width: 20,
                  height: 20,
                ),
                title: 'Audience Age Range',
                value: _mockData.audienceAgeRange,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _RequirementRow(
                icon: LucideIcons.trendingUp,
                iconColor: AppColors.success,
                title: 'Engagement Rate',
                value: _mockData.engagementRate,
              ),
            ),
          ],
        ),
        AppSpacing.gapV3,
        // Row 3: Content Niches (full width)
        _RequirementRow(
          customIcon: Image.asset(
            'assets/icons/icons8-layers-48.png',
            width: 20,
            height: 20,
          ),
          title: 'Content Niches',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: campaign.categories.map((cat) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.gray100,
                  borderRadius: AppRadius.radiusFull,
                ),
                child: Text(
                  cat.isEmpty ? cat : cat[0].toUpperCase() + cat.substring(1).toLowerCase(),
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.gray700,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineSection() {
    const double iconSize = 28;
    const double itemSpacing = 10;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Campaign Timeline'),
        AppSpacing.gapV3,
        Stack(
          children: [
            // Vertical connecting line
            Positioned(
              left: iconSize / 2 - 1,
              top: iconSize / 2,
              bottom: iconSize / 2 + itemSpacing,
              child: Container(
                width: 2,
                color: AppColors.gray200,
              ),
            ),
            // Timeline items
            Column(
              children: List.generate(_mockData.timeline.length, (index) {
                final item = _mockData.timeline[index];
                final isLast = index == _mockData.timeline.length - 1;

                return Padding(
                  padding: EdgeInsets.only(bottom: isLast ? 0 : itemSpacing),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Circular icon badge
                      Container(
                        width: iconSize,
                        height: iconSize,
                        decoration: BoxDecoration(
                          color: item.color,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          item.icon,
                          size: 14,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Card with title and date
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          decoration: BoxDecoration(
                            color: AppColors.gray50,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.gray200),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                                style: AppTypography.bodySmall.copyWith(
                                  color: AppColors.gray600,
                                ),
                              ),
                              Text(
                                item.date,
                                style: AppTypography.bodySmall.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.gray900,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionBar({
    required Campaign campaign,
    required bool isInfluencer,
    required String? currentUserId,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppColors.card,
        border: Border(top: BorderSide(color: AppColors.gray200)),
      ),
      child: SafeArea(
        top: false,
        child: _buildActionButton(
          campaign: campaign,
          isInfluencer: isInfluencer,
          currentUserId: currentUserId,
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required Campaign campaign,
    required bool isInfluencer,
    required String? currentUserId,
  }) {
    // Client controls - show if user owns the campaign
    if (!isInfluencer && campaign.clientId == currentUserId) {
      if (campaign.status == CampaignStatus.draft) {
        return AppButton(
          text: 'Activate Campaign',
          isLoading: _isUpdatingStatus,
          onPressed: () => _handleStatusUpdate(CampaignStatus.active),
        );
      }
      if (campaign.status == CampaignStatus.active) {
        return AppButton(
          text: 'Pause Campaign',
          variant: AppButtonVariant.outline,
          isLoading: _isUpdatingStatus,
          onPressed: () => _handleStatusUpdate(CampaignStatus.paused),
        );
      }
      if (campaign.status == CampaignStatus.paused) {
        return AppButton(
          text: 'Resume Campaign',
          isLoading: _isUpdatingStatus,
          onPressed: () => _handleStatusUpdate(CampaignStatus.active),
        );
      }
    }

    // Influencer controls
    if (isInfluencer && campaign.status == CampaignStatus.active) {
      if (_hasApplied) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          decoration: BoxDecoration(
            color: AppColors.successLight,
            borderRadius: AppRadius.button,
            border: Border.all(color: AppColors.success),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(LucideIcons.checkCircle2, size: 20, color: AppColors.success),
              const SizedBox(width: 8),
              Text(
                'Applied on ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                style: AppTypography.body.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.successDark,
                ),
              ),
            ],
          ),
        );
      }

      return _buildApplyButton(campaign);
    }

    // Default - campaign closed or other state
    return AppButton(
      text: 'Campaign ${campaign.status.displayName}',
      onPressed: null,
    );
  }

  Widget _buildApplyButton(Campaign campaign) {
    return GestureDetector(
      onTap: _isApplying ? null : () => _showApplyModal(campaign),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: _isApplying
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Text(
                  'Apply to Campaign',
                  style: AppTypography.body.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }

  void _showApplyModal(Campaign campaign) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      builder: (context) => _ApplyModal(
        budgetMin: campaign.budgetMin,
        budgetMax: campaign.budgetMax,
        onSubmit: (proposedRate, message) async {
          Navigator.of(context).pop();
          await _handleApply();
        },
      ),
    );
  }

  void _handleShare() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Share functionality coming soon!')),
    );
  }

  Future<void> _handleStatusUpdate(CampaignStatus newStatus) async {
    setState(() => _isUpdatingStatus = true);

    try {
      final repository = ref.read(campaignRepositoryProvider);
      await repository.updateCampaign(
        widget.campaignId,
        UpdateCampaignRequest(status: newStatus),
      );

      // Refresh the campaign and lists
      ref.invalidate(campaignByIdProvider(widget.campaignId));
      ref.read(myCampaignsProvider.notifier).refresh();
      ref.read(campaignsProvider.notifier).refresh();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Campaign ${newStatus.displayName.toLowerCase()}!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isUpdatingStatus = false);
      }
    }
  }

  Future<void> _handleApply() async {
    setState(() => _isApplying = true);

    try {
      await ref.read(dealsProvider.notifier).applyToCampaign(widget.campaignId);

      if (mounted) {
        setState(() => _hasApplied = true);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Application submitted successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isApplying = false);
      }
    }
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;

  const _InfoCard({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: AppRadius.card,
        border: Border.all(color: AppColors.gray200),
      ),
      child: Row(
        children: [
          Icon(icon, size: 24, color: iconColor),
          AppSpacing.gapH3,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.gray600,
                  ),
                ),
                Text(
                  value,
                  style: AppTypography.body.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.gray900,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PlatformsCard extends StatelessWidget {
  final String label;
  final List<Platform> platforms;

  const _PlatformsCard({
    required this.label,
    required this.platforms,
  });

  Widget _buildPlatformIcon(Platform platform) {
    const double size = 20;
    switch (platform) {
      case Platform.instagram:
        return const Icon(LucideIcons.instagram, size: size, color: AppColors.instagram);
      case Platform.youtube:
        return SvgPicture.asset(
          'assets/icons/icons8-youtube.svg',
          width: size,
          height: size,
        );
      case Platform.twitter:
        return Image.asset(
          'assets/icons/icons8-x-50.png',
          width: size,
          height: size,
        );
      case Platform.tiktok:
        return Image.asset(
          'assets/icons/tt-50.png',
          width: size,
          height: size,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final sortedPlatforms = List<Platform>.from(platforms)..sort((a, b) => a.name.compareTo(b.name));
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: AppRadius.card,
        border: Border.all(color: AppColors.gray200),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Center(
              child: Image.asset('assets/icons/icons8-platform-26.png', width: 20, height: 20),
            ),
          ),
          AppSpacing.gapH3,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.gray600,
                  ),
                ),
                Row(
                  children: sortedPlatforms.map((p) => Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: _buildPlatformIcon(p),
                      )).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RequirementRow extends StatelessWidget {
  final IconData? icon;
  final Color? iconColor;
  final Widget? customIcon;
  final String title;
  final String? value;
  final Widget? child;

  const _RequirementRow({
    this.icon,
    this.iconColor,
    this.customIcon,
    required this.title,
    this.value,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (customIcon != null)
          customIcon!
        else
          Icon(icon, size: 20, color: iconColor),
        AppSpacing.gapH3,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.gray600,
                ),
              ),
              if (value != null)
                Text(
                  value!,
                  style: AppTypography.body.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.gray900,
                  ),
                ),
              if (child != null) ...[
                const SizedBox(height: 4),
                child!,
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _TimelineItem {
  final String title;
  final String date;
  final Color color;
  final IconData icon;

  const _TimelineItem({
    required this.title,
    required this.date,
    required this.color,
    required this.icon,
  });
}

class _MockCampaignData {
  final String personName;
  final int daysRemaining;
  final int applicants;
  final String minFollowers;
  final String location;
  final String audienceAgeRange;
  final String engagementRate;
  final List<String> deliverables;
  final List<_TimelineItem> timeline;

  const _MockCampaignData({
    required this.personName,
    required this.daysRemaining,
    required this.applicants,
    required this.minFollowers,
    required this.location,
    required this.audienceAgeRange,
    required this.engagementRate,
    required this.deliverables,
    required this.timeline,
  });
}

class _ApplyModal extends StatefulWidget {
  final Future<void> Function(double? proposedRate, String message) onSubmit;
  final double budgetMin;
  final double budgetMax;

  const _ApplyModal({
    required this.onSubmit,
    required this.budgetMin,
    required this.budgetMax,
  });

  @override
  State<_ApplyModal> createState() => _ApplyModalState();
}

class _ApplyModalState extends State<_ApplyModal> {
  final _rateController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isSubmitting = false;
  static const int _maxMessageLength = 500;

  @override
  void dispose() {
    _rateController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      constraints: const BoxConstraints(maxWidth: 512),
      margin: EdgeInsets.only(bottom: bottomPadding),
      decoration: const BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Apply to Campaign',
                    style: AppTypography.h3.copyWith(
                      color: AppColors.gray900,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(
                      LucideIcons.x,
                      size: 24,
                      color: AppColors.gray500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Info box
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    LucideIcons.lightbulb,
                    size: 20,
                    color: AppColors.gray500,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Make sure your application stands out! Brands receive many applications, so be specific about why you\'re a great fit.',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.gray600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Proposed Rate field
              Text(
                'Proposed Rate (\$${widget.budgetMin.toStringAsFixed(0)} - \$${widget.budgetMax.toStringAsFixed(0)})',
                style: AppTypography.body.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.gray900,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _rateController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter your rate',
                  hintStyle: AppTypography.bodySmall.copyWith(color: AppColors.gray400),
                  filled: true,
                  fillColor: AppColors.card,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.gray200),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.gray200),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.primary, width: 2),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
              ),
              const SizedBox(height: 20),

              // Application Message field
              Text(
                'Application Message',
                style: AppTypography.body.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.gray900,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _messageController,
                maxLines: 5,
                maxLength: _maxMessageLength,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: 'Tell the brand why you\'re the perfect fit for this campaign...',
                  hintStyle: AppTypography.bodySmall.copyWith(color: AppColors.gray400),
                  counterText: '',
                  filled: true,
                  fillColor: AppColors.card,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.gray200),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.gray200),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.primary, width: 2),
                  ),
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${_messageController.text.length}/$_maxMessageLength characters',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.gray500,
                ),
              ),
              const SizedBox(height: 24),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: AppColors.gray100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            'Cancel',
                            style: AppTypography.body.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.gray900,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: _isSubmitting ? null : _handleSubmit,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: _isSubmitting
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                )
                              : Text(
                                  'Submit Application',
                                  style: AppTypography.body.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Safe area padding
              SizedBox(height: MediaQuery.of(context).padding.bottom),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleSubmit() async {
    final rateText = _rateController.text.trim();
    final rate = rateText.isNotEmpty ? double.tryParse(rateText) : null;

    // Validate rate if provided
    if (rateText.isNotEmpty && rate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid number for the rate')),
      );
      return;
    }
    if (rate != null && rate <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Rate must be greater than zero')),
      );
      return;
    }
    if (rate != null && (rate < widget.budgetMin || rate > widget.budgetMax)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Rate should be between \$${widget.budgetMin.toStringAsFixed(0)} and \$${widget.budgetMax.toStringAsFixed(0)}')),
      );
      return;
    }

    setState(() => _isSubmitting = true);
    final message = _messageController.text.trim();

    await widget.onSubmit(rate, message);

    if (mounted) {
      setState(() => _isSubmitting = false);
    }
  }
}
