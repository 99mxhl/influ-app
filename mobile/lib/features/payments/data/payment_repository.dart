import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/api_response.dart';
import 'models/payment.dart';

final paymentRepositoryProvider = Provider<PaymentRepository>((ref) {
  return PaymentRepository(ref.watch(apiClientProvider));
});

class PaymentRepository {
  final ApiClient _apiClient;

  PaymentRepository(this._apiClient);

  Future<Payment?> getPaymentForDeal(String dealId) async {
    try {
      final response = await _apiClient.get('/api/payments/$dealId');

      return parseApiResponse(
        response.data as Map<String, dynamic>,
        (data) => Payment.fromJson(data as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return null;
      }
      if (e.response?.data != null) {
        throw ApiException.fromResponse(
          e.response!.data as Map<String, dynamic>,
          e.response?.statusCode,
        );
      }
      throw ApiException(message: 'Failed to load payment');
    }
  }

  Future<Payment> capturePayment(String dealId) async {
    try {
      final response = await _apiClient.post('/api/payments/$dealId/capture');

      return parseApiResponse(
        response.data as Map<String, dynamic>,
        (data) => Payment.fromJson(data as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      if (e.response?.data != null) {
        throw ApiException.fromResponse(
          e.response!.data as Map<String, dynamic>,
          e.response?.statusCode,
        );
      }
      throw ApiException(message: 'Failed to capture payment');
    }
  }

  Future<Payment> releasePayment(String dealId) async {
    try {
      final response = await _apiClient.post('/api/payments/$dealId/release');

      return parseApiResponse(
        response.data as Map<String, dynamic>,
        (data) => Payment.fromJson(data as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      if (e.response?.data != null) {
        throw ApiException.fromResponse(
          e.response!.data as Map<String, dynamic>,
          e.response?.statusCode,
        );
      }
      throw ApiException(message: 'Failed to release payment');
    }
  }

  Future<List<Payment>> getMyPayments() async {
    try {
      final response = await _apiClient.get('/api/payments/me');

      final data = response.data as Map<String, dynamic>;
      if (data['success'] == true) {
        final list = data['data'] as List? ?? [];
        return list
            .map((e) => Payment.fromJson(e as Map<String, dynamic>))
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
      throw ApiException(message: 'Failed to load payments');
    }
  }
}
