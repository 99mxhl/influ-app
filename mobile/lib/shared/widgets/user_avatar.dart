import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../core/theme/theme.dart';

/// Avatar sizes matching Figma design
enum AvatarSize {
  xs(24, 10, 8, 10),
  sm(32, 12, 10, 12),
  md(40, 14, 12, 14),
  lg(56, 18, 16, 18),
  xl(80, 24, 20, 24),
  xxl(120, 32, 24, 32);

  final double diameter;
  final double fontSize;
  final double iconSize;
  final double indicatorSize;

  const AvatarSize(this.diameter, this.fontSize, this.iconSize, this.indicatorSize);
}

/// User avatar component with online status and verified badge
/// Matches the Figma UserAvatar component exactly
class UserAvatar extends StatelessWidget {
  final String? imageUrl;
  final String name;
  final AvatarSize size;
  final bool? isOnline;
  final bool verified;
  final VoidCallback? onTap;

  const UserAvatar({
    super.key,
    this.imageUrl,
    required this.name,
    this.size = AvatarSize.md,
    this.isOnline,
    this.verified = false,
    this.onTap,
  });

  String get _initials {
    final parts = name.trim().split(' ');
    if (parts.isEmpty) return '';
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Avatar circle
          Container(
            width: size.diameter,
            height: size.diameter,
            decoration: BoxDecoration(
              color: AppColors.gray200,
              shape: BoxShape.circle,
            ),
            clipBehavior: Clip.antiAlias,
            child: imageUrl != null && imageUrl!.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: imageUrl!,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => _buildPlaceholder(),
                    errorWidget: (context, url, error) => _buildPlaceholder(),
                  )
                : _buildPlaceholder(),
          ),

          // Online indicator
          if (isOnline != null)
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: size.indicatorSize * 0.5,
                height: size.indicatorSize * 0.5,
                decoration: BoxDecoration(
                  color: isOnline! ? AppColors.online : AppColors.offline,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
              ),
            ),

          // Verified badge
          if (verified)
            Positioned(
              right: -2,
              top: -2,
              child: Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: AppColors.verified,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  LucideIcons.check,
                  color: Colors.white,
                  size: 10,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder() {
    if (name.isNotEmpty) {
      return Center(
        child: Text(
          _initials,
          style: TextStyle(
            color: AppColors.gray500,
            fontSize: size.fontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }
    return Icon(
      LucideIcons.user,
      color: AppColors.gray400,
      size: size.iconSize,
    );
  }
}
