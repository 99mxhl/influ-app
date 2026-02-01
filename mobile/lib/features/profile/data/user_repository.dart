import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_response.dart';
import '../../auth/data/models/user.dart';
import 'models/update_profile_request.dart';

class UserRepository {
  final ApiClient _apiClient;

  UserRepository(this._apiClient);

  Future<User> getUser(String userId) async {
    try {
      final response = await _apiClient.get('${ApiConstants.users}/$userId');

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
      throw ApiException(message: 'Failed to load user.');
    }
  }

  Future<User> updateProfile(UpdateProfileRequest request) async {
    try {
      final response = await _apiClient.put(
        '${ApiConstants.users}/me',
        data: request.toJson(),
      );

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
      throw ApiException(message: 'Failed to update profile.');
    }
  }

  Future<List<User>> getInfluencers({
    int page = 0,
    int size = 20,
    String? category,
    String? platform,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'size': size,
      };
      if (category != null) queryParams['category'] = category;
      if (platform != null) queryParams['platform'] = platform;

      final response = await _apiClient.get(
        ApiConstants.influencers,
        queryParameters: queryParams,
      );

      final data = response.data as Map<String, dynamic>;
      if (data['success'] == true) {
        final content = data['data']['content'] as List? ?? data['data'] as List?;
        if (content != null) {
          return content
              .map((e) => User.fromJson(e as Map<String, dynamic>))
              .toList();
        }
      }
      return [];
    } on DioException catch (e) {
      if (e.response?.data != null) {
        throw ApiException.fromResponse(
          e.response!.data as Map<String, dynamic>,
          e.response?.statusCode,
        );
      }
      throw ApiException(message: 'Failed to load influencers.');
    }
  }
}

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return UserRepository(apiClient);
});
