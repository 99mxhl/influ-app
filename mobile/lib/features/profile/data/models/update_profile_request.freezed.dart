// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_profile_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UpdateProfileRequest _$UpdateProfileRequestFromJson(Map<String, dynamic> json) {
  return _UpdateProfileRequest.fromJson(json);
}

/// @nodoc
mixin _$UpdateProfileRequest {
  String? get displayName => throw _privateConstructorUsedError;
  String? get bio => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;

  /// Serializes this UpdateProfileRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdateProfileRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdateProfileRequestCopyWith<UpdateProfileRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateProfileRequestCopyWith<$Res> {
  factory $UpdateProfileRequestCopyWith(UpdateProfileRequest value,
          $Res Function(UpdateProfileRequest) then) =
      _$UpdateProfileRequestCopyWithImpl<$Res, UpdateProfileRequest>;
  @useResult
  $Res call({String? displayName, String? bio, String? avatarUrl});
}

/// @nodoc
class _$UpdateProfileRequestCopyWithImpl<$Res,
        $Val extends UpdateProfileRequest>
    implements $UpdateProfileRequestCopyWith<$Res> {
  _$UpdateProfileRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdateProfileRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? displayName = freezed,
    Object? bio = freezed,
    Object? avatarUrl = freezed,
  }) {
    return _then(_value.copyWith(
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UpdateProfileRequestImplCopyWith<$Res>
    implements $UpdateProfileRequestCopyWith<$Res> {
  factory _$$UpdateProfileRequestImplCopyWith(_$UpdateProfileRequestImpl value,
          $Res Function(_$UpdateProfileRequestImpl) then) =
      __$$UpdateProfileRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? displayName, String? bio, String? avatarUrl});
}

/// @nodoc
class __$$UpdateProfileRequestImplCopyWithImpl<$Res>
    extends _$UpdateProfileRequestCopyWithImpl<$Res, _$UpdateProfileRequestImpl>
    implements _$$UpdateProfileRequestImplCopyWith<$Res> {
  __$$UpdateProfileRequestImplCopyWithImpl(_$UpdateProfileRequestImpl _value,
      $Res Function(_$UpdateProfileRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of UpdateProfileRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? displayName = freezed,
    Object? bio = freezed,
    Object? avatarUrl = freezed,
  }) {
    return _then(_$UpdateProfileRequestImpl(
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateProfileRequestImpl implements _UpdateProfileRequest {
  const _$UpdateProfileRequestImpl(
      {this.displayName, this.bio, this.avatarUrl});

  factory _$UpdateProfileRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateProfileRequestImplFromJson(json);

  @override
  final String? displayName;
  @override
  final String? bio;
  @override
  final String? avatarUrl;

  @override
  String toString() {
    return 'UpdateProfileRequest(displayName: $displayName, bio: $bio, avatarUrl: $avatarUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateProfileRequestImpl &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, displayName, bio, avatarUrl);

  /// Create a copy of UpdateProfileRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateProfileRequestImplCopyWith<_$UpdateProfileRequestImpl>
      get copyWith =>
          __$$UpdateProfileRequestImplCopyWithImpl<_$UpdateProfileRequestImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateProfileRequestImplToJson(
      this,
    );
  }
}

abstract class _UpdateProfileRequest implements UpdateProfileRequest {
  const factory _UpdateProfileRequest(
      {final String? displayName,
      final String? bio,
      final String? avatarUrl}) = _$UpdateProfileRequestImpl;

  factory _UpdateProfileRequest.fromJson(Map<String, dynamic> json) =
      _$UpdateProfileRequestImpl.fromJson;

  @override
  String? get displayName;
  @override
  String? get bio;
  @override
  String? get avatarUrl;

  /// Create a copy of UpdateProfileRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateProfileRequestImplCopyWith<_$UpdateProfileRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

UpdateInfluencerProfileRequest _$UpdateInfluencerProfileRequestFromJson(
    Map<String, dynamic> json) {
  return _UpdateInfluencerProfileRequest.fromJson(json);
}

/// @nodoc
mixin _$UpdateInfluencerProfileRequest {
  List<String>? get categories => throw _privateConstructorUsedError;
  double? get baseRate => throw _privateConstructorUsedError;
  String? get instagramHandle => throw _privateConstructorUsedError;
  int? get instagramFollowers => throw _privateConstructorUsedError;
  String? get tiktokHandle => throw _privateConstructorUsedError;
  int? get tiktokFollowers => throw _privateConstructorUsedError;
  String? get youtubeHandle => throw _privateConstructorUsedError;
  int? get youtubeSubscribers => throw _privateConstructorUsedError;
  String? get twitterHandle => throw _privateConstructorUsedError;
  int? get twitterFollowers => throw _privateConstructorUsedError;

  /// Serializes this UpdateInfluencerProfileRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdateInfluencerProfileRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdateInfluencerProfileRequestCopyWith<UpdateInfluencerProfileRequest>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateInfluencerProfileRequestCopyWith<$Res> {
  factory $UpdateInfluencerProfileRequestCopyWith(
          UpdateInfluencerProfileRequest value,
          $Res Function(UpdateInfluencerProfileRequest) then) =
      _$UpdateInfluencerProfileRequestCopyWithImpl<$Res,
          UpdateInfluencerProfileRequest>;
  @useResult
  $Res call(
      {List<String>? categories,
      double? baseRate,
      String? instagramHandle,
      int? instagramFollowers,
      String? tiktokHandle,
      int? tiktokFollowers,
      String? youtubeHandle,
      int? youtubeSubscribers,
      String? twitterHandle,
      int? twitterFollowers});
}

/// @nodoc
class _$UpdateInfluencerProfileRequestCopyWithImpl<$Res,
        $Val extends UpdateInfluencerProfileRequest>
    implements $UpdateInfluencerProfileRequestCopyWith<$Res> {
  _$UpdateInfluencerProfileRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdateInfluencerProfileRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categories = freezed,
    Object? baseRate = freezed,
    Object? instagramHandle = freezed,
    Object? instagramFollowers = freezed,
    Object? tiktokHandle = freezed,
    Object? tiktokFollowers = freezed,
    Object? youtubeHandle = freezed,
    Object? youtubeSubscribers = freezed,
    Object? twitterHandle = freezed,
    Object? twitterFollowers = freezed,
  }) {
    return _then(_value.copyWith(
      categories: freezed == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<String>?,
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
      youtubeSubscribers: freezed == youtubeSubscribers
          ? _value.youtubeSubscribers
          : youtubeSubscribers // ignore: cast_nullable_to_non_nullable
              as int?,
      twitterHandle: freezed == twitterHandle
          ? _value.twitterHandle
          : twitterHandle // ignore: cast_nullable_to_non_nullable
              as String?,
      twitterFollowers: freezed == twitterFollowers
          ? _value.twitterFollowers
          : twitterFollowers // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UpdateInfluencerProfileRequestImplCopyWith<$Res>
    implements $UpdateInfluencerProfileRequestCopyWith<$Res> {
  factory _$$UpdateInfluencerProfileRequestImplCopyWith(
          _$UpdateInfluencerProfileRequestImpl value,
          $Res Function(_$UpdateInfluencerProfileRequestImpl) then) =
      __$$UpdateInfluencerProfileRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String>? categories,
      double? baseRate,
      String? instagramHandle,
      int? instagramFollowers,
      String? tiktokHandle,
      int? tiktokFollowers,
      String? youtubeHandle,
      int? youtubeSubscribers,
      String? twitterHandle,
      int? twitterFollowers});
}

/// @nodoc
class __$$UpdateInfluencerProfileRequestImplCopyWithImpl<$Res>
    extends _$UpdateInfluencerProfileRequestCopyWithImpl<$Res,
        _$UpdateInfluencerProfileRequestImpl>
    implements _$$UpdateInfluencerProfileRequestImplCopyWith<$Res> {
  __$$UpdateInfluencerProfileRequestImplCopyWithImpl(
      _$UpdateInfluencerProfileRequestImpl _value,
      $Res Function(_$UpdateInfluencerProfileRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of UpdateInfluencerProfileRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categories = freezed,
    Object? baseRate = freezed,
    Object? instagramHandle = freezed,
    Object? instagramFollowers = freezed,
    Object? tiktokHandle = freezed,
    Object? tiktokFollowers = freezed,
    Object? youtubeHandle = freezed,
    Object? youtubeSubscribers = freezed,
    Object? twitterHandle = freezed,
    Object? twitterFollowers = freezed,
  }) {
    return _then(_$UpdateInfluencerProfileRequestImpl(
      categories: freezed == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<String>?,
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
      youtubeSubscribers: freezed == youtubeSubscribers
          ? _value.youtubeSubscribers
          : youtubeSubscribers // ignore: cast_nullable_to_non_nullable
              as int?,
      twitterHandle: freezed == twitterHandle
          ? _value.twitterHandle
          : twitterHandle // ignore: cast_nullable_to_non_nullable
              as String?,
      twitterFollowers: freezed == twitterFollowers
          ? _value.twitterFollowers
          : twitterFollowers // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateInfluencerProfileRequestImpl
    implements _UpdateInfluencerProfileRequest {
  const _$UpdateInfluencerProfileRequestImpl(
      {final List<String>? categories,
      this.baseRate,
      this.instagramHandle,
      this.instagramFollowers,
      this.tiktokHandle,
      this.tiktokFollowers,
      this.youtubeHandle,
      this.youtubeSubscribers,
      this.twitterHandle,
      this.twitterFollowers})
      : _categories = categories;

  factory _$UpdateInfluencerProfileRequestImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$UpdateInfluencerProfileRequestImplFromJson(json);

  final List<String>? _categories;
  @override
  List<String>? get categories {
    final value = _categories;
    if (value == null) return null;
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
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
  final int? youtubeSubscribers;
  @override
  final String? twitterHandle;
  @override
  final int? twitterFollowers;

  @override
  String toString() {
    return 'UpdateInfluencerProfileRequest(categories: $categories, baseRate: $baseRate, instagramHandle: $instagramHandle, instagramFollowers: $instagramFollowers, tiktokHandle: $tiktokHandle, tiktokFollowers: $tiktokFollowers, youtubeHandle: $youtubeHandle, youtubeSubscribers: $youtubeSubscribers, twitterHandle: $twitterHandle, twitterFollowers: $twitterFollowers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateInfluencerProfileRequestImpl &&
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
            (identical(other.youtubeSubscribers, youtubeSubscribers) ||
                other.youtubeSubscribers == youtubeSubscribers) &&
            (identical(other.twitterHandle, twitterHandle) ||
                other.twitterHandle == twitterHandle) &&
            (identical(other.twitterFollowers, twitterFollowers) ||
                other.twitterFollowers == twitterFollowers));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_categories),
      baseRate,
      instagramHandle,
      instagramFollowers,
      tiktokHandle,
      tiktokFollowers,
      youtubeHandle,
      youtubeSubscribers,
      twitterHandle,
      twitterFollowers);

  /// Create a copy of UpdateInfluencerProfileRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateInfluencerProfileRequestImplCopyWith<
          _$UpdateInfluencerProfileRequestImpl>
      get copyWith => __$$UpdateInfluencerProfileRequestImplCopyWithImpl<
          _$UpdateInfluencerProfileRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateInfluencerProfileRequestImplToJson(
      this,
    );
  }
}

abstract class _UpdateInfluencerProfileRequest
    implements UpdateInfluencerProfileRequest {
  const factory _UpdateInfluencerProfileRequest(
      {final List<String>? categories,
      final double? baseRate,
      final String? instagramHandle,
      final int? instagramFollowers,
      final String? tiktokHandle,
      final int? tiktokFollowers,
      final String? youtubeHandle,
      final int? youtubeSubscribers,
      final String? twitterHandle,
      final int? twitterFollowers}) = _$UpdateInfluencerProfileRequestImpl;

  factory _UpdateInfluencerProfileRequest.fromJson(Map<String, dynamic> json) =
      _$UpdateInfluencerProfileRequestImpl.fromJson;

  @override
  List<String>? get categories;
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
  int? get youtubeSubscribers;
  @override
  String? get twitterHandle;
  @override
  int? get twitterFollowers;

  /// Create a copy of UpdateInfluencerProfileRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateInfluencerProfileRequestImplCopyWith<
          _$UpdateInfluencerProfileRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
