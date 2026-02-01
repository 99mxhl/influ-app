import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/api_response.dart';
import '../../../shared/models/api_response.dart';
import 'models/notification.dart';

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  return NotificationRepository(ref.watch(apiClientProvider));
});

class NotificationRepository {
  final ApiClient _apiClient;

  NotificationRepository(this._apiClient);

  Future<PageResponse<AppNotification>> getNotifications({
    int page = 0,
    int size = 20,
  }) async {
    try {
      final response = await _apiClient.get(
        '/api/notifications',
        queryParameters: {'page': page, 'size': size},
      );

      final data = response.data as Map<String, dynamic>;
      if (data['success'] == true) {
        return PageResponse.fromJson(
          data['data'],
          (json) => AppNotification.fromJson(json as Map<String, dynamic>),
        );
      }
      throw ApiException(message: 'Failed to load notifications');
    } on DioException catch (e) {
      if (e.response?.data != null) {
        throw ApiException.fromResponse(
          e.response!.data as Map<String, dynamic>,
          e.response?.statusCode,
        );
      }
      throw ApiException(message: 'Failed to load notifications');
    }
  }

  Future<int> getUnreadCount() async {
    try {
      final response = await _apiClient.get('/api/notifications/unread-count');

      final data = response.data as Map<String, dynamic>;
      if (data['success'] == true) {
        return (data['data']['count'] as num).toInt();
      }
      return 0;
    } on DioException {
      return 0;
    }
  }

  Future<void> markAsRead(String notificationId) async {
    try {
      await _apiClient.post('/api/notifications/$notificationId/read');
    } on DioException {
      // Silently fail for mark as read
    }
  }

  Future<void> markAllAsRead() async {
    try {
      await _apiClient.post('/api/notifications/read-all');
    } on DioException {
      // Silently fail for mark all as read
    }
  }
}
