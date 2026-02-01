import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Typography system extracted from Figma CSS
/// Uses Inter font family matching the Figma design
class AppTypography {
  AppTypography._();

  static const String _fontFamily = 'Inter';

  // ============================================
  // Font Weights
  // ============================================
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;

  // ============================================
  // Display Styles
  // ============================================
  static TextStyle displayLarge = GoogleFonts.inter(
    fontSize: 32,
    height: 40 / 32,
    fontWeight: bold,
    color: AppColors.textPrimary,
  );

  static TextStyle displayMedium = GoogleFonts.inter(
    fontSize: 28,
    height: 36 / 28,
    fontWeight: bold,
    color: AppColors.textPrimary,
  );

  // ============================================
  // Heading Styles
  // ============================================
  static TextStyle h1 = GoogleFonts.inter(
    fontSize: 24,
    height: 32 / 24,
    fontWeight: semiBold,
    color: AppColors.textPrimary,
  );

  static TextStyle h2 = GoogleFonts.inter(
    fontSize: 20,
    height: 28 / 20,
    fontWeight: semiBold,
    color: AppColors.textPrimary,
  );

  static TextStyle h3 = GoogleFonts.inter(
    fontSize: 18,
    height: 26 / 18,
    fontWeight: medium,
    color: AppColors.textPrimary,
  );

  static TextStyle h4 = GoogleFonts.inter(
    fontSize: 16,
    height: 24 / 16,
    fontWeight: medium,
    color: AppColors.textPrimary,
  );

  // ============================================
  // Body Styles
  // ============================================
  static TextStyle bodyLarge = GoogleFonts.inter(
    fontSize: 16,
    height: 24 / 16,
    fontWeight: regular,
    color: AppColors.textPrimary,
  );

  static TextStyle body = GoogleFonts.inter(
    fontSize: 14,
    height: 20 / 14,
    fontWeight: regular,
    color: AppColors.textPrimary,
  );

  static TextStyle bodySmall = GoogleFonts.inter(
    fontSize: 12,
    height: 16 / 12,
    fontWeight: regular,
    color: AppColors.textPrimary,
  );

  // ============================================
  // Caption & Overline
  // ============================================
  static TextStyle caption = GoogleFonts.inter(
    fontSize: 11,
    height: 14 / 11,
    fontWeight: medium,
    color: AppColors.textMuted,
  );

  static TextStyle overline = GoogleFonts.inter(
    fontSize: 10,
    height: 14 / 10,
    fontWeight: semiBold,
    letterSpacing: 0.5,
    color: AppColors.textMuted,
  );

  // ============================================
  // Button Text
  // ============================================
  static TextStyle buttonLarge = GoogleFonts.inter(
    fontSize: 16,
    height: 24 / 16,
    fontWeight: semiBold,
    color: AppColors.textInverse,
  );

  static TextStyle button = GoogleFonts.inter(
    fontSize: 14,
    height: 20 / 14,
    fontWeight: semiBold,
    color: AppColors.textInverse,
  );

  static TextStyle buttonSmall = GoogleFonts.inter(
    fontSize: 12,
    height: 16 / 12,
    fontWeight: semiBold,
    color: AppColors.textInverse,
  );

  // ============================================
  // Input Text
  // ============================================
  static TextStyle input = GoogleFonts.inter(
    fontSize: 14,
    height: 20 / 14,
    fontWeight: regular,
    color: AppColors.textPrimary,
  );

  static TextStyle inputLabel = GoogleFonts.inter(
    fontSize: 14,
    height: 20 / 14,
    fontWeight: medium,
    color: AppColors.gray700,
  );

  static TextStyle inputHint = GoogleFonts.inter(
    fontSize: 14,
    height: 20 / 14,
    fontWeight: regular,
    color: AppColors.gray400,
  );

  static TextStyle inputError = GoogleFonts.inter(
    fontSize: 12,
    height: 16 / 12,
    fontWeight: regular,
    color: AppColors.errorDark,
  );

  // ============================================
  // Link Style
  // ============================================
  static TextStyle link = GoogleFonts.inter(
    fontSize: 14,
    height: 20 / 14,
    fontWeight: semiBold,
    color: AppColors.primary,
  );

  static TextStyle linkSmall = GoogleFonts.inter(
    fontSize: 12,
    height: 16 / 12,
    fontWeight: medium,
    color: AppColors.primary,
  );

  // ============================================
  // Helper to get style with custom color
  // ============================================
  static TextStyle withColor(TextStyle style, Color color) {
    return style.copyWith(color: color);
  }

  // ============================================
  // Text Theme for Material
  // ============================================
  static TextTheme get textTheme => TextTheme(
        displayLarge: displayLarge,
        displayMedium: displayMedium,
        displaySmall: h1,
        headlineLarge: h1,
        headlineMedium: h2,
        headlineSmall: h3,
        titleLarge: h3,
        titleMedium: h4,
        titleSmall: bodyLarge.copyWith(fontWeight: medium),
        bodyLarge: bodyLarge,
        bodyMedium: body,
        bodySmall: bodySmall,
        labelLarge: button,
        labelMedium: buttonSmall,
        labelSmall: caption,
      );
}
