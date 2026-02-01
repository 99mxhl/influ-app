import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_profile_request.freezed.dart';
part 'update_profile_request.g.dart';

@freezed
class UpdateProfileRequest with _$UpdateProfileRequest {
  const factory UpdateProfileRequest({
    String? displayName,
    String? bio,
    String? avatarUrl,
  }) = _UpdateProfileRequest;

  factory UpdateProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileRequestFromJson(json);
}

@freezed
class UpdateInfluencerProfileRequest with _$UpdateInfluencerProfileRequest {
  const factory UpdateInfluencerProfileRequest({
    List<String>? categories,
    double? baseRate,
    String? instagramHandle,
    int? instagramFollowers,
    String? tiktokHandle,
    int? tiktokFollowers,
    String? youtubeHandle,
    int? youtubeSubscribers,
    String? twitterHandle,
    int? twitterFollowers,
  }) = _UpdateInfluencerProfileRequest;

  factory UpdateInfluencerProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateInfluencerProfileRequestFromJson(json);
}
