import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';

  final FlutterSecureStorage _storage;

  // In-memory fallback for web when secure storage fails
  final Map<String, String> _memoryStorage = {};

  SecureStorage({FlutterSecureStorage? storage})
      : _storage = storage ??
            const FlutterSecureStorage(
              aOptions: AndroidOptions(encryptedSharedPreferences: true),
              iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
              webOptions: WebOptions(
                dbName: 'influ_app',
                publicKey: 'influ_app_key',
              ),
            );

  Future<String?> getAccessToken() async {
    try {
      final token = await _storage.read(key: _accessTokenKey);
      return token ?? _memoryStorage[_accessTokenKey];
    } catch (e) {
      // Web platform doesn't support secure storage well, fallback silently
      return _memoryStorage[_accessTokenKey];
    }
  }

  Future<void> setAccessToken(String token) async {
    _memoryStorage[_accessTokenKey] = token;
    try {
      await _storage.write(key: _accessTokenKey, value: token);
    } catch (e) {
      // Web platform fallback - token already in memory
    }
  }

  Future<String?> getRefreshToken() async {
    try {
      final token = await _storage.read(key: _refreshTokenKey);
      return token ?? _memoryStorage[_refreshTokenKey];
    } catch (e) {
      // Web platform fallback
      return _memoryStorage[_refreshTokenKey];
    }
  }

  Future<void> setRefreshToken(String token) async {
    _memoryStorage[_refreshTokenKey] = token;
    try {
      await _storage.write(key: _refreshTokenKey, value: token);
    } catch (e) {
      // Web platform fallback - token already in memory
    }
  }

  Future<void> setTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await Future.wait([
      setAccessToken(accessToken),
      setRefreshToken(refreshToken),
    ]);
  }

  Future<void> clearTokens() async {
    _memoryStorage.clear();
    try {
      await Future.wait([
        _storage.delete(key: _accessTokenKey),
        _storage.delete(key: _refreshTokenKey),
      ]);
    } catch (e) {
      // Web platform fallback - memory already cleared
    }
  }

  Future<bool> hasTokens() async {
    final accessToken = await getAccessToken();
    return accessToken != null && accessToken.isNotEmpty;
  }
}

final secureStorageProvider = Provider<SecureStorage>((ref) {
  return SecureStorage();
});
