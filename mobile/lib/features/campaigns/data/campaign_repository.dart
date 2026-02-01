import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_response.dart';
import 'models/campaign.dart';

class CampaignRepository {
  final ApiClient _apiClient;

  CampaignRepository(this._apiClient);

  Future<List<Campaign>> getCampaigns({
    int page = 0,
    int size = 20,
    String? status,
    String? category,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'size': size,
      };
      if (status != null) queryParams['status'] = status;
      if (category != null) queryParams['category'] = category;

      final response = await _apiClient.get(
        ApiConstants.campaigns,
        queryParameters: queryParams,
      );

      final data = response.data as Map<String, dynamic>;
      if (data['success'] == true) {
        final content = data['data']['content'] as List? ?? data['data'] as List?;
        if (content != null) {
          return content
              .map((e) => Campaign.fromJson(e as Map<String, dynamic>))
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
      throw ApiException(message: 'Failed to load campaigns.');
    }
  }

  Future<List<Campaign>> getMyCampaigns({
    int page = 0,
    int size = 20,
  }) async {
    try {
      final response = await _apiClient.get(
        ApiConstants.myCampaigns,
        queryParameters: {'page': page, 'size': size},
      );

      final data = response.data as Map<String, dynamic>;
      if (data['success'] == true) {
        final content = data['data']['content'] as List? ?? data['data'] as List?;
        if (content != null) {
          return content
              .map((e) => Campaign.fromJson(e as Map<String, dynamic>))
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
      throw ApiException(message: 'Failed to load your campaigns.');
    }
  }

  Future<Campaign> getCampaignById(String id) async {
    try {
      final response = await _apiClient.get('${ApiConstants.campaigns}/$id');

      return parseApiResponse(
        response.data as Map<String, dynamic>,
        (data) => Campaign.fromJson(data as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      if (e.response?.data != null) {
        throw ApiException.fromResponse(
          e.response!.data as Map<String, dynamic>,
          e.response?.statusCode,
        );
      }
      throw ApiException(message: 'Failed to load campaign.');
    }
  }

  Future<Campaign> createCampaign(CreateCampaignRequest request) async {
    try {
      final response = await _apiClient.post(
        ApiConstants.campaigns,
        data: request.toJson(),
      );

      return parseApiResponse(
        response.data as Map<String, dynamic>,
        (data) => Campaign.fromJson(data as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      if (e.response?.data != null) {
        throw ApiException.fromResponse(
          e.response!.data as Map<String, dynamic>,
          e.response?.statusCode,
        );
      }
      throw ApiException(message: 'Failed to create campaign.');
    }
  }

  Future<Campaign> updateCampaign(
    String id,
    UpdateCampaignRequest request,
  ) async {
    try {
      final response = await _apiClient.put(
        '${ApiConstants.campaigns}/$id',
        data: request.toJson(),
      );

      return parseApiResponse(
        response.data as Map<String, dynamic>,
        (data) => Campaign.fromJson(data as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      if (e.response?.data != null) {
        throw ApiException.fromResponse(
          e.response!.data as Map<String, dynamic>,
          e.response?.statusCode,
        );
      }
      throw ApiException(message: 'Failed to update campaign.');
    }
  }

  Future<void> deleteCampaign(String id) async {
    try {
      await _apiClient.delete('${ApiConstants.campaigns}/$id');
    } on DioException catch (e) {
      if (e.response?.data != null) {
        throw ApiException.fromResponse(
          e.response!.data as Map<String, dynamic>,
          e.response?.statusCode,
        );
      }
      throw ApiException(message: 'Failed to delete campaign.');
    }
  }
}

final campaignRepositoryProvider = Provider<CampaignRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return CampaignRepository(apiClient);
});
