// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_profile_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UpdateProfileRequestImpl _$$UpdateProfileRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$UpdateProfileRequestImpl(
      displayName: json['displayName'] as String?,
      bio: json['bio'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
    );

Map<String, dynamic> _$$UpdateProfileRequestImplToJson(
        _$UpdateProfileRequestImpl instance) =>
    <String, dynamic>{
      'displayName': instance.displayName,
      'bio': instance.bio,
      'avatarUrl': instance.avatarUrl,
    };

_$UpdateInfluencerProfileRequestImpl
    _$$UpdateInfluencerProfileRequestImplFromJson(Map<String, dynamic> json) =>
        _$UpdateInfluencerProfileRequestImpl(
          categories: (json['categories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
          baseRate: (json['baseRate'] as num?)?.toDouble(),
          instagramHandle: json['instagramHandle'] as String?,
          instagramFollowers: (json['instagramFollowers'] as num?)?.toInt(),
          tiktokHandle: json['tiktokHandle'] as String?,
          tiktokFollowers: (json['tiktokFollowers'] as num?)?.toInt(),
          youtubeHandle: json['youtubeHandle'] as String?,
          youtubeSubscribers: (json['youtubeSubscribers'] as num?)?.toInt(),
          twitterHandle: json['twitterHandle'] as String?,
          twitterFollowers: (json['twitterFollowers'] as num?)?.toInt(),
        );

Map<String, dynamic> _$$UpdateInfluencerProfileRequestImplToJson(
        _$UpdateInfluencerProfileRequestImpl instance) =>
    <String, dynamic>{
      'categories': instance.categories,
      'baseRate': instance.baseRate,
      'instagramHandle': instance.instagramHandle,
      'instagramFollowers': instance.instagramFollowers,
      'tiktokHandle': instance.tiktokHandle,
      'tiktokFollowers': instance.tiktokFollowers,
      'youtubeHandle': instance.youtubeHandle,
      'youtubeSubscribers': instance.youtubeSubscribers,
      'twitterHandle': instance.twitterHandle,
      'twitterFollowers': instance.twitterFollowers,
    };
