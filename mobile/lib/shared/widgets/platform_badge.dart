import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../models/enums.dart';

/// Platform badge widget displaying a 24x24 circular badge
/// with platform brand color background and white icon.
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

  IconData get _icon {
    switch (platform) {
      case Platform.instagram:
        return Icons.camera_alt;
      case Platform.youtube:
        return Icons.play_arrow;
      case Platform.twitter:
        return Icons.close; // X icon
      case Platform.facebook:
        return Icons.facebook;
      case Platform.tiktok:
        return Icons.music_note;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: _backgroundColor,
        shape: BoxShape.circle,
      ),
      child: Icon(
        _icon,
        color: Colors.white,
        size: size * 0.6,
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
