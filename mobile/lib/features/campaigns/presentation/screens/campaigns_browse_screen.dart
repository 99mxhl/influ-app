import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/theme.dart';
import '../../../../shared/models/enums.dart';
import '../../../../shared/widgets/widgets.dart';

/// Campaign browse/discover screen matching Figma design 1:1
class CampaignsBrowseScreen extends ConsumerStatefulWidget {
  const CampaignsBrowseScreen({super.key});

  @override
  ConsumerState<CampaignsBrowseScreen> createState() =>
      _CampaignsBrowseScreenState();
}

class _CampaignsBrowseScreenState extends ConsumerState<CampaignsBrowseScreen> {
  String _selectedCategory = 'All';
  bool _searchOpen = false;
  final _searchController = TextEditingController();

  static const _categories = [
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

  // Mock data - in real app would come from provider
  final _campaigns = [
    _CampaignData(
      id: '1',
      title: 'Summer Fashion Collection 2026',
      brandName: 'StyleCo',
      budgetMin: 500,
      budgetMax: 2000,
      platforms: ['instagram', 'tiktok'],
      postedDate: '2 days ago',
      applicants: 24,
      category: 'Fashion',
    ),
    _CampaignData(
      id: '2',
      title: 'Tech Product Review Series',
      brandName: 'TechCorp',
      budgetMin: 1000,
      budgetMax: 3000,
      platforms: ['youtube'],
      postedDate: '5 days ago',
      applicants: 18,
      category: 'Tech',
    ),
    _CampaignData(
      id: '3',
      title: 'Fitness App Launch Campaign',
      brandName: 'FitLife',
      budgetMin: 800,
      budgetMax: 2500,
      platforms: ['instagram', 'youtube'],
      postedDate: '1 week ago',
      applicants: 31,
      category: 'Fitness',
    ),
    _CampaignData(
      id: '4',
      title: 'Beauty Product Unboxing',
      brandName: 'GlowBeauty',
      budgetMin: 600,
      budgetMax: 1500,
      platforms: ['instagram', 'tiktok'],
      postedDate: '3 days ago',
      applicants: 42,
      category: 'Beauty',
    ),
  ];

  List<_CampaignData> get _filteredCampaigns {
    if (_selectedCategory == 'All') return _campaigns;
    return _campaigns.where((c) => c.category == _selectedCategory).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.elevated,
      appBar: AppBar(
        backgroundColor: AppColors.elevated,
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
                        decoration: InputDecoration(
                          hintText: 'Search campaigns...',
                          border: OutlineInputBorder(
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
                      onPressed: () => setState(() => _searchOpen = false),
                      child: Text(
                        'Cancel',
                        style: AppTypography.body.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
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
          if (!_searchOpen) ...[
            // Category filter chips
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
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: AppColors.gray200)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${_filteredCampaigns.length} campaigns found',
                    style: AppTypography.bodySmall.copyWith(color: AppColors.gray600),
                  ),
                  GestureDetector(
                    onTap: () {
                      // TODO: Open filters
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
            ),
          ],

          // Campaign list
          Expanded(
            child: _filteredCampaigns.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredCampaigns.length,
                    itemBuilder: (context, index) {
                      final campaign = _filteredCampaigns[index];
                      return _CampaignCard(
                        campaign: campaign,
                        onTap: () => context.push('/campaigns/${campaign.id}'),
                      );
                    },
                  ),
          ),
        ],
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
  final _CampaignData campaign;
  final VoidCallback onTap;

  const _CampaignCard({
    required this.campaign,
    required this.onTap,
  });

  Widget _getPlatformIcon(Platform platform) {
    switch (platform) {
      case Platform.instagram:
        return const Icon(LucideIcons.instagram, size: 16, color: AppColors.gray600);
      case Platform.youtube:
        return const Icon(LucideIcons.youtube, size: 16, color: AppColors.gray600);
      case Platform.tiktok:
        return const Icon(LucideIcons.music, size: 16, color: AppColors.gray600);
      case Platform.twitter:
        return const Icon(LucideIcons.twitter, size: 16, color: AppColors.gray600);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: AppRadius.card,
        border: Border.all(color: AppColors.gray200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Brand header
          Row(
            children: [
              UserAvatar(
                name: campaign.brandName,
                size: AvatarSize.sm,
                verified: true,
              ),
              AppSpacing.gapH3,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      campaign.brandName,
                      style: AppTypography.body.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.gray900,
                      ),
                    ),
                    Text(
                      'Posted ${campaign.postedDate}',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.gray500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          AppSpacing.gapV3,

          // Campaign title
          Text(
            campaign.title,
            style: AppTypography.body.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.gray900,
            ),
          ),
          AppSpacing.gapV3,

          // Info row
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(LucideIcons.dollarSign, size: 16, color: AppColors.gray600),
                  const SizedBox(width: 4),
                  Text(
                    '\$${campaign.budgetMin.toStringAsFixed(0)} - \$${campaign.budgetMax.toStringAsFixed(0)}',
                    style: AppTypography.bodySmall.copyWith(color: AppColors.gray600),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: (List<Platform>.from(campaign.platforms)..sort((a, b) => a.name.compareTo(b.name)))
                    .map(_getPlatformIcon)
                    .toList(),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(LucideIcons.users, size: 16, color: AppColors.gray600),
                  const SizedBox(width: 4),
                  Text(
                    '${campaign.applicants} applicants',
                    style: AppTypography.bodySmall.copyWith(color: AppColors.gray600),
                  ),
                ],
              ),
            ],
          ),
          AppSpacing.gapV4,

          // Action button
          AppButton(
            text: 'View Details',
            onPressed: onTap,
          ),
        ],
      ),
    );
  }
}

class _CampaignData {
  final String id;
  final String title;
  final String brandName;
  final double budgetMin;
  final double budgetMax;
  final List<String> platforms;
  final String postedDate;
  final int applicants;
  final String category;

  const _CampaignData({
    required this.id,
    required this.title,
    required this.brandName,
    required this.budgetMin,
    required this.budgetMax,
    required this.platforms,
    required this.postedDate,
    required this.applicants,
    required this.category,
  });
}
