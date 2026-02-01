import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Secure token storage using platform-specific secure storage.
/// - iOS: Keychain
/// - Android: EncryptedSharedPreferences
class SecureStorage {
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';

  final FlutterSecureStorage _storage;

  SecureStorage({FlutterSecureStorage? storage})
      : _storage = storage ??
            const FlutterSecureStorage(
              aOptions: AndroidOptions(encryptedSharedPreferences: true),
              iOptions: IOSOptions(
                accessibility: KeychainAccessibility.first_unlock_this_device,
              ),
            );

  Future<String?> getAccessToken() async {
    try {
      return await _storage.read(key: _accessTokenKey);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('SecureStorage: Failed to read access token: $e');
      }
      return null;
    }
  }

  Future<void> setAccessToken(String token) async {
    try {
      await _storage.write(key: _accessTokenKey, value: token);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('SecureStorage: Failed to write access token: $e');
      }
      rethrow;
    }
  }

  Future<String?> getRefreshToken() async {
    try {
      return await _storage.read(key: _refreshTokenKey);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('SecureStorage: Failed to read refresh token: $e');
      }
      return null;
    }
  }

  Future<void> setRefreshToken(String token) async {
    try {
      await _storage.write(key: _refreshTokenKey, value: token);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('SecureStorage: Failed to write refresh token: $e');
      }
      rethrow;
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
    try {
      await Future.wait([
        _storage.delete(key: _accessTokenKey),
        _storage.delete(key: _refreshTokenKey),
      ]);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('SecureStorage: Failed to clear tokens: $e');
      }
      // Don't rethrow on clear - best effort cleanup
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
