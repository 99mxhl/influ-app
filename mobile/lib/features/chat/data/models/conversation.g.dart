// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConversationImpl _$$ConversationImplFromJson(Map<String, dynamic> json) =>
    _$ConversationImpl(
      id: json['id'] as String,
      dealId: json['dealId'] as String,
      dealTitle: json['dealTitle'] as String?,
      influencerId: json['influencerId'] as String,
      influencerDisplayName: json['influencerDisplayName'] as String?,
      clientId: json['clientId'] as String,
      clientDisplayName: json['clientDisplayName'] as String?,
      lastMessage: json['lastMessage'] == null
          ? null
          : Message.fromJson(json['lastMessage'] as Map<String, dynamic>),
      unreadCount: (json['unreadCount'] as num?)?.toInt() ?? 0,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$ConversationImplToJson(_$ConversationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'dealId': instance.dealId,
      'dealTitle': instance.dealTitle,
      'influencerId': instance.influencerId,
      'influencerDisplayName': instance.influencerDisplayName,
      'clientId': instance.clientId,
      'clientDisplayName': instance.clientDisplayName,
      'lastMessage': instance.lastMessage,
      'unreadCount': instance.unreadCount,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
