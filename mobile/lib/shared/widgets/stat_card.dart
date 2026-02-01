import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../core/theme/theme.dart';

/// Statistics card component
/// Matches the Figma StatCard component exactly
class StatCard extends StatelessWidget {
  final String label;
  final String value;
  final Widget? icon;
  final StatTrend? trend;
  final VoidCallback? onTap;

  const StatCard({
    super.key,
    required this.label,
    required this.value,
    this.icon,
    this.trend,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.card,
      borderRadius: AppRadius.card,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.card,
        child: Container(
          padding: AppSpacing.p4,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.gray200),
            borderRadius: AppRadius.card,
            boxShadow: AppShadows.elevation1,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Top row: label and icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      label,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.gray600,
                      ),
                    ),
                  ),
                  if (icon != null)
                    IconTheme(
                      data: const IconThemeData(
                        color: AppColors.gray400,
                        size: 20,
                      ),
                      child: icon!,
                    ),
                ],
              ),
              AppSpacing.gapV2,

              // Bottom row: value and arrow
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                      value,
                      style: AppTypography.displayMedium.copyWith(
                        color: AppColors.gray900,
                      ),
                    ),
                  ),
                  if (onTap != null)
                    Icon(
                      LucideIcons.arrowUpRight,
                      color: AppColors.gray400,
                      size: 16,
                    ),
                ],
              ),

              // Trend
              if (trend != null) ...[
                AppSpacing.gapV1,
                Text(
                  '${trend!.isPositive ? '+' : ''}${trend!.value}',
                  style: AppTypography.bodySmall.copyWith(
                    color: trend!.isPositive ? AppColors.success : AppColors.error,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Trend data for stat cards
class StatTrend {
  final String value;
  final bool isPositive;

  const StatTrend({
    required this.value,
    required this.isPositive,
  });
}
