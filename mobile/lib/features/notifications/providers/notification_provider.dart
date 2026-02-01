import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/notification.dart';
import '../data/notification_repository.dart';

/// Provider for notifications list
final notificationsProvider =
    StateNotifierProvider<NotificationsNotifier, AsyncValue<List<AppNotification>>>(
        (ref) {
  return NotificationsNotifier(ref.watch(notificationRepositoryProvider));
});

class NotificationsNotifier extends StateNotifier<AsyncValue<List<AppNotification>>> {
  final NotificationRepository _repository;
  int _currentPage = 0;
  bool _hasMore = true;
  bool _isLoadingMore = false;

  NotificationsNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadNotifications();
  }

  Future<void> loadNotifications() async {
    state = const AsyncValue.loading();
    _currentPage = 0;
    _hasMore = true;

    try {
      final response = await _repository.getNotifications(page: 0);
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
      final response = await _repository.getNotifications(page: _currentPage + 1);
      _currentPage++;
      _hasMore = !response.last;

      final currentData = state.valueOrNull ?? [];
      state = AsyncValue.data([...currentData, ...response.content]);
    } catch (e) {
      // Don't update state on load more error
    } finally {
      _isLoadingMore = false;
    }
  }

  Future<void> refresh() async {
    await loadNotifications();
  }

  Future<void> markAsRead(String notificationId) async {
    await _repository.markAsRead(notificationId);

    final currentData = state.valueOrNull ?? [];
    state = AsyncValue.data(currentData.map((n) {
      if (n.id == notificationId) {
        return n.copyWith(read: true, readAt: DateTime.now());
      }
      return n;
    }).toList());
  }

  Future<void> markAllAsRead() async {
    await _repository.markAllAsRead();

    final currentData = state.valueOrNull ?? [];
    final now = DateTime.now();
    state = AsyncValue.data(
      currentData.map((n) => n.copyWith(read: true, readAt: now)).toList(),
    );
  }

  bool get hasMore => _hasMore;
}

/// Provider for unread notification count
final unreadNotificationCountProvider = FutureProvider<int>((ref) async {
  final repository = ref.watch(notificationRepositoryProvider);
  return repository.getUnreadCount();
});
