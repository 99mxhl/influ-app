// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageImpl _$$MessageImplFromJson(Map<String, dynamic> json) =>
    _$MessageImpl(
      id: json['id'] as String,
      conversationId: json['conversationId'] as String,
      senderId: json['senderId'] as String?,
      senderDisplayName: json['senderDisplayName'] as String?,
      type: $enumDecodeNullable(_$MessageTypeEnumMap, json['type']) ??
          MessageType.text,
      content: json['content'] as String,
      referenceId: json['referenceId'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      readAt: json['readAt'] == null
          ? null
          : DateTime.parse(json['readAt'] as String),
    );

Map<String, dynamic> _$$MessageImplToJson(_$MessageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'conversationId': instance.conversationId,
      'senderId': instance.senderId,
      'senderDisplayName': instance.senderDisplayName,
      'type': _$MessageTypeEnumMap[instance.type]!,
      'content': instance.content,
      'referenceId': instance.referenceId,
      'createdAt': instance.createdAt?.toIso8601String(),
      'readAt': instance.readAt?.toIso8601String(),
    };

const _$MessageTypeEnumMap = {
  MessageType.text: 'TEXT',
  MessageType.termsProposal: 'TERMS_PROPOSAL',
  MessageType.system: 'SYSTEM',
  MessageType.deliverableUpdate: 'DELIVERABLE_UPDATE',
  MessageType.paymentUpdate: 'PAYMENT_UPDATE',
};

_$SendMessageRequestImpl _$$SendMessageRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$SendMessageRequestImpl(
      content: json['content'] as String,
      type: $enumDecodeNullable(_$MessageTypeEnumMap, json['type']) ??
          MessageType.text,
      referenceId: json['referenceId'] as String?,
    );

Map<String, dynamic> _$$SendMessageRequestImplToJson(
        _$SendMessageRequestImpl instance) =>
    <String, dynamic>{
      'content': instance.content,
      'type': _$MessageTypeEnumMap[instance.type]!,
      'referenceId': instance.referenceId,
    };
