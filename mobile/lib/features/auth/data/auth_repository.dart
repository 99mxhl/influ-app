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

      debugPrint('Login response status: ${response.statusCode}');
      debugPrint('Login response data: ${response.data}');

      return parseApiResponse(
        response.data as Map<String, dynamic>,
        (data) => AuthResponse.fromJson(data as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      debugPrint('Login DioException: ${e.type} - ${e.message}');
      debugPrint('Login error response: ${e.response?.data}');
      if (e.response?.data != null) {
        throw ApiException.fromResponse(
          e.response!.data as Map<String, dynamic>,
          e.response?.statusCode,
        );
      }
      throw ApiException(message: 'Login failed. Please try again.');
    } catch (e) {
      debugPrint('Login other error: $e');
      rethrow;
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

  void logout() {
    // Fire and forget - don't wait for backend response
    _apiClient.post(ApiConstants.logout).ignore();
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
