// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppNotificationImpl _$$AppNotificationImplFromJson(
        Map<String, dynamic> json) =>
    _$AppNotificationImpl(
      id: json['id'] as String,
      type: $enumDecode(_$NotificationTypeEnumMap, json['type']),
      title: json['title'] as String,
      description: json['description'] as String,
      actionUrl: json['actionUrl'] as String?,
      referenceId: json['referenceId'] as String?,
      read: json['read'] as bool? ?? false,
      readAt: json['readAt'] == null
          ? null
          : DateTime.parse(json['readAt'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$AppNotificationImplToJson(
        _$AppNotificationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$NotificationTypeEnumMap[instance.type]!,
      'title': instance.title,
      'description': instance.description,
      'actionUrl': instance.actionUrl,
      'referenceId': instance.referenceId,
      'read': instance.read,
      'readAt': instance.readAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
    };

const _$NotificationTypeEnumMap = {
  NotificationType.message: 'MESSAGE',
  NotificationType.deal: 'DEAL',
  NotificationType.payment: 'PAYMENT',
  NotificationType.application: 'APPLICATION',
  NotificationType.invitation: 'INVITATION',
  NotificationType.review: 'REVIEW',
  NotificationType.system: 'SYSTEM',
};
