import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_response.dart';
import 'models/deal.dart';

class DealRepository {
  final ApiClient _apiClient;

  DealRepository(this._apiClient);

  Future<List<Deal>> getDeals({
    int page = 0,
    int size = 20,
    String? status,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'size': size,
      };
      if (status != null) queryParams['status'] = status;

      final response = await _apiClient.get(
        ApiConstants.deals,
        queryParameters: queryParams,
      );

      final data = response.data as Map<String, dynamic>;
      if (data['success'] == true) {
        final content = data['data']['content'] as List? ?? data['data'] as List?;
        if (content != null) {
          return content
              .map((e) => Deal.fromJson(e as Map<String, dynamic>))
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
      throw ApiException(message: 'Failed to load deals.');
    }
  }

  Future<Deal> getDealById(String id) async {
    try {
      final response = await _apiClient.get('${ApiConstants.deals}/$id');

      return parseApiResponse(
        response.data as Map<String, dynamic>,
        (data) => Deal.fromJson(data as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      if (e.response?.data != null) {
        throw ApiException.fromResponse(
          e.response!.data as Map<String, dynamic>,
          e.response?.statusCode,
        );
      }
      throw ApiException(message: 'Failed to load deal.');
    }
  }

  Future<Deal> applyToCampaign(String campaignId, {String? message}) async {
    try {
      final response = await _apiClient.post(
        ApiConstants.dealApply,
        data: ApplyToCampaignRequest(
          campaignId: campaignId,
          message: message,
        ).toJson(),
      );

      return parseApiResponse(
        response.data as Map<String, dynamic>,
        (data) => Deal.fromJson(data as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      if (e.response?.data != null) {
        throw ApiException.fromResponse(
          e.response!.data as Map<String, dynamic>,
          e.response?.statusCode,
        );
      }
      throw ApiException(message: 'Failed to apply to campaign.');
    }
  }

  Future<Deal> inviteInfluencer({
    required String campaignId,
    required String influencerId,
    String? message,
  }) async {
    try {
      final response = await _apiClient.post(
        ApiConstants.dealInvite,
        data: InviteInfluencerRequest(
          campaignId: campaignId,
          influencerId: influencerId,
          message: message,
        ).toJson(),
      );

      return parseApiResponse(
        response.data as Map<String, dynamic>,
        (data) => Deal.fromJson(data as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      if (e.response?.data != null) {
        throw ApiException.fromResponse(
          e.response!.data as Map<String, dynamic>,
          e.response?.statusCode,
        );
      }
      throw ApiException(message: 'Failed to invite influencer.');
    }
  }

  Future<Deal> proposeTerms(String dealId, ProposeTermsRequest request) async {
    try {
      // Backend expects deliverables as a JSON string
      final data = {
        'amount': request.amount,
        'deliverables': jsonEncode(request.deliverables.map((d) => d.toJson()).toList()),
        'notes': request.notes,
      };
      final response = await _apiClient.post(
        '${ApiConstants.deals}/$dealId/terms',
        data: data,
      );

      return parseApiResponse(
        response.data as Map<String, dynamic>,
        (data) => Deal.fromJson(data as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      if (e.response?.data != null) {
        throw ApiException.fromResponse(
          e.response!.data as Map<String, dynamic>,
          e.response?.statusCode,
        );
      }
      throw ApiException(message: 'Failed to propose terms.');
    }
  }

  Future<Deal> acceptTerms(String dealId) async {
    try {
      final response = await _apiClient.put(
        '${ApiConstants.deals}/$dealId/terms/accept',
      );

      return parseApiResponse(
        response.data as Map<String, dynamic>,
        (data) => Deal.fromJson(data as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      if (e.response?.data != null) {
        throw ApiException.fromResponse(
          e.response!.data as Map<String, dynamic>,
          e.response?.statusCode,
        );
      }
      throw ApiException(message: 'Failed to accept terms.');
    }
  }

  Future<Deal> rejectTerms(String dealId) async {
    try {
      final response = await _apiClient.put(
        '${ApiConstants.deals}/$dealId/terms/reject',
      );

      return parseApiResponse(
        response.data as Map<String, dynamic>,
        (data) => Deal.fromJson(data as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      if (e.response?.data != null) {
        throw ApiException.fromResponse(
          e.response!.data as Map<String, dynamic>,
          e.response?.statusCode,
        );
      }
      throw ApiException(message: 'Failed to reject terms.');
    }
  }

  Future<Deal> cancelDeal(String dealId) async {
    try {
      final response = await _apiClient.put(
        '${ApiConstants.deals}/$dealId/cancel',
      );

      return parseApiResponse(
        response.data as Map<String, dynamic>,
        (data) => Deal.fromJson(data as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      if (e.response?.data != null) {
        throw ApiException.fromResponse(
          e.response!.data as Map<String, dynamic>,
          e.response?.statusCode,
        );
      }
      throw ApiException(message: 'Failed to cancel deal.');
    }
  }
}

final dealRepositoryProvider = Provider<DealRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return DealRepository(apiClient);
});
