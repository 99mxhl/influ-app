import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/theme.dart';
import '../../../../shared/models/enums.dart';
import '../../../../shared/widgets/platform_badge.dart';
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
    daysRemaining: 28,
    applicants: 24,
    minFollowers: '10K+',
    location: 'United States',
    deliverables: [
      '2 Instagram feed posts',
      '3 Instagram stories',
      '1 TikTok video (30-60 seconds)',
      'Authentic product reviews',
    ],
    brandInfo: _BrandInfo(
      campaignsPosted: 15,
      rating: 4.8,
      reviews: 32,
      responseTime: '4h',
    ),
  );

  @override
  Widget build(BuildContext context) {
    final campaignAsync = ref.watch(campaignByIdProvider(widget.campaignId));
    final authState = ref.watch(authStateProvider);
    final isInfluencer = authState.user?.type == UserType.influencer;
    final currentUserId = authState.user?.id;

    return Scaffold(
      backgroundColor: AppColors.elevated,
      appBar: AppBar(
        backgroundColor: AppColors.elevated,
        elevation: 0,
        leading: IconButton(
          icon: Icon(LucideIcons.arrowLeft, color: AppColors.gray700),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(LucideIcons.share, color: AppColors.gray700),
            onPressed: _handleShare,
          ),
          IconButton(
            icon: Icon(
              _isBookmarked ? LucideIcons.bookmarkMinus : LucideIcons.bookmark,
              color: _isBookmarked ? AppColors.primary : AppColors.gray700,
            ),
            onPressed: () => setState(() => _isBookmarked = !_isBookmarked),
          ),
        ],
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
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Brand header
                    _buildBrandHeader(campaign),
                    AppSpacing.gapV4,

                    // Campaign title
                    Text(
                      campaign.title,
                      style: AppTypography.displayMedium.copyWith(
                        color: AppColors.gray900,
                      ),
                    ),

                    // Platform badges row
                    if (campaign.platforms.isNotEmpty) ...[
                      AppSpacing.gapV3,
                      PlatformBadgeRow(platforms: campaign.platforms),
                    ],
                    AppSpacing.gapV4,

                    // Quick info grid
                    _buildQuickInfoGrid(campaign),
                    AppSpacing.gapV6,

                    // Description
                    if (campaign.description != null) ...[
                      _buildSectionTitle('Description'),
                      AppSpacing.gapV3,
                      Text(
                        campaign.description!,
                        style: AppTypography.body.copyWith(
                          color: AppColors.gray700,
                        ),
                      ),
                      AppSpacing.gapV6,
                    ],

                    // Requirements
                    _buildRequirementsSection(campaign),
                    AppSpacing.gapV6,

                    // Deliverables
                    _buildDeliverablesSection(),
                    AppSpacing.gapV6,

                    // Brand info
                    _buildBrandInfoSection(campaign),
                    AppSpacing.gapV8,
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

  Widget _buildBrandHeader(Campaign campaign) {
    return Row(
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
                campaign.clientDisplayName ?? 'Brand',
                style: AppTypography.body.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.gray900,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // TODO: Navigate to brand profile
                },
                child: Text(
                  'View Profile',
                  style: AppTypography.bodySmall.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        StatusBadge(
          label: campaign.status == CampaignStatus.active ? 'Open' : campaign.status.displayName,
          status: campaign.status == CampaignStatus.active
              ? BadgeStatus.success
              : BadgeStatus.neutral,
        ),
      ],
    );
  }

  Widget _buildQuickInfoGrid(Campaign campaign) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: AppRadius.card,
        border: Border.all(color: AppColors.gray200),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _QuickInfoItem(
                  icon: LucideIcons.dollarSign,
                  iconColor: AppColors.success,
                  label: 'Budget',
                  value: '\$${campaign.budgetMin.toStringAsFixed(0)} - \$${campaign.budgetMax.toStringAsFixed(0)}',
                ),
              ),
              Expanded(
                child: _QuickInfoItem(
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
                child: _QuickInfoItem(
                  icon: LucideIcons.instagram,
                  iconColor: AppColors.primary,
                  label: 'Platforms',
                  value: campaign.platforms.map((p) => p.displayName).join(', '),
                ),
              ),
              Expanded(
                child: _QuickInfoItem(
                  icon: LucideIcons.users,
                  iconColor: AppColors.info,
                  label: 'Applicants',
                  value: '${_mockData.applicants}',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: AppTypography.body.copyWith(
        fontWeight: FontWeight.w600,
        color: AppColors.gray900,
      ),
    );
  }

  Widget _buildRequirementsSection(Campaign campaign) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Requirements'),
        AppSpacing.gapV3,
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: AppRadius.card,
            border: Border.all(color: AppColors.gray200),
          ),
          child: Column(
            children: [
              _RequirementItem(
                icon: LucideIcons.trendingUp,
                title: 'Minimum Followers',
                value: _mockData.minFollowers,
              ),
              AppSpacing.gapV3,
              _RequirementItem(
                icon: LucideIcons.mapPin,
                title: 'Location',
                value: _mockData.location,
              ),
              AppSpacing.gapV3,
              _RequirementItem(
                icon: LucideIcons.checkCircle2,
                title: 'Categories',
                child: Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: campaign.categories.map((cat) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: AppRadius.radiusFull,
                      ),
                      child: Text(
                        cat,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDeliverablesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Deliverables'),
        AppSpacing.gapV3,
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: AppRadius.card,
            border: Border.all(color: AppColors.gray200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _mockData.deliverables.asMap().entries.map((entry) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: entry.key < _mockData.deliverables.length - 1 ? 8 : 0,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 24,
                      child: Text(
                        '${entry.key + 1}.',
                        style: AppTypography.body.copyWith(
                          color: AppColors.gray700,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        entry.value,
                        style: AppTypography.body.copyWith(
                          color: AppColors.gray700,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildBrandInfoSection(Campaign campaign) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('About ${campaign.clientDisplayName ?? 'Brand'}'),
        AppSpacing.gapV3,
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: AppRadius.card,
            border: Border.all(color: AppColors.gray200),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Campaigns Posted',
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.gray600,
                          ),
                        ),
                        Text(
                          '${_mockData.brandInfo.campaignsPosted}',
                          style: AppTypography.body.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.gray900,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Average Rating',
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.gray600,
                          ),
                        ),
                        Text(
                          '${_mockData.brandInfo.rating} ★ (${_mockData.brandInfo.reviews})',
                          style: AppTypography.body.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.gray900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              AppSpacing.gapV4,
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Response Time',
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.gray600,
                          ),
                        ),
                        Text(
                          _mockData.brandInfo.responseTime,
                          style: AppTypography.body.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.gray900,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                ],
              ),
            ],
          ),
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
      decoration: BoxDecoration(
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
              Icon(LucideIcons.checkCircle2, size: 20, color: AppColors.success),
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

      return AppButton(
        text: 'Apply Now',
        isLoading: _isApplying,
        onPressed: () => _handleApply(context),
      );
    }

    // Default - campaign closed or other state
    return AppButton(
      text: 'Campaign ${campaign.status.displayName}',
      onPressed: null,
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

  Future<void> _handleApply(BuildContext context) async {
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

class _QuickInfoItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;

  const _QuickInfoItem({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: iconColor),
        const SizedBox(width: 8),
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
    );
  }
}

class _RequirementItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? value;
  final Widget? child;

  const _RequirementItem({
    required this.icon,
    required this.title,
    this.value,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: AppColors.primary),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTypography.bodySmall.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.gray900,
                ),
              ),
              if (value != null)
                Text(
                  value!,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.gray600,
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

class _MockCampaignData {
  final int daysRemaining;
  final int applicants;
  final String minFollowers;
  final String location;
  final List<String> deliverables;
  final _BrandInfo brandInfo;

  const _MockCampaignData({
    required this.daysRemaining,
    required this.applicants,
    required this.minFollowers,
    required this.location,
    required this.deliverables,
    required this.brandInfo,
  });
}

class _BrandInfo {
  final int campaignsPosted;
  final double rating;
  final int reviews;
  final String responseTime;

  const _BrandInfo({
    required this.campaignsPosted,
    required this.rating,
    required this.reviews,
    required this.responseTime,
  });
}
