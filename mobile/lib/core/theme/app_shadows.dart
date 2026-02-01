import 'package:flutter/material.dart';

/// Shadow/elevation system extracted from Figma CSS
class AppShadows {
  AppShadows._();

  // ============================================
  // Elevation Levels
  // ============================================

  /// Elevation 1: Subtle lift for cards
  /// CSS: 0 1px 2px rgba(0,0,0,0.05)
  static const List<BoxShadow> elevation1 = [
    BoxShadow(
      color: Color(0x0D000000), // 5% opacity
      blurRadius: 2,
      offset: Offset(0, 1),
    ),
  ];

  /// Elevation 2: Dropdown, hover cards
  /// CSS: 0 4px 6px rgba(0,0,0,0.07)
  static const List<BoxShadow> elevation2 = [
    BoxShadow(
      color: Color(0x12000000), // 7% opacity
      blurRadius: 6,
      offset: Offset(0, 4),
    ),
  ];

  /// Elevation 3: Modals, popovers
  /// CSS: 0 10px 15px rgba(0,0,0,0.1)
  static const List<BoxShadow> elevation3 = [
    BoxShadow(
      color: Color(0x1A000000), // 10% opacity
      blurRadius: 15,
      offset: Offset(0, 10),
    ),
  ];

  /// Elevation 4: Dialogs
  /// CSS: 0 20px 25px rgba(0,0,0,0.15)
  static const List<BoxShadow> elevation4 = [
    BoxShadow(
      color: Color(0x26000000), // 15% opacity
      blurRadius: 25,
      offset: Offset(0, 20),
    ),
  ];

  // ============================================
  // Semantic Shadows
  // ============================================
  static const List<BoxShadow> card = elevation1;
  static const List<BoxShadow> cardHover = elevation2;
  static const List<BoxShadow> dropdown = elevation2;
  static const List<BoxShadow> modal = elevation3;
  static const List<BoxShadow> dialog = elevation4;

  // ============================================
  // No Shadow
  // ============================================
  static const List<BoxShadow> none = [];
}
