import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/data/models/user.dart';
import '../../auth/providers/auth_provider.dart';
import '../data/models/update_profile_request.dart';
import '../data/user_repository.dart';

// Provider for getting a user by ID
final userByIdProvider = FutureProvider.family<User, String>((ref, userId) async {
  final repository = ref.watch(userRepositoryProvider);
  return repository.getUser(userId);
});

// Provider for the current user's profile (derived from auth state)
final currentUserProvider = Provider<User?>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.user;
});

// State notifier for updating the current user's profile
class ProfileUpdateNotifier extends StateNotifier<AsyncValue<void>> {
  final UserRepository _repository;
  final Ref _ref;

  ProfileUpdateNotifier(this._repository, this._ref) : super(const AsyncValue.data(null));

  Future<bool> updateProfile(UpdateProfileRequest request) async {
    state = const AsyncValue.loading();

    try {
      final updatedUser = await _repository.updateProfile(request);

      // Update auth state with the returned user directly
      _ref.read(authStateProvider.notifier).updateUser(updatedUser);

      state = const AsyncValue.data(null);
      return true;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }
}

final profileUpdateProvider = StateNotifierProvider<ProfileUpdateNotifier, AsyncValue<void>>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return ProfileUpdateNotifier(repository, ref);
});
