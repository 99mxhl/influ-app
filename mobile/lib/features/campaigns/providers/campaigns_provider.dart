import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../shared/models/enums.dart';
import '../../auth/providers/auth_provider.dart';
import '../data/campaign_repository.dart';
import '../data/models/campaign.dart';

part 'campaigns_provider.freezed.dart';

@freezed
class CampaignsState with _$CampaignsState {
  const factory CampaignsState({
    @Default([]) List<Campaign> campaigns,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default(false) bool hasMore,
    @Default(false) bool hasLoaded,
    @Default(0) int currentPage,
    String? error,
  }) = _CampaignsState;
}

class CampaignsNotifier extends StateNotifier<CampaignsState> {
  final CampaignRepository _repository;

  CampaignsNotifier(this._repository) : super(const CampaignsState());

  Future<void> loadCampaigns({bool refresh = false}) async {
    if (state.isLoading) return;

    if (refresh) {
      state = state.copyWith(isLoading: true, currentPage: 0, error: null);
    } else {
      state = state.copyWith(isLoading: true, error: null);
    }

    try {
      final campaigns = await _repository.getCampaigns(page: 0);
      state = state.copyWith(
        campaigns: campaigns,
        isLoading: false,
        hasLoaded: true,
        hasMore: campaigns.length >= 20,
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
      final campaigns = await _repository.getCampaigns(page: nextPage);

      state = state.copyWith(
        campaigns: [...state.campaigns, ...campaigns],
        isLoadingMore: false,
        hasMore: campaigns.length >= 20,
        currentPage: nextPage,
      );
    } catch (e) {
      state = state.copyWith(
        isLoadingMore: false,
        error: e.toString(),
      );
    }
  }

  Future<void> refresh() => loadCampaigns(refresh: true);

  void reset() {
    state = const CampaignsState();
  }
}

final campaignsProvider =
    StateNotifierProvider<CampaignsNotifier, CampaignsState>((ref) {
  final repository = ref.watch(campaignRepositoryProvider);
  final notifier = CampaignsNotifier(repository);

  // Watch auth state and load/reset accordingly (only for INFLUENCER users)
  ref.listen(authStateProvider, (previous, next) {
    if (next.isAuthenticated && !next.isLoading && next.user?.type == UserType.influencer) {
      notifier.loadCampaigns();
    } else if (!next.isAuthenticated && !next.isLoading) {
      notifier.reset();
    }
  });

  // Initial load if already authenticated (only for INFLUENCER users)
  final authState = ref.read(authStateProvider);
  if (authState.isAuthenticated && authState.user?.type == UserType.influencer) {
    notifier.loadCampaigns();
  }

  return notifier;
});

// Provider for a single campaign by ID
final campaignByIdProvider =
    FutureProvider.family<Campaign, String>((ref, id) async {
  final repository = ref.watch(campaignRepositoryProvider);
  return repository.getCampaignById(id);
});

// Provider for user's own campaigns (CLIENT)
@freezed
class MyCampaignsState with _$MyCampaignsState {
  const factory MyCampaignsState({
    @Default([]) List<Campaign> campaigns,
    @Default(false) bool isLoading,
    @Default(false) bool hasLoaded,
    String? error,
  }) = _MyCampaignsState;
}

class MyCampaignsNotifier extends StateNotifier<MyCampaignsState> {
  final CampaignRepository _repository;

  MyCampaignsNotifier(this._repository) : super(const MyCampaignsState());

  Future<void> loadMyCampaigns() async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final campaigns = await _repository.getMyCampaigns();
      state = state.copyWith(
        campaigns: campaigns,
        isLoading: false,
        hasLoaded: true,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        hasLoaded: true,
        error: e.toString(),
      );
    }
  }

  Future<void> refresh() => loadMyCampaigns();

  void reset() {
    state = const MyCampaignsState();
  }
}

final myCampaignsProvider =
    StateNotifierProvider<MyCampaignsNotifier, MyCampaignsState>((ref) {
  final repository = ref.watch(campaignRepositoryProvider);
  final notifier = MyCampaignsNotifier(repository);

  // Watch auth state and load/reset accordingly (only for CLIENT users)
  ref.listen(authStateProvider, (previous, next) {
    if (next.isAuthenticated && !next.isLoading && next.user?.type == UserType.client) {
      notifier.loadMyCampaigns();
    } else if (!next.isAuthenticated && !next.isLoading) {
      notifier.reset();
    }
  });

  // Initial load if already authenticated (only for CLIENT users)
  final authState = ref.read(authStateProvider);
  if (authState.isAuthenticated && authState.user?.type == UserType.client) {
    notifier.loadMyCampaigns();
  }

  return notifier;
});
