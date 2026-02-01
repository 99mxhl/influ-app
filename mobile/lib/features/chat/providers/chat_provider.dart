import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/chat_repository.dart';
import '../data/models/conversation.dart';
import '../data/models/message.dart';

/// Provider for conversations list
final conversationsProvider =
    StateNotifierProvider<ConversationsNotifier, AsyncValue<List<Conversation>>>(
        (ref) {
  return ConversationsNotifier(ref.watch(chatRepositoryProvider));
});

class ConversationsNotifier extends StateNotifier<AsyncValue<List<Conversation>>> {
  final ChatRepository _repository;
  int _currentPage = 0;
  bool _hasMore = true;
  bool _isLoadingMore = false;

  ConversationsNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadConversations();
  }

  Future<void> loadConversations() async {
    state = const AsyncValue.loading();
    _currentPage = 0;
    _hasMore = true;

    try {
      final response = await _repository.getConversations(page: 0);
      _hasMore = !response.last;
      state = AsyncValue.data(response.content);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> loadMore() async {
    if (_isLoadingMore || !_hasMore) return;

    _isLoadingMore = true;
    try {
      final response = await _repository.getConversations(page: _currentPage + 1);
      _currentPage++;
      _hasMore = !response.last;

      final currentData = state.valueOrNull ?? [];
      state = AsyncValue.data([...currentData, ...response.content]);
    } catch (e) {
      // Don't update state on load more error, just log
    } finally {
      _isLoadingMore = false;
    }
  }

  Future<void> refresh() async {
    await loadConversations();
  }

  bool get hasMore => _hasMore;
}

/// Provider for messages in a conversation (by deal ID)
final messagesProvider = StateNotifierProvider.family<MessagesNotifier,
    AsyncValue<List<Message>>, String>((ref, dealId) {
  return MessagesNotifier(ref.watch(chatRepositoryProvider), dealId);
});

class MessagesNotifier extends StateNotifier<AsyncValue<List<Message>>> {
  final ChatRepository _repository;
  final String dealId;
  int _currentPage = 0;
  bool _hasMore = true;
  bool _isLoadingMore = false;

  MessagesNotifier(this._repository, this.dealId)
      : super(const AsyncValue.loading()) {
    loadMessages();
  }

  Future<void> loadMessages() async {
    state = const AsyncValue.loading();
    _currentPage = 0;
    _hasMore = true;

    try {
      final response = await _repository.getMessages(dealId, page: 0);
      _hasMore = !response.last;
      // Reverse to show oldest first (typical chat order)
      state = AsyncValue.data(response.content.reversed.toList());
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> loadMore() async {
    if (_isLoadingMore || !_hasMore) return;

    _isLoadingMore = true;
    try {
      final response = await _repository.getMessages(dealId, page: _currentPage + 1);
      _currentPage++;
      _hasMore = !response.last;

      final currentData = state.valueOrNull ?? [];
      // Prepend older messages at the beginning
      state = AsyncValue.data([...response.content.reversed, ...currentData]);
    } catch (e) {
      // Don't update state on load more error
    } finally {
      _isLoadingMore = false;
    }
  }

  Future<Message?> sendMessage(String content, {MessageType type = MessageType.text}) async {
    try {
      final message = await _repository.sendMessage(
        dealId,
        SendMessageRequest(content: content, type: type),
      );

      // Add to local state immediately
      final currentData = state.valueOrNull ?? [];
      state = AsyncValue.data([...currentData, message]);

      return message;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> markAsRead() async {
    try {
      await _repository.markAsRead(dealId);
    } catch (e) {
      // Silently fail for mark as read
    }
  }

  void addMessage(Message message) {
    final currentData = state.valueOrNull ?? [];
    state = AsyncValue.data([...currentData, message]);
  }

  bool get hasMore => _hasMore;
}

/// Provider for a single conversation
final conversationProvider =
    FutureProvider.family<Conversation, String>((ref, dealId) async {
  final repository = ref.watch(chatRepositoryProvider);
  return repository.getConversation(dealId);
});
