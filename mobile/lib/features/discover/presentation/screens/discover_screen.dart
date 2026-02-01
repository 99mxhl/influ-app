import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/theme.dart';
import '../../../../shared/models/enums.dart';
import '../../../../shared/widgets/widgets.dart';
import '../../../campaigns/data/models/campaign.dart';
import '../../../campaigns/providers/campaigns_provider.dart';

/// Discover screen for influencers to browse available campaigns
/// Matches Figma CampaignBrowse design 1:1
class DiscoverScreen extends ConsumerStatefulWidget {
  const DiscoverScreen({super.key});

  @override
  ConsumerState<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends ConsumerState<DiscoverScreen> {
  String _selectedCategory = 'All';
  bool _searchOpen = false;
  final _searchController = TextEditingController();
  String _searchQuery = '';

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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Campaign> _filterCampaigns(List<Campaign> campaigns) {
    return campaigns.where((campaign) {
      // Filter by category
      if (_selectedCategory != 'All') {
        final hasCategory = campaign.categories
            .any((c) => c.toLowerCase() == _selectedCategory.toLowerCase());
        if (!hasCategory) return false;
      }

      // Filter by search query
      if (_searchQuery.isNotEmpty) {
        final query = _searchQuery.toLowerCase();
        final title = campaign.title.toLowerCase();
        final description = (campaign.description ?? '').toLowerCase();
        return title.contains(query) || description.contains(query);
      }

      return true;
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
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: _searchOpen
            ? null
            : Text('Discover', style: AppTypography.h3.copyWith(color: AppColors.gray900)),
        actions: [
          if (_searchOpen) ...[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        autofocus: true,
                        onChanged: (value) => setState(() => _searchQuery = value),
                        decoration: InputDecoration(
                          hintText: 'Search campaigns...',
                          hintStyle: AppTypography.body.copyWith(color: AppColors.gray400),
                          filled: true,
                          fillColor: AppColors.gray100,
                          border: OutlineInputBorder(
                            borderRadius: AppRadius.button,
                            borderSide: BorderSide(color: AppColors.gray300),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: AppRadius.button,
                            borderSide: BorderSide(color: AppColors.gray300),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _searchOpen = false;
                          _searchQuery = '';
                          _searchController.clear();
                        });
                      },
                      child: Text(
                        'Cancel',
                        style: AppTypography.body.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ] else ...[
            IconButton(
              onPressed: () => setState(() => _searchOpen = true),
              icon: Icon(LucideIcons.search, color: AppColors.gray700),
            ),
          ],
        ],
      ),
      body: Column(
        children: [
          // Category filter chips
          if (!_searchOpen) ...[
            Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: AppColors.gray200)),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: _categories.map((category) {
                    final isSelected = _selectedCategory == category;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedCategory = category),
                        child: AnimatedContainer(
                          duration: AppDurations.fast,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.primary : AppColors.gray100,
                            borderRadius: AppRadius.radiusFull,
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
            ),

            // Filter bar
            if (campaignsState.hasLoaded) ...[
              Builder(
                builder: (context) {
                  final filtered = _filterCampaigns(campaignsState.campaigns);
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: AppColors.gray200)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${filtered.length} campaigns found',
                          style: AppTypography.bodySmall.copyWith(color: AppColors.gray600),
                        ),
                        GestureDetector(
                          onTap: () {
                            // TODO: Open filters modal
                          },
                          child: Row(
                            children: [
                              Icon(LucideIcons.filter, size: 16, color: AppColors.primary),
                              const SizedBox(width: 4),
                              Text(
                                'Filters',
                                style: AppTypography.bodySmall.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ],

          // Campaign list
          Expanded(
            child: _buildCampaignList(campaignsState),
          ),
        ],
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
      return _buildEmptyState();
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(campaignsProvider.notifier).loadCampaigns(refresh: true),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: filtered.length,
        itemBuilder: (context, index) {
          final campaign = filtered[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _CampaignCard(
              campaign: campaign,
              timeAgo: _formatTimeAgo(campaign.createdAt),
              onTap: () => context.push('/campaigns/${campaign.id}'),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: AppSpacing.page,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('🔍', style: TextStyle(fontSize: 64)),
            AppSpacing.gapV4,
            Text(
              'No campaigns found',
              style: AppTypography.h3.copyWith(color: AppColors.gray900),
            ),
            AppSpacing.gapV2,
            Text(
              'Try adjusting your filters or check back later',
              style: AppTypography.body.copyWith(color: AppColors.gray600),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _CampaignCard extends StatelessWidget {
  final Campaign campaign;
  final String timeAgo;
  final VoidCallback onTap;

  const _CampaignCard({
    required this.campaign,
    required this.timeAgo,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: AppRadius.card,
        border: Border.all(color: AppColors.gray200),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Brand header
          Row(
            children: [
              UserAvatar(
                name: campaign.clientName ?? 'Brand',
                size: AvatarSize.sm,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            campaign.clientName ?? 'Brand',
                            style: AppTypography.body.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.gray900,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(LucideIcons.badgeCheck, size: 16, color: AppColors.primary),
                      ],
                    ),
                    Text(
                      'Posted $timeAgo',
                      style: AppTypography.bodySmall.copyWith(color: AppColors.gray500),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Campaign title
          Text(
            campaign.title,
            style: AppTypography.body.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.gray900,
            ),
          ),

          const SizedBox(height: 12),

          // Info row
          Wrap(
            spacing: 16,
            runSpacing: 8,
            children: [
              // Budget
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(LucideIcons.dollarSign, size: 16, color: AppColors.gray600),
                  const SizedBox(width: 4),
                  Text(
                    '\$${campaign.budgetMin?.toInt() ?? 0} - \$${campaign.budgetMax?.toInt() ?? 0}',
                    style: AppTypography.bodySmall.copyWith(color: AppColors.gray600),
                  ),
                ],
              ),

              // Platforms
              Row(
                mainAxisSize: MainAxisSize.min,
                children: campaign.platforms.take(3).map((platform) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: Icon(
                      _getPlatformIcon(platform),
                      size: 16,
                      color: AppColors.gray600,
                    ),
                  );
                }).toList(),
              ),

              // Applicants
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(LucideIcons.users, size: 16, color: AppColors.gray600),
                  const SizedBox(width: 4),
                  Text(
                    '${campaign.applicantCount ?? 0} applicants',
                    style: AppTypography.bodySmall.copyWith(color: AppColors.gray600),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),

          // View Details button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: AppRadius.button),
              ),
              child: Text(
                'View Details',
                style: AppTypography.body.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getPlatformIcon(Platform platform) {
    return switch (platform) {
      Platform.instagram => LucideIcons.instagram,
      Platform.tiktok => LucideIcons.music2,
      Platform.youtube => LucideIcons.youtube,
      Platform.twitter => LucideIcons.twitter,
      Platform.facebook => LucideIcons.facebook,
    };
  }
}
