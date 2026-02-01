import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/api_response.dart';
import '../../../shared/models/api_response.dart';
import 'models/conversation.dart';
import 'models/message.dart';

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  return ChatRepository(ref.watch(apiClientProvider));
});

class ChatRepository {
  final ApiClient _apiClient;

  ChatRepository(this._apiClient);

  /// Get all conversations for current user
  Future<PageResponse<Conversation>> getConversations({
    int page = 0,
    int size = 20,
  }) async {
    try {
      final response = await _apiClient.get(
        '/api/conversations',
        queryParameters: {'page': page, 'size': size},
      );

      final data = response.data as Map<String, dynamic>;
      if (data['success'] == true) {
        return PageResponse.fromJson(
          data['data'],
          (json) => Conversation.fromJson(json as Map<String, dynamic>),
        );
      }
      throw ApiException(message: 'Failed to load conversations');
    } on DioException catch (e) {
      if (e.response?.data != null) {
        throw ApiException.fromResponse(
          e.response!.data as Map<String, dynamic>,
          e.response?.statusCode,
        );
      }
      throw ApiException(message: 'Failed to load conversations');
    }
  }

  /// Get conversation for a specific deal
  Future<Conversation> getConversation(String dealId) async {
    try {
      final response = await _apiClient.get('/api/deals/$dealId/conversation');

      return parseApiResponse(
        response.data as Map<String, dynamic>,
        (data) => Conversation.fromJson(data as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      if (e.response?.data != null) {
        throw ApiException.fromResponse(
          e.response!.data as Map<String, dynamic>,
          e.response?.statusCode,
        );
      }
      throw ApiException(message: 'Failed to load conversation');
    }
  }

  /// Get messages for a deal
  Future<PageResponse<Message>> getMessages(
    String dealId, {
    int page = 0,
    int size = 50,
  }) async {
    try {
      final response = await _apiClient.get(
        '/api/deals/$dealId/messages',
        queryParameters: {'page': page, 'size': size},
      );

      final data = response.data as Map<String, dynamic>;
      if (data['success'] == true) {
        return PageResponse.fromJson(
          data['data'],
          (json) => Message.fromJson(json as Map<String, dynamic>),
        );
      }
      throw ApiException(message: 'Failed to load messages');
    } on DioException catch (e) {
      if (e.response?.data != null) {
        throw ApiException.fromResponse(
          e.response!.data as Map<String, dynamic>,
          e.response?.statusCode,
        );
      }
      throw ApiException(message: 'Failed to load messages');
    }
  }

  /// Send a message
  Future<Message> sendMessage(String dealId, SendMessageRequest request) async {
    try {
      final response = await _apiClient.post(
        '/api/deals/$dealId/messages',
        data: request.toJson(),
      );

      return parseApiResponse(
        response.data as Map<String, dynamic>,
        (data) => Message.fromJson(data as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      if (e.response?.data != null) {
        throw ApiException.fromResponse(
          e.response!.data as Map<String, dynamic>,
          e.response?.statusCode,
        );
      }
      throw ApiException(message: 'Failed to send message');
    }
  }

  /// Mark messages as read
  Future<void> markAsRead(String dealId) async {
    try {
      await _apiClient.post('/api/deals/$dealId/messages/read');
    } on DioException {
      // Silently fail for mark as read
    }
  }
}
