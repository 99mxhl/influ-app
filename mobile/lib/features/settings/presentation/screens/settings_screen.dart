import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/theme.dart';
import '../../../../shared/models/enums.dart';
import '../../../../shared/widgets/widgets.dart';
import '../../../auth/providers/auth_provider.dart';

/// Settings screen matching Figma design 1:1
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _pushNotifications = true;
  bool _emailNotifications = true;

  void _handleLogout() {
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
              context.go(AppRoutes.login);
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

  void _handleDeleteAccount() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account?'),
        content: const Text(
          'Are you sure you want to delete your account? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ref.read(authStateProvider.notifier).logout();
              context.go(AppRoutes.login);
            },
            child: Text(
              'Delete',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    final user = authState.user;
    final isInfluencer = user?.type == UserType.influencer;

    return Scaffold(
      backgroundColor: AppColors.elevated,
      appBar: AppBar(
        backgroundColor: AppColors.elevated,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(LucideIcons.arrowLeft, color: AppColors.gray900),
        ),
        title: Text(
          'Settings',
          style: AppTypography.h3.copyWith(color: AppColors.gray900),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.page,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Account Section
            _SectionHeader(title: 'Account'),
            _SettingsCard(
              children: [
                _SettingItem(
                  icon: LucideIcons.mail,
                  label: 'Email',
                  value: user?.email,
                  onTap: () {},
                ),
                _SettingItem(
                  icon: LucideIcons.lock,
                  label: 'Password',
                  onTap: () {},
                ),
                _SettingItem(
                  icon: LucideIcons.phone,
                  label: 'Phone',
                  value: 'Add phone',
                  onTap: () {},
                  isLast: true,
                ),
              ],
            ),
            AppSpacing.gapV6,

            // Payment Section
            _SectionHeader(title: isInfluencer ? 'Payments' : 'Billing'),
            _SettingsCard(
              children: isInfluencer
                  ? [
                      _SettingItem(
                        icon: LucideIcons.dollarSign,
                        label: 'Payout Settings',
                        onTap: () {},
                        isLast: true,
                      ),
                    ]
                  : [
                      _SettingItem(
                        icon: LucideIcons.creditCard,
                        label: 'Payment Methods',
                        onTap: () {},
                      ),
                      _SettingItem(
                        icon: LucideIcons.fileText,
                        label: 'Billing History',
                        onTap: () {},
                        isLast: true,
                      ),
                    ],
            ),
            AppSpacing.gapV6,

            // Notifications Section
            _SectionHeader(title: 'Notifications'),
            _SettingsCard(
              children: [
                _SettingToggle(
                  icon: LucideIcons.bell,
                  label: 'Push Notifications',
                  value: _pushNotifications,
                  onChanged: (v) => setState(() => _pushNotifications = v),
                ),
                _SettingToggle(
                  icon: LucideIcons.mail,
                  label: 'Email Notifications',
                  value: _emailNotifications,
                  onChanged: (v) => setState(() => _emailNotifications = v),
                  isLast: true,
                ),
              ],
            ),
            AppSpacing.gapV6,

            // Privacy Section
            _SectionHeader(title: 'Privacy & Security'),
            _SettingsCard(
              children: [
                _SettingItem(
                  icon: LucideIcons.shield,
                  label: 'Two-Factor Authentication',
                  onTap: () {},
                ),
                _SettingItem(
                  icon: LucideIcons.users,
                  label: 'Blocked Users',
                  onTap: () {},
                  isLast: true,
                ),
              ],
            ),
            AppSpacing.gapV6,

            // Support Section
            _SectionHeader(title: 'Support'),
            _SettingsCard(
              children: [
                _SettingItem(
                  icon: LucideIcons.helpCircle,
                  label: 'Help Center',
                  onTap: () {},
                ),
                _SettingItem(
                  icon: LucideIcons.mail,
                  label: 'Contact Us',
                  onTap: () {},
                ),
                _SettingItem(
                  icon: LucideIcons.fileText,
                  label: 'Report a Problem',
                  onTap: () {},
                  isLast: true,
                ),
              ],
            ),
            AppSpacing.gapV6,

            // Legal Section
            _SectionHeader(title: 'Legal'),
            _SettingsCard(
              children: [
                _SettingItem(
                  icon: LucideIcons.fileText,
                  label: 'Terms of Service',
                  onTap: () {},
                ),
                _SettingItem(
                  icon: LucideIcons.fileText,
                  label: 'Privacy Policy',
                  onTap: () {},
                ),
                _SettingItem(
                  icon: LucideIcons.fileText,
                  label: 'Licenses',
                  onTap: () {},
                  isLast: true,
                ),
              ],
            ),
            AppSpacing.gapV6,

            // Account Actions
            _SectionHeader(title: 'Account Actions'),
            AppSpacing.gapV3,
            AppButton(
              text: 'Log Out',
              onPressed: _handleLogout,
              variant: AppButtonVariant.outline,
              prefixIcon: Icon(LucideIcons.logOut, size: 20),
            ),
            AppSpacing.gapV3,
            AppButton(
              text: 'Delete Account',
              onPressed: _handleDeleteAccount,
              variant: AppButtonVariant.destructive,
              prefixIcon: Icon(LucideIcons.trash2, size: 20),
            ),
            AppSpacing.gapV8,

            // App Version
            Center(
              child: Text(
                'Influ v1.0.0 (build 42)',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.gray500,
                ),
              ),
            ),
            AppSpacing.gapV6,
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 12),
      child: Text(
        title.toUpperCase(),
        style: AppTypography.overline.copyWith(
          color: AppColors.gray600,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final List<Widget> children;

  const _SettingsCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: AppRadius.card,
        border: Border.all(color: AppColors.gray200),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: children,
      ),
    );
  }
}

class _SettingItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? value;
  final VoidCallback onTap;
  final bool isLast;

  const _SettingItem({
    required this.icon,
    required this.label,
    this.value,
    required this.onTap,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          border: isLast
              ? null
              : Border(
                  bottom: BorderSide(color: AppColors.gray200),
                ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: AppColors.gray500),
            AppSpacing.gapH3,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: AppTypography.body.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.gray900,
                    ),
                  ),
                  if (value != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      value!,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.gray600,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Icon(LucideIcons.chevronRight, size: 20, color: AppColors.gray400),
          ],
        ),
      ),
    );
  }
}

class _SettingToggle extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool isLast;

  const _SettingToggle({
    required this.icon,
    required this.label,
    required this.value,
    required this.onChanged,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(
                bottom: BorderSide(color: AppColors.gray200),
              ),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.gray500),
          AppSpacing.gapH3,
          Expanded(
            child: Text(
              label,
              style: AppTypography.body.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.gray900,
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
