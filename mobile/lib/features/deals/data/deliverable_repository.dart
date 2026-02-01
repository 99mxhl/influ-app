import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/api_response.dart';
import 'models/deliverable.dart';

final deliverableRepositoryProvider = Provider<DeliverableRepository>((ref) {
  return DeliverableRepository(ref.watch(apiClientProvider));
});

class DeliverableRepository {
  final ApiClient _apiClient;

  DeliverableRepository(this._apiClient);

  Future<List<Deliverable>> getDeliverables(String dealId) async {
    try {
      final response = await _apiClient.get('/api/deals/$dealId/deliverables');

      final data = response.data as Map<String, dynamic>;
      if (data['success'] == true) {
        final list = data['data'] as List? ?? [];
        return list
            .map((e) => Deliverable.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      return [];
    } on DioException catch (e) {
      if (e.response?.data != null) {
        throw ApiException.fromResponse(
          e.response!.data as Map<String, dynamic>,
          e.response?.statusCode,
        );
      }
      throw ApiException(message: 'Failed to load deliverables');
    }
  }

  Future<Deliverable> submitDeliverable(
    String dealId,
    String deliverableId,
    SubmitDeliverableRequest request,
  ) async {
    try {
      final response = await _apiClient.post(
        '/api/deals/$dealId/deliverables/$deliverableId/submit',
        data: request.toJson(),
      );

      return parseApiResponse(
        response.data as Map<String, dynamic>,
        (data) => Deliverable.fromJson(data as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      if (e.response?.data != null) {
        throw ApiException.fromResponse(
          e.response!.data as Map<String, dynamic>,
          e.response?.statusCode,
        );
      }
      throw ApiException(message: 'Failed to submit deliverable');
    }
  }

  Future<Deliverable> approveDeliverable(
    String dealId,
    String deliverableId,
  ) async {
    try {
      final response = await _apiClient.post(
        '/api/deals/$dealId/deliverables/$deliverableId/approve',
      );

      return parseApiResponse(
        response.data as Map<String, dynamic>,
        (data) => Deliverable.fromJson(data as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      if (e.response?.data != null) {
        throw ApiException.fromResponse(
          e.response!.data as Map<String, dynamic>,
          e.response?.statusCode,
        );
      }
      throw ApiException(message: 'Failed to approve deliverable');
    }
  }

  Future<Deliverable> rejectDeliverable(
    String dealId,
    String deliverableId,
    RejectDeliverableRequest request,
  ) async {
    try {
      final response = await _apiClient.post(
        '/api/deals/$dealId/deliverables/$deliverableId/reject',
        data: request.toJson(),
      );

      return parseApiResponse(
        response.data as Map<String, dynamic>,
        (data) => Deliverable.fromJson(data as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      if (e.response?.data != null) {
        throw ApiException.fromResponse(
          e.response!.data as Map<String, dynamic>,
          e.response?.statusCode,
        );
      }
      throw ApiException(message: 'Failed to reject deliverable');
    }
  }
}
