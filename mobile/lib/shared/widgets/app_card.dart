import 'package:flutter/material.dart';

import '../../core/theme/theme.dart';

/// Card component matching Figma design
class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? borderColor;
  final bool elevated;
  final BorderRadius? borderRadius;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.backgroundColor,
    this.borderColor,
    this.elevated = false,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor ?? AppColors.card,
      borderRadius: borderRadius ?? AppRadius.card,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius ?? AppRadius.card,
        child: Container(
          padding: padding ?? AppSpacing.card,
          decoration: BoxDecoration(
            border: Border.all(
              color: borderColor ?? AppColors.border,
            ),
            borderRadius: borderRadius ?? AppRadius.card,
            boxShadow: elevated ? AppShadows.elevation2 : AppShadows.elevation1,
          ),
          child: child,
        ),
      ),
    );
  }
}

/// Interactive card with chevron indicator
class InteractiveCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Color? borderColor;
  final bool showChevron;

  const InteractiveCard({
    super.key,
    required this.child,
    this.onTap,
    this.borderColor,
    this.showChevron = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      borderColor: borderColor,
      child: Row(
        children: [
          Expanded(child: child),
          if (showChevron && onTap != null)
            Icon(
              Icons.chevron_right,
              color: AppColors.gray400,
              size: 20,
            ),
        ],
      ),
    );
  }
}

/// Action required card with urgency indicator
class ActionCard extends StatelessWidget {
  final String title;
  final String description;
  final String? subtitle;
  final bool urgent;
  final VoidCallback? onTap;

  const ActionCard({
    super.key,
    required this.title,
    required this.description,
    this.subtitle,
    this.urgent = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      borderColor: urgent ? AppColors.error : null,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Urgency indicator dot
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: urgent ? AppColors.error : AppColors.warning,
              shape: BoxShape.circle,
            ),
          ),
          AppSpacing.gapH3,

          // Content
          Expanded(
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
                AppSpacing.gapV1,
                Text(
                  description,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.gray600,
                  ),
                ),
                if (subtitle != null) ...[
                  AppSpacing.gapV1,
                  Text(
                    subtitle!,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.gray500,
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Chevron
          if (onTap != null)
            Icon(
              Icons.chevron_right,
              color: AppColors.gray400,
              size: 20,
            ),
        ],
      ),
    );
  }
}
