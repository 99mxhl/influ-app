import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../auth/providers/auth_provider.dart';
import '../data/deal_repository.dart';
import '../data/models/deal.dart';

part 'deals_provider.freezed.dart';

@freezed
class DealsState with _$DealsState {
  const factory DealsState({
    @Default([]) List<Deal> deals,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default(false) bool hasMore,
    @Default(false) bool hasLoaded,
    @Default(0) int currentPage,
    String? error,
  }) = _DealsState;
}

class DealsNotifier extends StateNotifier<DealsState> {
  final DealRepository _repository;

  DealsNotifier(this._repository) : super(const DealsState());

  Future<void> loadDeals({bool refresh = false}) async {
    if (state.isLoading) return;

    if (refresh) {
      state = state.copyWith(isLoading: true, currentPage: 0, error: null);
    } else {
      state = state.copyWith(isLoading: true, error: null);
    }

    try {
      final deals = await _repository.getDeals(page: 0);
      state = state.copyWith(
        deals: deals,
        isLoading: false,
        hasLoaded: true,
        hasMore: deals.length >= 20,
        currentPage: 0,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        hasLoaded: true,
        error: e.toString(),
      );
    }
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore) return;

    state = state.copyWith(isLoadingMore: true);

    try {
      final nextPage = state.currentPage + 1;
      final deals = await _repository.getDeals(page: nextPage);

      state = state.copyWith(
        deals: [...state.deals, ...deals],
        isLoadingMore: false,
        hasMore: deals.length >= 20,
        currentPage: nextPage,
      );
    } catch (e) {
      state = state.copyWith(
        isLoadingMore: false,
        error: e.toString(),
      );
    }
  }

  Future<void> refresh() => loadDeals(refresh: true);

  void updateDeal(Deal updatedDeal) {
    state = state.copyWith(
      deals: state.deals.map((deal) {
        return deal.id == updatedDeal.id ? updatedDeal : deal;
      }).toList(),
    );
  }

  Future<Deal> acceptTerms(String dealId) async {
    final updatedDeal = await _repository.acceptTerms(dealId);
    updateDeal(updatedDeal);
    return updatedDeal;
  }

  Future<Deal> rejectTerms(String dealId) async {
    final updatedDeal = await _repository.rejectTerms(dealId);
    updateDeal(updatedDeal);
    return updatedDeal;
  }

  Future<void> cancelDeal(String dealId) async {
    await _repository.cancelDeal(dealId);
    await refresh();
  }

  Future<Deal> proposeTerms(String dealId, ProposeTermsRequest request) async {
    final updatedDeal = await _repository.proposeTerms(dealId, request);
    updateDeal(updatedDeal);
    return updatedDeal;
  }

  Future<Deal> applyToCampaign(String campaignId, {String? message}) async {
    final newDeal = await _repository.applyToCampaign(campaignId, message: message);
    await refresh();
    return newDeal;
  }

  void reset() {
    state = const DealsState();
  }
}

final dealsProvider = StateNotifierProvider<DealsNotifier, DealsState>((ref) {
  final repository = ref.watch(dealRepositoryProvider);
  final notifier = DealsNotifier(repository);

  // Watch auth state and load/reset accordingly
  ref.listen(authStateProvider, (previous, next) {
    if (next.isAuthenticated && !next.isLoading) {
      notifier.loadDeals();
    } else if (!next.isAuthenticated && !next.isLoading) {
      notifier.reset();
    }
  });

  // Initial load if already authenticated
  final authState = ref.read(authStateProvider);
  if (authState.isAuthenticated) {
    notifier.loadDeals();
  }

  return notifier;
});

// Provider for a single deal by ID
final dealByIdProvider = FutureProvider.family<Deal, String>((ref, id) async {
  final repository = ref.watch(dealRepositoryProvider);
  return repository.getDealById(id);
});
