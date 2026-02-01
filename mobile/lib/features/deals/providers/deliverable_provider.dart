import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/deliverable_repository.dart';
import '../data/models/deliverable.dart';

/// Provider for deliverables of a deal
final deliverablesProvider = StateNotifierProvider.family<DeliverablesNotifier,
    AsyncValue<List<Deliverable>>, String>((ref, dealId) {
  return DeliverablesNotifier(ref.watch(deliverableRepositoryProvider), dealId);
});

class DeliverablesNotifier extends StateNotifier<AsyncValue<List<Deliverable>>> {
  final DeliverableRepository _repository;
  final String dealId;

  DeliverablesNotifier(this._repository, this.dealId)
      : super(const AsyncValue.loading()) {
    loadDeliverables();
  }

  Future<void> loadDeliverables() async {
    state = const AsyncValue.loading();
    try {
      final deliverables = await _repository.getDeliverables(dealId);
      state = AsyncValue.data(deliverables);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> submitDeliverable(
    String deliverableId,
    SubmitDeliverableRequest request,
  ) async {
    try {
      final updated =
          await _repository.submitDeliverable(dealId, deliverableId, request);
      _updateDeliverable(updated);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> approveDeliverable(String deliverableId) async {
    try {
      final updated = await _repository.approveDeliverable(dealId, deliverableId);
      _updateDeliverable(updated);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> rejectDeliverable(
    String deliverableId,
    RejectDeliverableRequest request,
  ) async {
    try {
      final updated =
          await _repository.rejectDeliverable(dealId, deliverableId, request);
      _updateDeliverable(updated);
    } catch (e) {
      rethrow;
    }
  }

  void _updateDeliverable(Deliverable updated) {
    final currentData = state.valueOrNull ?? [];
    state = AsyncValue.data(currentData.map((d) {
      if (d.id == updated.id) {
        return updated;
      }
      return d;
    }).toList());
  }

  Future<void> refresh() async {
    await loadDeliverables();
  }
}
