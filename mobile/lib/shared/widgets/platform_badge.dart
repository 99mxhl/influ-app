import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../models/enums.dart';

/// Platform badge widget displaying a 24x24 circular badge
/// with platform brand color background and white text abbreviation.
class PlatformBadge extends StatelessWidget {
  final Platform platform;
  final double size;

  const PlatformBadge({
    super.key,
    required this.platform,
    this.size = 24,
  });

  Color get _backgroundColor {
    switch (platform) {
      case Platform.instagram:
        return AppColors.instagram;
      case Platform.youtube:
        return AppColors.youtube;
      case Platform.twitter:
        return AppColors.xTwitter;
      case Platform.facebook:
        return AppColors.facebook;
      case Platform.tiktok:
        return AppColors.tiktok;
    }
  }

  /// Text abbreviation for the platform (more accurate than generic icons).
  String get _abbreviation {
    switch (platform) {
      case Platform.instagram:
        return 'IG';
      case Platform.youtube:
        return 'YT';
      case Platform.twitter:
        return 'X';
      case Platform.facebook:
        return 'FB';
      case Platform.tiktok:
        return 'TT';
    }
  }

  /// Whether this badge needs a border for visibility (black backgrounds).
  bool get _needsBorder {
    return platform == Platform.twitter || platform == Platform.tiktok;
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: platform.displayName,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: _backgroundColor,
          shape: BoxShape.circle,
          border: _needsBorder
              ? Border.all(color: AppColors.gray300, width: 1)
              : null,
        ),
        child: Center(
          child: Text(
            _abbreviation,
            style: TextStyle(
              color: Colors.white,
              fontSize: size * 0.4,
              fontWeight: FontWeight.bold,
              height: 1,
            ),
          ),
        ),
      ),
    );
  }
}

/// Row of platform badges with 4px spacing between them.
class PlatformBadgeRow extends StatelessWidget {
  final List<Platform> platforms;
  final double badgeSize;

  const PlatformBadgeRow({
    super.key,
    required this.platforms,
    this.badgeSize = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: platforms
          .map((platform) => PlatformBadge(
                platform: platform,
                size: badgeSize,
              ))
          .toList(),
    );
  }
}
