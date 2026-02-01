import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../core/theme/theme.dart';
import 'app_button.dart';

/// Error display widget matching Figma design
class AppErrorWidget extends StatelessWidget {
  final String title;
  final String? message;
  final VoidCallback? onRetry;
  final IconData? icon;

  const AppErrorWidget({
    super.key,
    this.title = 'Something went wrong',
    this.message,
    this.onRetry,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppSpacing.page,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon ?? LucideIcons.alertCircle,
              size: 48,
              color: AppColors.gray400,
            ),
            AppSpacing.gapV4,
            Text(
              title,
              style: AppTypography.h2.copyWith(color: AppColors.gray900),
              textAlign: TextAlign.center,
            ),
            if (message != null) ...[
              AppSpacing.gapV2,
              Text(
                message!,
                style: AppTypography.body.copyWith(color: AppColors.gray600),
                textAlign: TextAlign.center,
              ),
            ],
            if (onRetry != null) ...[
              AppSpacing.gapV6,
              AppButton(
                text: 'Try Again',
                onPressed: onRetry,
                fullWidth: false,
                size: AppButtonSize.md,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Network error widget
class NetworkErrorWidget extends StatelessWidget {
  final VoidCallback? onRetry;

  const NetworkErrorWidget({super.key, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return AppErrorWidget(
      title: 'Connection Failed',
      message: 'Please check your internet connection',
      icon: LucideIcons.wifiOff,
      onRetry: onRetry,
    );
  }
}

/// Empty state widget
class EmptyStateWidget extends StatelessWidget {
  final String title;
  final String? message;
  final IconData? icon;
  final String? actionLabel;
  final VoidCallback? onAction;

  const EmptyStateWidget({
    super.key,
    required this.title,
    this.message,
    this.icon,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppSpacing.page,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon ?? LucideIcons.inbox,
              size: 64,
              color: AppColors.gray300,
            ),
            AppSpacing.gapV4,
            Text(
              title,
              style: AppTypography.h2.copyWith(color: AppColors.gray900),
              textAlign: TextAlign.center,
            ),
            if (message != null) ...[
              AppSpacing.gapV2,
              Text(
                message!,
                style: AppTypography.body.copyWith(color: AppColors.gray600),
                textAlign: TextAlign.center,
              ),
            ],
            if (actionLabel != null && onAction != null) ...[
              AppSpacing.gapV6,
              AppButton(
                text: actionLabel!,
                onPressed: onAction,
                fullWidth: false,
                size: AppButtonSize.md,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Error message banner (for inline errors)
class ErrorBanner extends StatelessWidget {
  final String message;
  final VoidCallback? onDismiss;

  const ErrorBanner({
    super.key,
    required this.message,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.errorLight,
        borderRadius: AppRadius.button,
      ),
      child: Row(
        children: [
          Icon(
            LucideIcons.alertCircle,
            color: AppColors.errorDark,
            size: 20,
          ),
          AppSpacing.gapH3,
          Expanded(
            child: Text(
              message,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.errorDark,
              ),
            ),
          ),
          if (onDismiss != null)
            GestureDetector(
              onTap: onDismiss,
              child: Icon(
                LucideIcons.x,
                color: AppColors.errorDark,
                size: 16,
              ),
            ),
        ],
      ),
    );
  }
}
