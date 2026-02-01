// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deliverable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DeliverableImpl _$$DeliverableImplFromJson(Map<String, dynamic> json) =>
    _$DeliverableImpl(
      id: json['id'] as String,
      dealId: json['dealId'] as String,
      platform: $enumDecode(_$PlatformEnumMap, json['platform']),
      contentType: $enumDecode(_$ContentTypeEnumMap, json['contentType']),
      description: json['description'] as String?,
      contentUrl: json['contentUrl'] as String?,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      status: $enumDecodeNullable(_$DeliverableStatusEnumMap, json['status']) ??
          DeliverableStatus.pending,
      rejectionReason: json['rejectionReason'] as String?,
      revisionNotes: json['revisionNotes'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$DeliverableImplToJson(_$DeliverableImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'dealId': instance.dealId,
      'platform': _$PlatformEnumMap[instance.platform]!,
      'contentType': _$ContentTypeEnumMap[instance.contentType]!,
      'description': instance.description,
      'contentUrl': instance.contentUrl,
      'thumbnailUrl': instance.thumbnailUrl,
      'status': _$DeliverableStatusEnumMap[instance.status]!,
      'rejectionReason': instance.rejectionReason,
      'revisionNotes': instance.revisionNotes,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$PlatformEnumMap = {
  Platform.instagram: 'INSTAGRAM',
  Platform.tiktok: 'TIKTOK',
  Platform.youtube: 'YOUTUBE',
  Platform.twitter: 'TWITTER',
  Platform.facebook: 'FACEBOOK',
};

const _$ContentTypeEnumMap = {
  ContentType.post: 'POST',
  ContentType.story: 'STORY',
  ContentType.reel: 'REEL',
  ContentType.video: 'VIDEO',
};

const _$DeliverableStatusEnumMap = {
  DeliverableStatus.pending: 'PENDING',
  DeliverableStatus.submitted: 'SUBMITTED',
  DeliverableStatus.approved: 'APPROVED',
  DeliverableStatus.rejected: 'REJECTED',
  DeliverableStatus.revisionRequested: 'REVISION_REQUESTED',
};

_$SubmitDeliverableRequestImpl _$$SubmitDeliverableRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$SubmitDeliverableRequestImpl(
      contentUrl: json['contentUrl'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String?,
    );

Map<String, dynamic> _$$SubmitDeliverableRequestImplToJson(
        _$SubmitDeliverableRequestImpl instance) =>
    <String, dynamic>{
      'contentUrl': instance.contentUrl,
      'thumbnailUrl': instance.thumbnailUrl,
    };

_$RejectDeliverableRequestImpl _$$RejectDeliverableRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$RejectDeliverableRequestImpl(
      reason: json['reason'] as String,
      revisionNotes: json['revisionNotes'] as String?,
    );

Map<String, dynamic> _$$RejectDeliverableRequestImplToJson(
        _$RejectDeliverableRequestImpl instance) =>
    <String, dynamic>{
      'reason': instance.reason,
      'revisionNotes': instance.revisionNotes,
    };
