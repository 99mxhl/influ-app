import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/theme.dart';
import '../../../../shared/widgets/widgets.dart';
import '../../providers/auth_provider.dart';

/// Splash screen matching Figma design
/// Displays branding while checking auth state
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _checkAuthAndNavigate();
  }

  Future<void> _checkAuthAndNavigate() async {
    try {
      // Simulate loading time for branding display
      await Future.delayed(const Duration(milliseconds: 2000));

      if (!mounted) return;

      final authState = ref.read(authStateProvider);

      if (authState.isLoading) {
        // Listen for when loading finishes
        ref.listenManual(authStateProvider, (previous, next) {
          if (!next.isLoading && mounted) {
            _navigate(next.isAuthenticated);
          }
        });
      } else {
        _navigate(authState.isAuthenticated);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _hasError = true);
      }
    }
  }

  void _navigate(bool isAuthenticated) {
    if (!mounted) return;

    if (isAuthenticated) {
      context.go(AppRoutes.home);
    } else {
      // TODO: Check if onboarding has been seen from local storage
      // For new users, show onboarding first
      context.go(AppRoutes.onboarding);
    }
  }

  void _retry() {
    setState(() => _hasError = false);
    _checkAuthAndNavigate();
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return Scaffold(
        backgroundColor: AppColors.elevated,
        body: Center(
          child: Padding(
            padding: AppSpacing.page,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Connection Failed',
                  style: AppTypography.displayMedium.copyWith(
                    color: AppColors.gray900,
                  ),
                ),
                AppSpacing.gapV2,
                Text(
                  'Please check your internet connection',
                  style: AppTypography.body.copyWith(
                    color: AppColors.gray600,
                  ),
                ),
                AppSpacing.gapV6,
                AppButton(
                  text: 'Retry',
                  onPressed: _retry,
                  fullWidth: false,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.elevated,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Logo with gradient background
            LogoContainer(
              size: 96,
              animate: true,
              child: Icon(
                LucideIcons.users,
                color: Colors.white,
                size: 48,
              ),
            ),
            AppSpacing.gapV6,

            // Brand name
            Text(
              'Influ',
              style: AppTypography.displayLarge.copyWith(
                color: AppColors.gray900,
              ),
            ),
            AppSpacing.gapV1,
            Text(
              'Where brands meet creators',
              style: AppTypography.body.copyWith(
                color: AppColors.gray600,
              ),
            ),

            // Loading indicator
            AppSpacing.gapV8,
            const BouncingDotsIndicator(),
          ],
        ),
      ),
    );
  }
}
