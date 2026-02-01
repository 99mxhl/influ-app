import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/payment.dart';
import '../data/payment_repository.dart';

/// Provider for a single payment by deal ID
final paymentProvider =
    FutureProvider.family<Payment?, String>((ref, dealId) async {
  final repository = ref.watch(paymentRepositoryProvider);
  return repository.getPaymentForDeal(dealId);
});

/// Provider for user's payments list
final myPaymentsProvider =
    StateNotifierProvider<MyPaymentsNotifier, AsyncValue<List<Payment>>>((ref) {
  return MyPaymentsNotifier(ref.watch(paymentRepositoryProvider));
});

class MyPaymentsNotifier extends StateNotifier<AsyncValue<List<Payment>>> {
  final PaymentRepository _repository;

  MyPaymentsNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadPayments();
  }

  Future<void> loadPayments() async {
    state = const AsyncValue.loading();
    try {
      final payments = await _repository.getMyPayments();
      state = AsyncValue.data(payments);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() async {
    await loadPayments();
  }
}
