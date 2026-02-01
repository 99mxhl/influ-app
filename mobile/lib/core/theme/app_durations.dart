/// Animation duration constants extracted from Figma CSS
class AppDurations {
  AppDurations._();

  // ============================================
  // Duration Scale
  // ============================================
  static const Duration instant = Duration(milliseconds: 50);
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 250);
  static const Duration slow = Duration(milliseconds: 350);
  static const Duration slower = Duration(milliseconds: 500);

  // ============================================
  // Semantic Durations
  // ============================================
  static const Duration buttonPress = fast;
  static const Duration modalOpen = normal;
  static const Duration modalClose = Duration(milliseconds: 200);
  static const Duration pageTransition = Duration(milliseconds: 300);
  static const Duration shimmer = Duration(milliseconds: 1500);
  static const Duration pullToRefresh = normal;
}
