import 'package:flutter/material.dart';

import '../../core/theme/theme.dart';

/// Button variants matching Figma design
enum AppButtonVariant {
  primary,
  secondary,
  outline,
  ghost,
  destructive,
  link,
}

/// Button sizes
enum AppButtonSize {
  sm(32, 12, 8, 12),
  md(40, 14, 16, 10),
  lg(48, 16, 24, 12);

  final double height;
  final double fontSize;
  final double horizontalPadding;
  final double verticalPadding;

  const AppButtonSize(
    this.height,
    this.fontSize,
    this.horizontalPadding,
    this.verticalPadding,
  );
}

/// Primary button component with variants
/// Matches the Figma Button component exactly
class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final bool isLoading;
  final bool fullWidth;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.lg,
    this.isLoading = false,
    this.fullWidth = true,
    this.prefixIcon,
    this.suffixIcon,
  });

  (Color, Color, Color?) get _colors {
    switch (variant) {
      case AppButtonVariant.primary:
        return (AppColors.primary, Colors.white, null);
      case AppButtonVariant.secondary:
        return (AppColors.secondary, Colors.white, null);
      case AppButtonVariant.outline:
        return (Colors.transparent, AppColors.primary, AppColors.primary);
      case AppButtonVariant.ghost:
        return (Colors.transparent, AppColors.gray700, null);
      case AppButtonVariant.destructive:
        return (AppColors.error, Colors.white, null);
      case AppButtonVariant.link:
        return (Colors.transparent, AppColors.primary, null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final (bgColor, textColor, borderColor) = _colors;
    final isDisabled = onPressed == null || isLoading;

    Widget child = Row(
      mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (prefixIcon != null && !isLoading) ...[
          IconTheme(
            data: IconThemeData(color: textColor, size: 20),
            child: prefixIcon!,
          ),
          AppSpacing.gapH2,
        ],
        if (isLoading)
          SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation(textColor),
            ),
          )
        else
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: size.fontSize,
              fontWeight: FontWeight.w600,
              height: 1.2,
            ),
          ),
        if (suffixIcon != null && !isLoading) ...[
          AppSpacing.gapH2,
          IconTheme(
            data: IconThemeData(color: textColor, size: 20),
            child: suffixIcon!,
          ),
        ],
      ],
    );

    return SizedBox(
      width: fullWidth ? double.infinity : null,
      height: size.height,
      child: Material(
        color: isDisabled ? AppColors.gray200 : bgColor,
        borderRadius: AppRadius.button,
        child: InkWell(
          onTap: isDisabled ? null : onPressed,
          borderRadius: AppRadius.button,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: size.horizontalPadding,
              vertical: size.verticalPadding,
            ),
            decoration: BoxDecoration(
              borderRadius: AppRadius.button,
              border: borderColor != null
                  ? Border.all(color: isDisabled ? AppColors.gray300 : borderColor)
                  : null,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// Icon-only button
class AppIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final double size;
  final Color? color;
  final Color? backgroundColor;
  final String? tooltip;

  const AppIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.size = 40,
    this.color,
    this.backgroundColor,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    Widget button = Material(
      color: backgroundColor ?? Colors.transparent,
      borderRadius: AppRadius.button,
      child: InkWell(
        onTap: onPressed,
        borderRadius: AppRadius.button,
        child: SizedBox(
          width: size,
          height: size,
          child: Icon(
            icon,
            color: color ?? AppColors.gray700,
            size: size * 0.5,
          ),
        ),
      ),
    );

    if (tooltip != null) {
      return Tooltip(
        message: tooltip!,
        child: button,
      );
    }

    return button;
  }
}
