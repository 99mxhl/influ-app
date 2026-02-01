// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  String get id => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  UserType get type => throw _privateConstructorUsedError;
  String? get stripeAccountId => throw _privateConstructorUsedError;
  String? get stripeCustomerId => throw _privateConstructorUsedError;
  Profile? get profile => throw _privateConstructorUsedError;
  InfluencerProfile? get influencerProfile =>
      throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {String id,
      String email,
      UserType type,
      String? stripeAccountId,
      String? stripeCustomerId,
      Profile? profile,
      InfluencerProfile? influencerProfile,
      DateTime? createdAt,
      DateTime? updatedAt});

  $ProfileCopyWith<$Res>? get profile;
  $InfluencerProfileCopyWith<$Res>? get influencerProfile;
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? type = null,
    Object? stripeAccountId = freezed,
    Object? stripeCustomerId = freezed,
    Object? profile = freezed,
    Object? influencerProfile = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as UserType,
      stripeAccountId: freezed == stripeAccountId
          ? _value.stripeAccountId
          : stripeAccountId // ignore: cast_nullable_to_non_nullable
              as String?,
      stripeCustomerId: freezed == stripeCustomerId
          ? _value.stripeCustomerId
          : stripeCustomerId // ignore: cast_nullable_to_non_nullable
              as String?,
      profile: freezed == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as Profile?,
      influencerProfile: freezed == influencerProfile
          ? _value.influencerProfile
          : influencerProfile // ignore: cast_nullable_to_non_nullable
              as InfluencerProfile?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProfileCopyWith<$Res>? get profile {
    if (_value.profile == null) {
      return null;
    }

    return $ProfileCopyWith<$Res>(_value.profile!, (value) {
      return _then(_value.copyWith(profile: value) as $Val);
    });
  }

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $InfluencerProfileCopyWith<$Res>? get influencerProfile {
    if (_value.influencerProfile == null) {
      return null;
    }

    return $InfluencerProfileCopyWith<$Res>(_value.influencerProfile!, (value) {
      return _then(_value.copyWith(influencerProfile: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
          _$UserImpl value, $Res Function(_$UserImpl) then) =
      __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String email,
      UserType type,
      String? stripeAccountId,
      String? stripeCustomerId,
      Profile? profile,
      InfluencerProfile? influencerProfile,
      DateTime? createdAt,
      DateTime? updatedAt});

  @override
  $ProfileCopyWith<$Res>? get profile;
  @override
  $InfluencerProfileCopyWith<$Res>? get influencerProfile;
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
      : super(_value, _then);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? type = null,
    Object? stripeAccountId = freezed,
    Object? stripeCustomerId = freezed,
    Object? profile = freezed,
    Object? influencerProfile = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$UserImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as UserType,
      stripeAccountId: freezed == stripeAccountId
          ? _value.stripeAccountId
          : stripeAccountId // ignore: cast_nullable_to_non_nullable
              as String?,
      stripeCustomerId: freezed == stripeCustomerId
          ? _value.stripeCustomerId
          : stripeCustomerId // ignore: cast_nullable_to_non_nullable
              as String?,
      profile: freezed == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as Profile?,
      influencerProfile: freezed == influencerProfile
          ? _value.influencerProfile
          : influencerProfile // ignore: cast_nullable_to_non_nullable
              as InfluencerProfile?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserImpl implements _User {
  const _$UserImpl(
      {required this.id,
      required this.email,
      required this.type,
      this.stripeAccountId,
      this.stripeCustomerId,
      this.profile,
      this.influencerProfile,
      this.createdAt,
      this.updatedAt});

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

  @override
  final String id;
  @override
  final String email;
  @override
  final UserType type;
  @override
  final String? stripeAccountId;
  @override
  final String? stripeCustomerId;
  @override
  final Profile? profile;
  @override
  final InfluencerProfile? influencerProfile;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'User(id: $id, email: $email, type: $type, stripeAccountId: $stripeAccountId, stripeCustomerId: $stripeCustomerId, profile: $profile, influencerProfile: $influencerProfile, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.stripeAccountId, stripeAccountId) ||
                other.stripeAccountId == stripeAccountId) &&
            (identical(other.stripeCustomerId, stripeCustomerId) ||
                other.stripeCustomerId == stripeCustomerId) &&
            (identical(other.profile, profile) || other.profile == profile) &&
            (identical(other.influencerProfile, influencerProfile) ||
                other.influencerProfile == influencerProfile) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, email, type, stripeAccountId,
      stripeCustomerId, profile, influencerProfile, createdAt, updatedAt);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserImplToJson(
      this,
    );
  }
}

