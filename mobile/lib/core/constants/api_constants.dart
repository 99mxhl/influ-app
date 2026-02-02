import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';

/// API configuration with environment-based URL selection.
///
/// For production builds, set the API URL via --dart-define:
/// ```
/// flutter build apk --dart-define=API_BASE_URL=https://api.example.com
/// flutter build ios --dart-define=API_BASE_URL=https://api.example.com
/// ```
///
/// In debug mode, defaults to localhost (emulator-appropriate).
class ApiConstants {
  ApiConstants._();

  /// Production API URL from environment, or null if not set.
  static const String? _productionUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: '',
  ) == '' ? null : String.fromEnvironment('API_BASE_URL');

  /// Returns the API base URL based on build mode and environment.
  ///
  /// - Release builds: Uses API_BASE_URL from --dart-define (required)
  /// - Debug builds: Uses localhost appropriate for platform
  ///
  /// Throws [StateError] in release mode if API_BASE_URL is not configured.
  static String get baseUrl {
    // In release mode, require production URL
    if (kReleaseMode) {
      final productionUrl = _productionUrl;
      if (productionUrl == null || productionUrl.isEmpty) {
        throw StateError(
          'API_BASE_URL must be set for release builds. '
          'Use: flutter build --dart-define=API_BASE_URL=https://api.example.com',
        );
      }
      // Enforce HTTPS in production
      if (!productionUrl.startsWith('https://')) {
        throw StateError('API_BASE_URL must use HTTPS in production');
      }
      return productionUrl;
    }

    // Debug mode: use localhost
    // Android emulator uses 10.0.2.2 to reach host machine
    // iOS simulator can use localhost
    if (Platform.isAndroid) return 'http://10.0.2.2:8080';
    return 'http://localhost:8080';
  }

  // Auth endpoints
  static const String login = '/api/auth/login';
  static const String register = '/api/auth/register';
  static const String refresh = '/api/auth/refresh';
  static const String logout = '/api/auth/logout';
  static const String me = '/api/auth/me';

  // User endpoints
  static const String users = '/api/users';
  static const String influencers = '/api/influencers';

  // Campaign endpoints
  static const String campaigns = '/api/campaigns';
  static const String myCampaigns = '/api/campaigns/mine';

  // Deal endpoints
  static const String deals = '/api/deals';
  static const String dealApply = '/api/deals/apply';
  static const String dealInvite = '/api/deals/invite';

  // File endpoints
  static const String presignUpload = '/api/files/presign';
  static const String confirmUpload = '/api/files/confirm';

  // Payment endpoints
  static const String connectAccount = '/api/payments/connect-account';
}
