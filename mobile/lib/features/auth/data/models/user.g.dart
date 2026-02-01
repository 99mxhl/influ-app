// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: json['id'] as String,
      email: json['email'] as String,
      type: $enumDecode(_$UserTypeEnumMap, json['type']),
      stripeAccountId: json['stripeAccountId'] as String?,
      stripeCustomerId: json['stripeCustomerId'] as String?,
      profile: json['profile'] == null
          ? null
          : Profile.fromJson(json['profile'] as Map<String, dynamic>),
      influencerProfile: json['influencerProfile'] == null
          ? null
          : InfluencerProfile.fromJson(
              json['influencerProfile'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'type': _$UserTypeEnumMap[instance.type]!,
      'stripeAccountId': instance.stripeAccountId,
      'stripeCustomerId': instance.stripeCustomerId,
      'profile': instance.profile,
      'influencerProfile': instance.influencerProfile,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$UserTypeEnumMap = {
  UserType.influencer: 'INFLUENCER',
  UserType.client: 'CLIENT',
};

_$ProfileImpl _$$ProfileImplFromJson(Map<String, dynamic> json) =>
    _$ProfileImpl(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      displayName: json['displayName'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      bio: json['bio'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$ProfileImplToJson(_$ProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'displayName': instance.displayName,
      'avatarUrl': instance.avatarUrl,
      'bio': instance.bio,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_$InfluencerProfileImpl _$$InfluencerProfileImplFromJson(
        Map<String, dynamic> json) =>
    _$InfluencerProfileImpl(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      categories: (json['categories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      baseRate: (json['baseRate'] as num?)?.toDouble(),
      instagramHandle: json['instagramHandle'] as String?,
      instagramFollowers: (json['instagramFollowers'] as num?)?.toInt(),
      tiktokHandle: json['tiktokHandle'] as String?,
      tiktokFollowers: (json['tiktokFollowers'] as num?)?.toInt(),
      youtubeHandle: json['youtubeHandle'] as String?,
      youtubeFollowers: (json['youtubeFollowers'] as num?)?.toInt(),
      twitterHandle: json['twitterHandle'] as String?,
      twitterFollowers: (json['twitterFollowers'] as num?)?.toInt(),
      avgRating: (json['avgRating'] as num?)?.toDouble(),
      totalRatings: (json['totalRatings'] as num?)?.toInt() ?? 0,
      completedDeals: (json['completedDeals'] as num?)?.toInt() ?? 0,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$InfluencerProfileImplToJson(
        _$InfluencerProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'categories': instance.categories,
      'baseRate': instance.baseRate,
      'instagramHandle': instance.instagramHandle,
      'instagramFollowers': instance.instagramFollowers,
      'tiktokHandle': instance.tiktokHandle,
      'tiktokFollowers': instance.tiktokFollowers,
      'youtubeHandle': instance.youtubeHandle,
      'youtubeFollowers': instance.youtubeFollowers,
      'twitterHandle': instance.twitterHandle,
      'twitterFollowers': instance.twitterFollowers,
      'avgRating': instance.avgRating,
      'totalRatings': instance.totalRatings,
      'completedDeals': instance.completedDeals,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
