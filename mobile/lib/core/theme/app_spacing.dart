import 'package:flutter/material.dart';

/// Spacing system based on 4px base unit
/// Extracted from Figma CSS variables
class AppSpacing {
  AppSpacing._();

  // ============================================
  // Base Spacing Scale
  // ============================================
  static const double space1 = 4.0;
  static const double space2 = 8.0;
  static const double space3 = 12.0;
  static const double space4 = 16.0;
  static const double space5 = 20.0;
  static const double space6 = 24.0;
  static const double space8 = 32.0;
  static const double space10 = 40.0;
  static const double space12 = 48.0;
  static const double space16 = 64.0;
  static const double space20 = 80.0;

  // ============================================
  // Semantic Spacing
  // ============================================
  static const double xs = space1; // 4px
  static const double sm = space2; // 8px
  static const double md = space3; // 12px
  static const double base = space4; // 16px
  static const double lg = space5; // 20px
  static const double xl = space6; // 24px
  static const double xxl = space8; // 32px
  static const double xxxl = space10; // 40px

  // ============================================
  // Page & Container Padding
  // ============================================
  static const double pagePadding = space4; // 16px
  static const double cardPadding = space4; // 16px
  static const double sectionGap = space6; // 24px
  static const double listItemGap = space3; // 12px

  // ============================================
  // Component Specific
  // ============================================
  static const double inputPaddingH = space4; // 16px
  static const double inputPaddingV = space3; // 12px
  static const double buttonPaddingH = space6; // 24px
  static const double buttonPaddingV = space3; // 12px

  // ============================================
  // EdgeInsets Helpers
  // ============================================
  static const EdgeInsets page = EdgeInsets.all(pagePadding);

  static const EdgeInsets pageHorizontal = EdgeInsets.symmetric(
    horizontal: pagePadding,
  );

  static const EdgeInsets card = EdgeInsets.all(cardPadding);

  static const EdgeInsets inputPadding = EdgeInsets.symmetric(
    horizontal: inputPaddingH,
    vertical: inputPaddingV,
  );

  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(
    horizontal: buttonPaddingH,
    vertical: buttonPaddingV,
  );

  // ============================================
  // Common Padding Presets
  // ============================================
  static const EdgeInsets p1 = EdgeInsets.all(space1);
  static const EdgeInsets p2 = EdgeInsets.all(space2);
  static const EdgeInsets p3 = EdgeInsets.all(space3);
  static const EdgeInsets p4 = EdgeInsets.all(space4);
  static const EdgeInsets p6 = EdgeInsets.all(space6);

  static const EdgeInsets px2 = EdgeInsets.symmetric(horizontal: space2);
  static const EdgeInsets px3 = EdgeInsets.symmetric(horizontal: space3);
  static const EdgeInsets px4 = EdgeInsets.symmetric(horizontal: space4);
  static const EdgeInsets px6 = EdgeInsets.symmetric(horizontal: space6);

  static const EdgeInsets py2 = EdgeInsets.symmetric(vertical: space2);
  static const EdgeInsets py3 = EdgeInsets.symmetric(vertical: space3);
  static const EdgeInsets py4 = EdgeInsets.symmetric(vertical: space4);
  static const EdgeInsets py6 = EdgeInsets.symmetric(vertical: space6);

  // ============================================
  // Gap Helpers (for use with SizedBox)
  // ============================================
  static const SizedBox gapH1 = SizedBox(width: space1);
  static const SizedBox gapH2 = SizedBox(width: space2);
  static const SizedBox gapH3 = SizedBox(width: space3);
  static const SizedBox gapH4 = SizedBox(width: space4);
  static const SizedBox gapH6 = SizedBox(width: space6);

  static const SizedBox gapV1 = SizedBox(height: space1);
  static const SizedBox gapV2 = SizedBox(height: space2);
  static const SizedBox gapV3 = SizedBox(height: space3);
  static const SizedBox gapV4 = SizedBox(height: space4);
  static const SizedBox gapV6 = SizedBox(height: space6);
  static const SizedBox gapV8 = SizedBox(height: space8);
}
