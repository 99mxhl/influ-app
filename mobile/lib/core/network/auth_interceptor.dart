import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../constants/api_constants.dart';
import '../storage/secure_storage.dart';

/// Interceptor that handles authentication token injection and refresh.
/// Uses a Completer-based lock to prevent race conditions during token refresh.
class AuthInterceptor extends QueuedInterceptor {
  final Dio _dio;
  final SecureStorage _secureStorage;

  /// Completer used to queue requests while token refresh is in progress.
  /// All 401 requests wait on this completer instead of triggering multiple refreshes.
  Completer<String?>? _refreshCompleter;

  AuthInterceptor(this._dio, this._secureStorage);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Skip auth for public endpoints
    const publicEndpoints = [
      ApiConstants.login,
      ApiConstants.register,
      ApiConstants.refresh,
    ];

    if (publicEndpoints.contains(options.path)) {
      return handler.next(options);
    }

    final accessToken = await _secureStorage.getAccessToken();
    if (accessToken != null && accessToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    return handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode != 401) {
      return handler.next(err);
    }

    // Skip refresh for auth endpoints themselves
    final path = err.requestOptions.path;
    if (path == ApiConstants.login ||
        path == ApiConstants.register ||
        path == ApiConstants.refresh) {
      return handler.next(err);
    }

    try {
      final newToken = await _refreshTokenWithLock();

      if (newToken != null) {
        // Retry the original request with new token
        final opts = err.requestOptions;
        opts.headers['Authorization'] = 'Bearer $newToken';
        final retryResponse = await _dio.fetch(opts);
        return handler.resolve(retryResponse);
      } else {
        // Refresh failed, propagate original error
        return handler.reject(err);
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Auth interceptor error during refresh: $e');
      }
      return handler.reject(err);
    }
  }

  /// Refreshes the token with a lock mechanism.
  /// If a refresh is already in progress, waits for it to complete.
  /// Returns the new access token or null if refresh failed.
  Future<String?> _refreshTokenWithLock() async {
    // If refresh is already in progress, wait for it
    if (_refreshCompleter != null) {
      return _refreshCompleter!.future;
    }

    // Start a new refresh
    _refreshCompleter = Completer<String?>();

    try {
      final refreshToken = await _secureStorage.getRefreshToken();
      if (refreshToken == null || refreshToken.isEmpty) {
        await _handleAuthFailure();
        _refreshCompleter!.complete(null);
        return null;
      }

      final response = await _dio.post(
        ApiConstants.refresh,
        data: {'refreshToken': refreshToken},
        options: Options(
          headers: {'Authorization': ''},
        ),
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        final newAccessToken = response.data['data']['accessToken'] as String;
        final newRefreshToken = response.data['data']['refreshToken'] as String;

        await _secureStorage.setTokens(
          accessToken: newAccessToken,
          refreshToken: newRefreshToken,
        );

        _refreshCompleter!.complete(newAccessToken);
        return newAccessToken;
      } else {
        await _handleAuthFailure();
        _refreshCompleter!.complete(null);
        return null;
      }
    } catch (e) {
      await _handleAuthFailure();
      _refreshCompleter!.complete(null);
      return null;
    } finally {
      _refreshCompleter = null;
    }
  }

  Future<void> _handleAuthFailure() async {
    await _secureStorage.clearTokens();
    // The router will handle navigation to login based on auth state
  }
}
