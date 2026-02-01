import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment.freezed.dart';
part 'payment.g.dart';

enum PaymentStatus {
  @JsonValue('PENDING')
  pending,
  @JsonValue('ESCROW_HELD')
  escrowHeld,
  @JsonValue('RELEASED')
  released,
  @JsonValue('REFUNDED')
  refunded,
  @JsonValue('FAILED')
  failed,
}

@freezed
class Payment with _$Payment {
  const factory Payment({
    required String id,
    required String dealId,
    required double amount,
    double? platformFee,
    double? influencerPayout,
    @Default(PaymentStatus.pending) PaymentStatus status,
    String? stripePaymentIntentId,
    String? stripeTransferId,
    String? failureReason,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Payment;

  factory Payment.fromJson(Map<String, dynamic> json) => _$PaymentFromJson(json);
}

extension PaymentStatusX on PaymentStatus {
  String get displayName {
    switch (this) {
      case PaymentStatus.pending:
        return 'Pending';
      case PaymentStatus.escrowHeld:
        return 'In Escrow';
      case PaymentStatus.released:
        return 'Released';
      case PaymentStatus.refunded:
        return 'Refunded';
      case PaymentStatus.failed:
        return 'Failed';
    }
  }

  bool get isComplete => this == PaymentStatus.released;
  bool get isPending => this == PaymentStatus.pending || this == PaymentStatus.escrowHeld;
}
