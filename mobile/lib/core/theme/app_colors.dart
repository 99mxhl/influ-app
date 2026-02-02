import 'package:flutter/material.dart';

/// Design tokens extracted from Figma CSS variables
/// These values match the Figma design 1:1
class AppColors {
  AppColors._();

  // ============================================
  // Primary Colors
  // ============================================
  static const Color primary = Color(0xFF6366F1);
  static const Color primaryLight = Color(0xFFA5B4FC);
  static const Color primaryDark = Color(0xFF4338CA);

  // ============================================
  // Secondary Colors
  // ============================================
  static const Color secondary = Color(0xFF0EA5E9);
  static const Color secondaryLight = Color(0xFF7DD3FC);
  static const Color secondaryDark = Color(0xFF0369A1);

  // ============================================
  // Accent Colors
  // ============================================
  static const Color accent = Color(0xFFF59E0B);
  static const Color accentLight = Color(0xFFFCD34D);
  static const Color accentDark = Color(0xFFD97706);

  // ============================================
  // Neutral Colors (Gray Scale)
  // ============================================
  static const Color gray50 = Color(0xFFF9FAFB);
  static const Color gray100 = Color(0xFFF3F4F6);
  static const Color gray200 = Color(0xFFE5E7EB);
  static const Color gray300 = Color(0xFFD1D5DB);
  static const Color gray400 = Color(0xFF9CA3AF);
  static const Color gray500 = Color(0xFF6B7280);
  static const Color gray600 = Color(0xFF4B5563);
  static const Color gray700 = Color(0xFF374151);
  static const Color gray800 = Color(0xFF1F2937);
  static const Color gray900 = Color(0xFF111827);

  // ============================================
  // Background Colors - Light Mode
  // ============================================
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color elevated = Color(0xFFF9FAFB);
  static const Color card = Color(0xFFFFFFFF);

  // ============================================
  // Background Colors - Dark Mode
  // ============================================
  static const Color backgroundDark = Color(0xFF111827);
  static const Color surfaceDark = Color(0xFF111827);
  static const Color elevatedDark = Color(0xFF1F2937);
  static const Color cardDark = Color(0xFF374151);

  // ============================================
  // Status Colors
  // ============================================
  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFFD1FAE5);
  static const Color successDark = Color(0xFF065F46);

  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFFEE2E2);
  static const Color errorDark = Color(0xFF991B1B);

  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFEF3C7);
  static const Color warningDark = Color(0xFF92400E);

  static const Color info = Color(0xFF3B82F6);
  static const Color infoLight = Color(0xFFDBEAFE);
  static const Color infoDark = Color(0xFF1E40AF);

  // ============================================
  // Special Purpose Colors
  // ============================================
  static const Color escrow = Color(0xFF8B5CF6);
  static const Color online = Color(0xFF10B981);
  static const Color offline = Color(0xFF9CA3AF);
  static const Color unread = Color(0xFFEF4444);
  static const Color verified = Color(0xFF3B82F6);

  // ============================================
  // Platform Brand Colors
  // ============================================
  static const Color instagram = Color(0xFFE1306C);
  static const Color youtube = Color(0xFFFF0000);
  static const Color xTwitter = Color(0xFF000000);
  static const Color facebook = Color(0xFF1877F2);
  static const Color tiktok = Color(0xFF000000);

  // ============================================
  // Text Colors - Light Mode
  // ============================================
  static const Color textPrimary = gray800;
  static const Color textSecondary = gray600;
  static const Color textMuted = gray500;
  static const Color textDisabled = gray300;
  static const Color textInverse = Color(0xFFFFFFFF);

  // ============================================
  // Text Colors - Dark Mode
  // ============================================
  static const Color textPrimaryDark = gray100;
  static const Color textSecondaryDark = gray300;
  static const Color textMutedDark = gray400;
  static const Color textDisabledDark = gray600;

  // ============================================
  // Border Colors
  // ============================================
  static const Color border = gray200;
  static const Color borderDark = gray700;
  static const Color inputBorder = gray300;
  static const Color inputBorderDark = gray600;

  // ============================================
  // Gradients
  // ============================================
  static const LinearGradient gradientPrimary = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
  );

  static const LinearGradient gradientAccent = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFF59E0B), Color(0xFFF97316)],
  );

  static const LinearGradient gradientDark = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF1F2937), Color(0xFF111827)],
  );

  // ============================================
  // Semantic Color Getters (for theming)
  // ============================================
  static Color foreground(Brightness brightness) =>
      brightness == Brightness.light ? textPrimary : textPrimaryDark;

  static Color cardBackground(Brightness brightness) =>
      brightness == Brightness.light ? card : cardDark;

  static Color elevatedBackground(Brightness brightness) =>
      brightness == Brightness.light ? elevated : elevatedDark;

  static Color borderColor(Brightness brightness) =>
      brightness == Brightness.light ? border : borderDark;
}
