// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaymentImpl _$$PaymentImplFromJson(Map<String, dynamic> json) =>
    _$PaymentImpl(
      id: json['id'] as String,
      dealId: json['dealId'] as String,
      amount: (json['amount'] as num).toDouble(),
      platformFee: (json['platformFee'] as num?)?.toDouble(),
      influencerPayout: (json['influencerPayout'] as num?)?.toDouble(),
      status: $enumDecodeNullable(_$PaymentStatusEnumMap, json['status']) ??
          PaymentStatus.pending,
      stripePaymentIntentId: json['stripePaymentIntentId'] as String?,
      stripeTransferId: json['stripeTransferId'] as String?,
      failureReason: json['failureReason'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$PaymentImplToJson(_$PaymentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'dealId': instance.dealId,
      'amount': instance.amount,
      'platformFee': instance.platformFee,
      'influencerPayout': instance.influencerPayout,
      'status': _$PaymentStatusEnumMap[instance.status]!,
      'stripePaymentIntentId': instance.stripePaymentIntentId,
      'stripeTransferId': instance.stripeTransferId,
      'failureReason': instance.failureReason,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$PaymentStatusEnumMap = {
  PaymentStatus.pending: 'PENDING',
  PaymentStatus.escrowHeld: 'ESCROW_HELD',
  PaymentStatus.released: 'RELEASED',
  PaymentStatus.refunded: 'REFUNDED',
  PaymentStatus.failed: 'FAILED',
};
