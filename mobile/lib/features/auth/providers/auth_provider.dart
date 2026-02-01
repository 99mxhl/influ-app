import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/storage/secure_storage.dart';
import '../../../shared/models/enums.dart';
import '../data/auth_repository.dart';
import '../data/models/auth_request.dart';
import '../data/models/user.dart';

part 'auth_provider.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const AuthState._();

  const factory AuthState({
    @Default(true) bool isLoading,
    User? user,
    String? error,
  }) = _AuthState;

  bool get isAuthenticated => user != null;
  UserType? get userType => user?.type;
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;
  final SecureStorage _secureStorage;

  AuthNotifier(this._authRepository, this._secureStorage)
      : super(const AuthState()) {
    checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final hasTokens = await _secureStorage.hasTokens();
      if (!hasTokens) {
        state = state.copyWith(isLoading: false, user: null);
        return;
      }

      final user = await _authRepository.getMe();
      state = state.copyWith(isLoading: false, user: user);
    } catch (e) {
      await _secureStorage.clearTokens();
      state = state.copyWith(isLoading: false, user: null);
    }
  }

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final request = LoginRequest(email: email, password: password);
      final response = await _authRepository.login(request);

      await _secureStorage.setTokens(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
      );

      state = state.copyWith(isLoading: false, user: response.user);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      rethrow;
    }
  }

  Future<void> register({
    required String email,
    required String password,
    required UserType type,
    String? displayName,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final request = RegisterRequest(
        email: email,
        password: password,
        type: type,
        displayName: displayName,
      );
      final response = await _authRepository.register(request);

      await _secureStorage.setTokens(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
      );

      state = state.copyWith(isLoading: false, user: response.user);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      rethrow;
    }
  }

  Future<void> logout() async {
    // Don't wait for backend - just clear local state immediately
    _authRepository.logout();
    await _secureStorage.clearTokens();
    state = const AuthState(isLoading: false, user: null);
  }

  void updateUser(User user) {
    state = state.copyWith(user: user);
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

final authStateProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final secureStorage = ref.watch(secureStorageProvider);
  return AuthNotifier(authRepository, secureStorage);
});
