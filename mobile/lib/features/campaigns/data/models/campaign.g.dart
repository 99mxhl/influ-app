// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CampaignImpl _$$CampaignImplFromJson(Map<String, dynamic> json) =>
    _$CampaignImpl(
      id: json['id'] as String,
      clientId: json['clientId'] as String,
      clientDisplayName: json['clientDisplayName'] as String?,
      title: json['title'] as String,
      description: json['description'] as String?,
      budgetMin: (json['budgetMin'] as num).toDouble(),
      budgetMax: (json['budgetMax'] as num).toDouble(),
      status: $enumDecode(_$CampaignStatusEnumMap, json['status']),
      categories: (json['categories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      platforms: (json['platforms'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$PlatformEnumMap, e))
              .toList() ??
          const [],
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      imageUrl: json['imageUrl'] as String?,
      requirements: json['requirements'] as String?,
      targetAudience: json['targetAudience'] as String?,
      applicantCount: (json['applicantCount'] as num?)?.toInt() ?? 0,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$CampaignImplToJson(_$CampaignImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'clientId': instance.clientId,
      'clientDisplayName': instance.clientDisplayName,
      'title': instance.title,
      'description': instance.description,
      'budgetMin': instance.budgetMin,
      'budgetMax': instance.budgetMax,
      'status': _$CampaignStatusEnumMap[instance.status]!,
      'categories': instance.categories,
      'platforms':
          instance.platforms.map((e) => _$PlatformEnumMap[e]!).toList(),
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'imageUrl': instance.imageUrl,
      'requirements': instance.requirements,
      'targetAudience': instance.targetAudience,
      'applicantCount': instance.applicantCount,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$CampaignStatusEnumMap = {
  CampaignStatus.draft: 'DRAFT',
  CampaignStatus.active: 'ACTIVE',
  CampaignStatus.paused: 'PAUSED',
  CampaignStatus.completed: 'COMPLETED',
  CampaignStatus.cancelled: 'CANCELLED',
};

const _$PlatformEnumMap = {
  Platform.instagram: 'INSTAGRAM',
  Platform.tiktok: 'TIKTOK',
  Platform.youtube: 'YOUTUBE',
  Platform.twitter: 'TWITTER',
  Platform.facebook: 'FACEBOOK',
};

_$CreateCampaignRequestImpl _$$CreateCampaignRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$CreateCampaignRequestImpl(
      title: json['title'] as String,
      description: json['description'] as String?,
      budgetMin: (json['budgetMin'] as num).toDouble(),
      budgetMax: (json['budgetMax'] as num).toDouble(),
      categories: (json['categories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      platforms: (json['platforms'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$PlatformEnumMap, e))
              .toList() ??
          const [],
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
    );

Map<String, dynamic> _$$CreateCampaignRequestImplToJson(
        _$CreateCampaignRequestImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'budgetMin': instance.budgetMin,
      'budgetMax': instance.budgetMax,
      'categories': instance.categories,
      'platforms':
          instance.platforms.map((e) => _$PlatformEnumMap[e]!).toList(),
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
    };

_$UpdateCampaignRequestImpl _$$UpdateCampaignRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$UpdateCampaignRequestImpl(
      title: json['title'] as String?,
      description: json['description'] as String?,
      budgetMin: (json['budgetMin'] as num?)?.toDouble(),
      budgetMax: (json['budgetMax'] as num?)?.toDouble(),
      status: $enumDecodeNullable(_$CampaignStatusEnumMap, json['status']),
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      platforms: (json['platforms'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$PlatformEnumMap, e))
          .toList(),
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
    );

Map<String, dynamic> _$$UpdateCampaignRequestImplToJson(
        _$UpdateCampaignRequestImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'budgetMin': instance.budgetMin,
      'budgetMax': instance.budgetMax,
      'status': _$CampaignStatusEnumMap[instance.status],
      'categories': instance.categories,
      'platforms':
          instance.platforms?.map((e) => _$PlatformEnumMap[e]!).toList(),
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
    };
