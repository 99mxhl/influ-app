import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../shared/models/enums.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String email,
    required UserType type,
    String? stripeAccountId,
    String? stripeCustomerId,
    Profile? profile,
    InfluencerProfile? influencerProfile,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@freezed
class Profile with _$Profile {
  const factory Profile({
    String? id,
    String? userId,
    String? displayName,
    String? avatarUrl,
    String? bio,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Profile;

  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);
}

@freezed
class InfluencerProfile with _$InfluencerProfile {
  const factory InfluencerProfile({
    String? id,
    String? userId,
    @Default([]) List<String> categories,
    double? baseRate,
    String? instagramHandle,
    int? instagramFollowers,
    String? tiktokHandle,
    int? tiktokFollowers,
    String? youtubeHandle,
    int? youtubeFollowers,
    String? twitterHandle,
    int? twitterFollowers,
    double? avgRating,
    @Default(0) int totalRatings,
    @Default(0) int completedDeals,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _InfluencerProfile;

  factory InfluencerProfile.fromJson(Map<String, dynamic> json) =>
      _$InfluencerProfileFromJson(json);
}
