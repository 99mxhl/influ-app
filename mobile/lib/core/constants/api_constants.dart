import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class ApiConstants {
  ApiConstants._();

  // Android emulator uses 10.0.2.2 to reach host machine
  // iOS simulator and web can use localhost
  static String get baseUrl {
    if (kIsWeb) return 'http://localhost:8080';
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