abstract class _User implements User {
  const factory _User(
      {required final String id,
      required final String email,
      required final UserType type,
      final String? stripeAccountId,
      final String? stripeCustomerId,
      final Profile? profile,
      final InfluencerProfile? influencerProfile,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$UserImpl;

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  @override
  String get id;
  @override
  String get email;
  @override
  UserType get type;
  @override
  String? get stripeAccountId;
  @override
  String? get stripeCustomerId;
  @override
  Profile? get profile;
  @override
  InfluencerProfile? get influencerProfile;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Profile _$ProfileFromJson(Map<String, dynamic> json) {
  return _Profile.fromJson(json);
}

/// @nodoc
mixin _$Profile {
  String? get id => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;
  String? get bio => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Profile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Profile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileCopyWith<Profile> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileCopyWith<$Res> {
  factory $ProfileCopyWith(Profile value, $Res Function(Profile) then) =
      _$ProfileCopyWithImpl<$Res, Profile>;
  @useResult
  $Res call(
      {String? id,
      String? userId,
      String? displayName,
      String? avatarUrl,
      String? bio,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$ProfileCopyWithImpl<$Res, $Val extends Profile>
    implements $ProfileCopyWith<$Res> {
  _$ProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Profile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? displayName = freezed,
    Object? avatarUrl = freezed,
    Object? bio = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProfileImplCopyWith<$Res> implements $ProfileCopyWith<$Res> {
  factory _$$ProfileImplCopyWith(
          _$ProfileImpl value, $Res Function(_$ProfileImpl) then) =
      __$$ProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? userId,
      String? displayName,
      String? avatarUrl,
      String? bio,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$ProfileImplCopyWithImpl<$Res>
    extends _$ProfileCopyWithImpl<$Res, _$ProfileImpl>
    implements _$$ProfileImplCopyWith<$Res> {
  __$$ProfileImplCopyWithImpl(
      _$ProfileImpl _value, $Res Function(_$ProfileImpl) _then)
      : super(_value, _then);

  /// Create a copy of Profile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? displayName = freezed,
    Object? avatarUrl = freezed,
    Object? bio = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$ProfileImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfileImpl implements _Profile {
  const _$ProfileImpl(
      {this.id,
      this.userId,
      this.displayName,
      this.avatarUrl,
      this.bio,
      this.createdAt,
      this.updatedAt});

  factory _$ProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileImplFromJson(json);

  @override
  final String? id;
  @override
  final String? userId;
  @override
  final String? displayName;
  @override
  final String? avatarUrl;
  @override
  final String? bio;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Profile(id: $id, userId: $userId, displayName: $displayName, avatarUrl: $avatarUrl, bio: $bio, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, displayName,
      avatarUrl, bio, createdAt, updatedAt);

  /// Create a copy of Profile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileImplCopyWith<_$ProfileImpl> get copyWith =>
      __$$ProfileImplCopyWithImpl<_$ProfileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileImplToJson(
      this,
    );
  }
}

abstract class _Profile implements Profile {
  const factory _Profile(
      {final String? id,
      final String? userId,
      final String? displayName,
      final String? avatarUrl,
      final String? bio,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$ProfileImpl;

  factory _Profile.fromJson(Map<String, dynamic> json) = _$ProfileImpl.fromJson;

  @override
  String? get id;
  @override
  String? get userId;
  @override
  String? get displayName;
  @override
  String? get avatarUrl;
  @override
  String? get bio;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of Profile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileImplCopyWith<_$ProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

InfluencerProfile _$InfluencerProfileFromJson(Map<String, dynamic> json) {
  return _InfluencerProfile.fromJson(json);
}

/// @nodoc
mixin _$InfluencerProfile {
  String? get id => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;
  List<String> get categories => throw _privateConstructorUsedError;
  double? get baseRate => throw _privateConstructorUsedError;
  String? get instagramHandle => throw _privateConstructorUsedError;
  int? get instagramFollowers => throw _privateConstructorUsedError;
  String? get tiktokHandle => throw _privateConstructorUsedError;
  int? get tiktokFollowers => throw _privateConstructorUsedError;
  String? get youtubeHandle => throw _privateConstructorUsedError;
  int? get youtubeFollowers => throw _privateConstructorUsedError;
  String? get twitterHandle => throw _privateConstructorUsedError;
  int? get twitterFollowers => throw _privateConstructorUsedError;
  double? get avgRating => throw _privateConstructorUsedError;
  int get totalRatings => throw _privateConstructorUsedError;
  int get completedDeals => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this InfluencerProfile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InfluencerProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InfluencerProfileCopyWith<InfluencerProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InfluencerProfileCopyWith<$Res> {
  factory $InfluencerProfileCopyWith(
          InfluencerProfile value, $Res Function(InfluencerProfile) then) =
      _$InfluencerProfileCopyWithImpl<$Res, InfluencerProfile>;
  @useResult
  $Res call(
      {String? id,
      String? userId,
      List<String> categories,
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
      int totalRatings,
      int completedDeals,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$InfluencerProfileCopyWithImpl<$Res, $Val extends InfluencerProfile>
    implements $InfluencerProfileCopyWith<$Res> {
  _$InfluencerProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InfluencerProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? categories = null,
    Object? baseRate = freezed,
    Object? instagramHandle = freezed,
    Object? instagramFollowers = freezed,
    Object? tiktokHandle = freezed,
    Object? tiktokFollowers = freezed,
    Object? youtubeHandle = freezed,
    Object? youtubeFollowers = freezed,
    Object? twitterHandle = freezed,
    Object? twitterFollowers = freezed,
    Object? avgRating = freezed,
    Object? totalRatings = null,
    Object? completedDeals = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      baseRate: freezed == baseRate
          ? _value.baseRate
          : baseRate // ignore: cast_nullable_to_non_nullable
              as double?,
      instagramHandle: freezed == instagramHandle
          ? _value.instagramHandle
          : instagramHandle // ignore: cast_nullable_to_non_nullable
              as String?,
      instagramFollowers: freezed == instagramFollowers
          ? _value.instagramFollowers
          : instagramFollowers // ignore: cast_nullable_to_non_nullable
              as int?,
      tiktokHandle: freezed == tiktokHandle
          ? _value.tiktokHandle
          : tiktokHandle // ignore: cast_nullable_to_non_nullable
              as String?,
      tiktokFollowers: freezed == tiktokFollowers
          ? _value.tiktokFollowers
          : tiktokFollowers // ignore: cast_nullable_to_non_nullable
              as int?,
      youtubeHandle: freezed == youtubeHandle
          ? _value.youtubeHandle
          : youtubeHandle // ignore: cast_nullable_to_non_nullable
              as String?,
      youtubeFollowers: freezed == youtubeFollowers
          ? _value.youtubeFollowers
          : youtubeFollowers // ignore: cast_nullable_to_non_nullable
              as int?,
      twitterHandle: freezed == twitterHandle
          ? _value.twitterHandle
          : twitterHandle // ignore: cast_nullable_to_non_nullable
              as String?,
      twitterFollowers: freezed == twitterFollowers
          ? _value.twitterFollowers
          : twitterFollowers // ignore: cast_nullable_to_non_nullable
              as int?,
      avgRating: freezed == avgRating
          ? _value.avgRating
          : avgRating // ignore: cast_nullable_to_non_nullable
              as double?,
      totalRatings: null == totalRatings
          ? _value.totalRatings
          : totalRatings // ignore: cast_nullable_to_non_nullable
              as int,
      completedDeals: null == completedDeals
          ? _value.completedDeals
          : completedDeals // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InfluencerProfileImplCopyWith<$Res>
    implements $InfluencerProfileCopyWith<$Res> {
  factory _$$InfluencerProfileImplCopyWith(_$InfluencerProfileImpl value,
          $Res Function(_$InfluencerProfileImpl) then) =
      __$$InfluencerProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? userId,
      List<String> categories,
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
      int totalRatings,
      int completedDeals,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$InfluencerProfileImplCopyWithImpl<$Res>
    extends _$InfluencerProfileCopyWithImpl<$Res, _$InfluencerProfileImpl>
    implements _$$InfluencerProfileImplCopyWith<$Res> {
  __$$InfluencerProfileImplCopyWithImpl(_$InfluencerProfileImpl _value,
      $Res Function(_$InfluencerProfileImpl) _then)
      : super(_value, _then);

  /// Create a copy of InfluencerProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? categories = null,
    Object? baseRate = freezed,
    Object? instagramHandle = freezed,
    Object? instagramFollowers = freezed,
    Object? tiktokHandle = freezed,
    Object? tiktokFollowers = freezed,
    Object? youtubeHandle = freezed,
    Object? youtubeFollowers = freezed,
    Object? twitterHandle = freezed,
    Object? twitterFollowers = freezed,
    Object? avgRating = freezed,
    Object? totalRatings = null,
    Object? completedDeals = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$InfluencerProfileImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      categories: null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      baseRate: freezed == baseRate
          ? _value.baseRate
          : baseRate // ignore: cast_nullable_to_non_nullable
              as double?,
      instagramHandle: freezed == instagramHandle
          ? _value.instagramHandle
          : instagramHandle // ignore: cast_nullable_to_non_nullable
              as String?,
      instagramFollowers: freezed == instagramFollowers
          ? _value.instagramFollowers
          : instagramFollowers // ignore: cast_nullable_to_non_nullable
              as int?,
      tiktokHandle: freezed == tiktokHandle
          ? _value.tiktokHandle
          : tiktokHandle // ignore: cast_nullable_to_non_nullable
              as String?,
      tiktokFollowers: freezed == tiktokFollowers
          ? _value.tiktokFollowers
          : tiktokFollowers // ignore: cast_nullable_to_non_nullable
              as int?,
      youtubeHandle: freezed == youtubeHandle
          ? _value.youtubeHandle
          : youtubeHandle // ignore: cast_nullable_to_non_nullable
              as String?,
      youtubeFollowers: freezed == youtubeFollowers
          ? _value.youtubeFollowers
          : youtubeFollowers // ignore: cast_nullable_to_non_nullable
              as int?,
      twitterHandle: freezed == twitterHandle
          ? _value.twitterHandle
          : twitterHandle // ignore: cast_nullable_to_non_nullable
              as String?,
      twitterFollowers: freezed == twitterFollowers
          ? _value.twitterFollowers
          : twitterFollowers // ignore: cast_nullable_to_non_nullable
              as int?,
      avgRating: freezed == avgRating
          ? _value.avgRating
          : avgRating // ignore: cast_nullable_to_non_nullable
              as double?,
      totalRatings: null == totalRatings
          ? _value.totalRatings
          : totalRatings // ignore: cast_nullable_to_non_nullable
              as int,
      completedDeals: null == completedDeals
          ? _value.completedDeals
          : completedDeals // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InfluencerProfileImpl implements _InfluencerProfile {
  const _$InfluencerProfileImpl(
      {this.id,
      this.userId,
      final List<String> categories = const [],
      this.baseRate,
      this.instagramHandle,
      this.instagramFollowers,
      this.tiktokHandle,
      this.tiktokFollowers,
      this.youtubeHandle,
      this.youtubeFollowers,
      this.twitterHandle,
      this.twitterFollowers,
      this.avgRating,
      this.totalRatings = 0,
      this.completedDeals = 0,
      this.createdAt,
      this.updatedAt})
      : _categories = categories;

  factory _$InfluencerProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$InfluencerProfileImplFromJson(json);

  @override
  final String? id;
  @override
  final String? userId;
  final List<String> _categories;
  @override
  @JsonKey()
  List<String> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  @override
  final double? baseRate;
  @override
  final String? instagramHandle;
  @override
  final int? instagramFollowers;
  @override
  final String? tiktokHandle;
  @override
  final int? tiktokFollowers;
  @override
  final String? youtubeHandle;
  @override
  final int? youtubeFollowers;
  @override
  final String? twitterHandle;
  @override
  final int? twitterFollowers;
  @override
  final double? avgRating;
  @override
  @JsonKey()
  final int totalRatings;
  @override
  @JsonKey()
  final int completedDeals;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'InfluencerProfile(id: $id, userId: $userId, categories: $categories, baseRate: $baseRate, instagramHandle: $instagramHandle, instagramFollowers: $instagramFollowers, tiktokHandle: $tiktokHandle, tiktokFollowers: $tiktokFollowers, youtubeHandle: $youtubeHandle, youtubeFollowers: $youtubeFollowers, twitterHandle: $twitterHandle, twitterFollowers: $twitterFollowers, avgRating: $avgRating, totalRatings: $totalRatings, completedDeals: $completedDeals, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InfluencerProfileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            (identical(other.baseRate, baseRate) ||
                other.baseRate == baseRate) &&
            (identical(other.instagramHandle, instagramHandle) ||
                other.instagramHandle == instagramHandle) &&
            (identical(other.instagramFollowers, instagramFollowers) ||
                other.instagramFollowers == instagramFollowers) &&
            (identical(other.tiktokHandle, tiktokHandle) ||
                other.tiktokHandle == tiktokHandle) &&
            (identical(other.tiktokFollowers, tiktokFollowers) ||
                other.tiktokFollowers == tiktokFollowers) &&
            (identical(other.youtubeHandle, youtubeHandle) ||
                other.youtubeHandle == youtubeHandle) &&
            (identical(other.youtubeFollowers, youtubeFollowers) ||
                other.youtubeFollowers == youtubeFollowers) &&
            (identical(other.twitterHandle, twitterHandle) ||
                other.twitterHandle == twitterHandle) &&
            (identical(other.twitterFollowers, twitterFollowers) ||
                other.twitterFollowers == twitterFollowers) &&
            (identical(other.avgRating, avgRating) ||
                other.avgRating == avgRating) &&
            (identical(other.totalRatings, totalRatings) ||
                other.totalRatings == totalRatings) &&
            (identical(other.completedDeals, completedDeals) ||
                other.completedDeals == completedDeals) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      const DeepCollectionEquality().hash(_categories),
      baseRate,
      instagramHandle,
      instagramFollowers,
      tiktokHandle,
      tiktokFollowers,
      youtubeHandle,
      youtubeFollowers,
      twitterHandle,
      twitterFollowers,
      avgRating,
      totalRatings,
      completedDeals,
      createdAt,
      updatedAt);

  /// Create a copy of InfluencerProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InfluencerProfileImplCopyWith<_$InfluencerProfileImpl> get copyWith =>
      __$$InfluencerProfileImplCopyWithImpl<_$InfluencerProfileImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InfluencerProfileImplToJson(
      this,
    );
  }
}

abstract class _InfluencerProfile implements InfluencerProfile {
  const factory _InfluencerProfile(
      {final String? id,
      final String? userId,
      final List<String> categories,
      final double? baseRate,
      final String? instagramHandle,
      final int? instagramFollowers,
      final String? tiktokHandle,
      final int? tiktokFollowers,
      final String? youtubeHandle,
      final int? youtubeFollowers,
      final String? twitterHandle,
      final int? twitterFollowers,
      final double? avgRating,
      final int totalRatings,
      final int completedDeals,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$InfluencerProfileImpl;

  factory _InfluencerProfile.fromJson(Map<String, dynamic> json) =
      _$InfluencerProfileImpl.fromJson;

  @override
  String? get id;
  @override
  String? get userId;
  @override
  List<String> get categories;
  @override
  double? get baseRate;
  @override
  String? get instagramHandle;
  @override
  int? get instagramFollowers;
  @override
  String? get tiktokHandle;
  @override
  int? get tiktokFollowers;
  @override
  String? get youtubeHandle;
  @override
  int? get youtubeFollowers;
  @override
  String? get twitterHandle;
  @override
  int? get twitterFollowers;
  @override
  double? get avgRating;
  @override
  int get totalRatings;
  @override
  int get completedDeals;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of InfluencerProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InfluencerProfileImplCopyWith<_$InfluencerProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
