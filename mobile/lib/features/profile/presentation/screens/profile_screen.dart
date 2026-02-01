import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/theme.dart';
import '../../../../shared/models/enums.dart';
import '../../../../shared/widgets/widgets.dart';
import '../../../auth/providers/auth_provider.dart';

/// Profile screen matching Figma design 1:1
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

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
    final influencerProfile = user.influencerProfile;

    // Mock profile data (in real app, this would come from the user object)
    final profileData = isInfluencer
        ? _InfluencerProfileData(
            followers: '150K',
            campaigns: influencerProfile?.completedDeals ?? 24,
            rating: influencerProfile?.avgRating ?? 4.8,
            responseTime: '2h',
            bio: user.profile?.bio ??
                'Fashion & lifestyle content creator. Passionate about sustainable fashion and authentic storytelling.',
            location: 'New York, NY',
            categories: influencerProfile?.categories ?? ['Fashion', 'Lifestyle', 'Beauty'],
            socials: [
              _Social(
                platform: 'Instagram',
                handle: influencerProfile?.instagramHandle ?? '@sarahjohnson',
                followers: '150K',
              ),
              _Social(
                platform: 'YouTube',
                handle: influencerProfile?.youtubeHandle ?? 'Sarah Johnson',
                followers: '85K',
              ),
            ],
          )
        : _ClientProfileData(
            campaigns: 12,
            deals: 34,
            rating: 4.9,
            reviews: 18,
            bio: user.profile?.bio ??
                'Leading technology company focused on innovative consumer electronics.',
            location: 'San Francisco, CA',
          );

    return Scaffold(
      backgroundColor: AppColors.elevated,
      body: Column(
        children: [
          // Custom app bar
          Container(
            decoration: BoxDecoration(
              gradient: AppColors.gradientPrimary,
            ),
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  // Top bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 48),
                        Text(
                          'Profile',
                          style: AppTypography.h3.copyWith(color: Colors.white),
                        ),
                        IconButton(
                          onPressed: () => context.push(AppRoutes.settings),
                          icon: const Icon(
                            LucideIcons.settings,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Avatar and name
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 48),
                    child: Column(
                      children: [
                        UserAvatar(
                          imageUrl: user.profile?.avatarUrl,
                          name: displayName,
                          size: AvatarSize.xxl,
                          verified: true,
                        ),
                        AppSpacing.gapV4,
                        Text(
                          displayName,
                          style: AppTypography.displayMedium.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        AppSpacing.gapV1,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              LucideIcons.mapPin,
                              size: 16,
                              color: Colors.white.withOpacity(0.9),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              profileData.location,
                              style: AppTypography.body.copyWith(
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Stats card overlapping header
          Transform.translate(
            offset: const Offset(0, -32),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: AppRadius.card,
                  border: Border.all(color: AppColors.gray200),
                  boxShadow: AppShadows.elevation2,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: isInfluencer
                      ? [
                          _StatItem(
                            value: (profileData as _InfluencerProfileData).followers,
                            label: 'Followers',
                          ),
                          _StatItem(
                            value: '${profileData.campaigns}',
                            label: 'Campaigns',
                          ),
                          _StatItem(
                            value: profileData.rating.toString(),
                            label: 'Rating',
                          ),
                          _StatItem(
                            value: profileData.responseTime,
                            label: 'Response',
                          ),
                        ]
                      : [
                          _StatItem(
                            value: '${(profileData as _ClientProfileData).campaigns}',
                            label: 'Campaigns',
                          ),
                          _StatItem(
                            value: '${profileData.deals}',
                            label: 'Deals',
                          ),
                          _StatItem(
                            value: profileData.rating.toString(),
                            label: 'Rating',
                          ),
                          _StatItem(
                            value: '${profileData.reviews}',
                            label: 'Reviews',
                          ),
                        ],
                ),
              ),
            ),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Bio section
                  _SectionCard(
                    title: 'About',
                    child: Text(
                      profileData.bio,
                      style: AppTypography.body.copyWith(
                        color: AppColors.gray700,
                      ),
                    ),
                  ),
                  AppSpacing.gapV4,

                  // Categories (influencer only)
                  if (isInfluencer) ...[
                    _SectionCard(
                      title: 'Categories',
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: (profileData as _InfluencerProfileData)
                            .categories
                            .map((cat) => Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryLight,
                                    borderRadius: AppRadius.chip,
                                  ),
                                  child: Text(
                                    cat,
                                    style: AppTypography.bodySmall.copyWith(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                    AppSpacing.gapV4,

                    // Social platforms
                    _SectionCard(
                      title: 'Social Platforms',
                      child: Column(
                        children: profileData.socials
                            .map((social) => _SocialRow(social: social))
                            .toList(),
                      ),
                    ),
                    AppSpacing.gapV4,
                  ],

                  // Action buttons
                  AppButton(
                    text: 'Edit Profile',
                    onPressed: () => context.push(AppRoutes.editProfile),
                    variant: AppButtonVariant.outline,
                  ),
                  AppSpacing.gapV3,
                  AppButton(
                    text: 'Settings',
                    onPressed: () => context.push(AppRoutes.settings),
                    variant: AppButtonVariant.secondary,
                    prefixIcon: Icon(LucideIcons.settings, size: 20),
                  ),
                  AppSpacing.gapV3,
                  AppButton(
                    text: 'Log Out',
                    onPressed: () => _showLogoutConfirmation(context, ref),
                    variant: AppButtonVariant.destructive,
                    prefixIcon: Icon(LucideIcons.logOut, size: 20),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Out?'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ref.read(authStateProvider.notifier).logout();
            },
            child: Text(
              'Sign Out',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: AppTypography.h3.copyWith(
            color: AppColors.gray900,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.gray600,
          ),
        ),
      ],
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _SectionCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: AppRadius.card,
        border: Border.all(color: AppColors.gray200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTypography.body.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.gray900,
            ),
          ),
          AppSpacing.gapV3,
          child,
        ],
      ),
    );
  }
}

class _SocialRow extends StatelessWidget {
  final _Social social;

  const _SocialRow({required this.social});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            social.platform == 'Instagram'
                ? LucideIcons.instagram
                : LucideIcons.youtube,
            size: 20,
            color: social.platform == 'Instagram'
                ? AppColors.primary
                : AppColors.error,
          ),
          AppSpacing.gapH3,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  social.handle,
                  style: AppTypography.body.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.gray900,
                  ),
                ),
                Text(
                  social.platform,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.gray600,
                  ),
                ),
              ],
            ),
          ),
          Text(
            social.followers,
            style: AppTypography.body.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.gray700,
            ),
          ),
        ],
      ),
    );
  }
}

// Data models
abstract class _ProfileData {
  String get bio;
  String get location;
}

class _InfluencerProfileData implements _ProfileData {
  final String followers;
  final int campaigns;
  final double rating;
  final String responseTime;
  @override
  final String bio;
  @override
  final String location;
  final List<String> categories;
  final List<_Social> socials;

  const _InfluencerProfileData({
    required this.followers,
    required this.campaigns,
    required this.rating,
    required this.responseTime,
    required this.bio,
    required this.location,
    required this.categories,
    required this.socials,
  });
}

class _ClientProfileData implements _ProfileData {
  final int campaigns;
  final int deals;
  final double rating;
  final int reviews;
  @override
  final String bio;
  @override
  final String location;

  const _ClientProfileData({
    required this.campaigns,
    required this.deals,
    required this.rating,
    required this.reviews,
    required this.bio,
    required this.location,
  });
}

class _Social {
  final String platform;
  final String handle;
  final String followers;

  const _Social({
    required this.platform,
    required this.handle,
    required this.followers,
  });
}
