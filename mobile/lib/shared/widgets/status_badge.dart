import 'package:flutter/material.dart';

import '../../core/theme/theme.dart';

/// Status badge types matching Figma design
enum BadgeStatus {
  success,
  warning,
  error,
  info,
  neutral,
  primary,
}

/// Status badge sizes
enum BadgeSize {
  sm(2, 8, 10),
  md(4, 8, 11);

  final double verticalPadding;
  final double horizontalPadding;
  final double fontSize;

  const BadgeSize(this.verticalPadding, this.horizontalPadding, this.fontSize);
}

/// Status pill/badge component
/// Matches the Figma StatusBadge component exactly
class StatusBadge extends StatelessWidget {
  final BadgeStatus status;
  final String label;
  final BadgeSize size;

  const StatusBadge({
    super.key,
    required this.status,
    required this.label,
    this.size = BadgeSize.md,
  });

  (Color, Color) get _colors {
    switch (status) {
      case BadgeStatus.success:
        return (AppColors.successLight, AppColors.successDark);
      case BadgeStatus.warning:
        return (AppColors.warningLight, AppColors.warningDark);
      case BadgeStatus.error:
        return (AppColors.errorLight, AppColors.errorDark);
      case BadgeStatus.info:
        return (AppColors.infoLight, AppColors.infoDark);
      case BadgeStatus.neutral:
        return (AppColors.gray100, AppColors.gray700);
      case BadgeStatus.primary:
        return (AppColors.primaryLight, AppColors.primary);
    }
  }

  @override
  Widget build(BuildContext context) {
    final (bgColor, textColor) = _colors;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size.horizontalPadding,
        vertical: size.verticalPadding,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: AppRadius.radiusFull,
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: size.fontSize,
          fontWeight: FontWeight.w600,
          height: 1.2,
        ),
      ),
    );
  }
}

/// Deal status badge with predefined statuses
class DealStatusBadge extends StatelessWidget {
  final String status;
  final BadgeSize size;

  const DealStatusBadge({
    super.key,
    required this.status,
    this.size = BadgeSize.md,
  });

  (BadgeStatus, String) get _statusInfo {
    switch (status.toUpperCase()) {
      case 'IDLE':
        return (BadgeStatus.neutral, 'Idle');
      case 'INVITED':
        return (BadgeStatus.info, 'Invited');
      case 'APPLIED':
        return (BadgeStatus.info, 'Applied');
      case 'NEGOTIATING':
        return (BadgeStatus.warning, 'Negotiating');
      case 'TERMS_ACCEPTED':
        return (BadgeStatus.primary, 'Terms Accepted');
      case 'ACTIVE':
        return (BadgeStatus.primary, 'Active');
      case 'CONTENT_SUBMITTED':
        return (BadgeStatus.warning, 'Content Submitted');
      case 'COMPLETED':
        return (BadgeStatus.success, 'Completed');
      case 'DISPUTED':
        return (BadgeStatus.error, 'Disputed');
      case 'CANCELLED':
        return (BadgeStatus.neutral, 'Cancelled');
      default:
        return (BadgeStatus.neutral, status);
    }
  }

  @override
  Widget build(BuildContext context) {
    final (badgeStatus, label) = _statusInfo;
    return StatusBadge(
      status: badgeStatus,
      label: label,
      size: size,
    );
  }
}
