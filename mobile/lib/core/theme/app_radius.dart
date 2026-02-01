import 'package:flutter/material.dart';

/// Border radius system extracted from Figma CSS
class AppRadius {
  AppRadius._();

  // ============================================
  // Base Radius Scale
  // ============================================
  static const double none = 0.0;
  static const double sm = 4.0;
  static const double md = 8.0;
  static const double lg = 12.0;
  static const double xl = 16.0;
  static const double xxl = 24.0;
  static const double xxxl = 32.0;
  static const double full = 9999.0;

  // ============================================
  // BorderRadius Presets
  // ============================================
  static final BorderRadius radiusNone = BorderRadius.circular(none);
  static final BorderRadius radiusSm = BorderRadius.circular(sm);
  static final BorderRadius radiusMd = BorderRadius.circular(md);
  static final BorderRadius radiusLg = BorderRadius.circular(lg);
  static final BorderRadius radiusXl = BorderRadius.circular(xl);
  static final BorderRadius radiusXxl = BorderRadius.circular(xxl);
  static final BorderRadius radiusXxxl = BorderRadius.circular(xxxl);
  static final BorderRadius radiusFull = BorderRadius.circular(full);

  // ============================================
  // Semantic BorderRadius
  // ============================================
  static final BorderRadius card = radiusLg; // 12px - cards, modals
  static final BorderRadius button = radiusMd; // 8px - buttons, inputs
  static final BorderRadius input = radiusMd; // 8px - text fields
  static final BorderRadius chip = radiusFull; // pill shape
  static final BorderRadius avatar = radiusFull; // circular
  static final BorderRadius bottomSheet = BorderRadius.only(
    topLeft: Radius.circular(xxl),
    topRight: Radius.circular(xxl),
  );
  static final BorderRadius logo = radiusXxxl; // 24px - logo container

  // ============================================
  // Top Only Radius (for cards with images)
  // ============================================
  static final BorderRadius topLg = BorderRadius.only(
    topLeft: Radius.circular(lg),
    topRight: Radius.circular(lg),
  );

  static final BorderRadius bottomLg = BorderRadius.only(
    bottomLeft: Radius.circular(lg),
    bottomRight: Radius.circular(lg),
  );
}
