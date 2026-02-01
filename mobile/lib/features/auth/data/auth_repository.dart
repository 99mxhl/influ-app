import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_response.dart';
import 'models/auth_request.dart';
import 'models/auth_response.dart';
import 'models/user.dart';

class AuthRepository {
  final ApiClient _apiClient;

  AuthRepository(this._apiClient);

  Future<AuthResponse> login(LoginRequest request) async {
    try {
      final response = await _apiClient.post(
        ApiConstants.login,
        data: request.toJson(),
      );

      return parseApiResponse(
        response.data as Map<String, dynamic>,
        (data) => AuthResponse.fromJson(data as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      if (kDebugMode) {
        debugPrint('Login failed: ${e.type} - status ${e.response?.statusCode}');
      }
      if (e.response?.data != null) {
        throw ApiException.fromResponse(
          e.response!.data as Map<String, dynamic>,
          e.response?.statusCode,
        );
      }
      throw ApiException(message: 'Login failed. Please try again.');
    }
  }

  Future<AuthResponse> register(RegisterRequest request) async {
    try {
      final response = await _apiClient.post(
        ApiConstants.register,
        data: request.toJson(),
      );

      return parseApiResponse(
        response.data as Map<String, dynamic>,
        (data) => AuthResponse.fromJson(data as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      if (e.response?.data != null) {
        throw ApiException.fromResponse(
          e.response!.data as Map<String, dynamic>,
          e.response?.statusCode,
        );
      }
      throw ApiException(message: 'Registration failed. Please try again.');
    }
  }

  Future<AuthResponse> refresh(String refreshToken) async {
    try {
      final response = await _apiClient.post(
        ApiConstants.refresh,
        data: RefreshTokenRequest(refreshToken: refreshToken).toJson(),
      );

      return parseApiResponse(
        response.data as Map<String, dynamic>,
        (data) => AuthResponse.fromJson(data as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      if (e.response?.data != null) {
        throw ApiException.fromResponse(
          e.response!.data as Map<String, dynamic>,
          e.response?.statusCode,
        );
      }
      throw ApiException(message: 'Token refresh failed.');
    }
  }

  /// Notifies backend of logout. Returns true if successful, false otherwise.
  /// Caller should clear local tokens regardless of result.
  Future<bool> logout() async {
    try {
      await _apiClient.post(ApiConstants.logout);
      return true;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Logout API call failed: $e');
      }
      // Return false but don't throw - local logout should still proceed
      return false;
    }
  }

  Future<User> getMe() async {
    try {
      final response = await _apiClient.get(ApiConstants.me);

      return parseApiResponse(
        response.data as Map<String, dynamic>,
        (data) => User.fromJson(data as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      if (e.response?.data != null) {
        throw ApiException.fromResponse(
          e.response!.data as Map<String, dynamic>,
          e.response?.statusCode,
        );
      }
      throw ApiException(message: 'Failed to get user info.');
    }
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return AuthRepository(apiClient);
});
