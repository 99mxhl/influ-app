// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'deliverable.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Deliverable _$DeliverableFromJson(Map<String, dynamic> json) {
  return _Deliverable.fromJson(json);
}

/// @nodoc
mixin _$Deliverable {
  String get id => throw _privateConstructorUsedError;
  String get dealId => throw _privateConstructorUsedError;
  Platform get platform => throw _privateConstructorUsedError;
  ContentType get contentType => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get contentUrl => throw _privateConstructorUsedError;
  String? get thumbnailUrl => throw _privateConstructorUsedError;
  DeliverableStatus get status => throw _privateConstructorUsedError;
  String? get rejectionReason => throw _privateConstructorUsedError;
  String? get revisionNotes => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Deliverable to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Deliverable
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeliverableCopyWith<Deliverable> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeliverableCopyWith<$Res> {
  factory $DeliverableCopyWith(
          Deliverable value, $Res Function(Deliverable) then) =
      _$DeliverableCopyWithImpl<$Res, Deliverable>;
  @useResult
  $Res call(
      {String id,
      String dealId,
      Platform platform,
      ContentType contentType,
      String? description,
      String? contentUrl,
      String? thumbnailUrl,
      DeliverableStatus status,
      String? rejectionReason,
      String? revisionNotes,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$DeliverableCopyWithImpl<$Res, $Val extends Deliverable>
    implements $DeliverableCopyWith<$Res> {
  _$DeliverableCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Deliverable
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? dealId = null,
    Object? platform = null,
    Object? contentType = null,
    Object? description = freezed,
    Object? contentUrl = freezed,
    Object? thumbnailUrl = freezed,
    Object? status = null,
    Object? rejectionReason = freezed,
    Object? revisionNotes = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      dealId: null == dealId
          ? _value.dealId
          : dealId // ignore: cast_nullable_to_non_nullable
              as String,
      platform: null == platform
          ? _value.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as Platform,
      contentType: null == contentType
          ? _value.contentType
          : contentType // ignore: cast_nullable_to_non_nullable
              as ContentType,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      contentUrl: freezed == contentUrl
          ? _value.contentUrl
          : contentUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      thumbnailUrl: freezed == thumbnailUrl
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as DeliverableStatus,
      rejectionReason: freezed == rejectionReason
          ? _value.rejectionReason
          : rejectionReason // ignore: cast_nullable_to_non_nullable
              as String?,
      revisionNotes: freezed == revisionNotes
          ? _value.revisionNotes
          : revisionNotes // ignore: cast_nullable_to_non_nullable
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
abstract class _$$DeliverableImplCopyWith<$Res>
    implements $DeliverableCopyWith<$Res> {
  factory _$$DeliverableImplCopyWith(
          _$DeliverableImpl value, $Res Function(_$DeliverableImpl) then) =
      __$$DeliverableImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String dealId,
      Platform platform,
      ContentType contentType,
      String? description,
      String? contentUrl,
      String? thumbnailUrl,
      DeliverableStatus status,
      String? rejectionReason,
      String? revisionNotes,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$DeliverableImplCopyWithImpl<$Res>
    extends _$DeliverableCopyWithImpl<$Res, _$DeliverableImpl>
    implements _$$DeliverableImplCopyWith<$Res> {
  __$$DeliverableImplCopyWithImpl(
      _$DeliverableImpl _value, $Res Function(_$DeliverableImpl) _then)
      : super(_value, _then);

  /// Create a copy of Deliverable
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? dealId = null,
    Object? platform = null,
    Object? contentType = null,
    Object? description = freezed,
    Object? contentUrl = freezed,
    Object? thumbnailUrl = freezed,
    Object? status = null,
    Object? rejectionReason = freezed,
    Object? revisionNotes = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$DeliverableImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      dealId: null == dealId
          ? _value.dealId
          : dealId // ignore: cast_nullable_to_non_nullable
              as String,
      platform: null == platform
          ? _value.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as Platform,
      contentType: null == contentType
          ? _value.contentType
          : contentType // ignore: cast_nullable_to_non_nullable
              as ContentType,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      contentUrl: freezed == contentUrl
          ? _value.contentUrl
          : contentUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      thumbnailUrl: freezed == thumbnailUrl
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as DeliverableStatus,
      rejectionReason: freezed == rejectionReason
          ? _value.rejectionReason
          : rejectionReason // ignore: cast_nullable_to_non_nullable
              as String?,
      revisionNotes: freezed == revisionNotes
          ? _value.revisionNotes
          : revisionNotes // ignore: cast_nullable_to_non_nullable
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
class _$DeliverableImpl implements _Deliverable {
  const _$DeliverableImpl(
      {required this.id,
      required this.dealId,
      required this.platform,
      required this.contentType,
      this.description,
      this.contentUrl,
      this.thumbnailUrl,
      this.status = DeliverableStatus.pending,
      this.rejectionReason,
      this.revisionNotes,
      this.createdAt,
      this.updatedAt});

  factory _$DeliverableImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeliverableImplFromJson(json);

  @override
  final String id;
  @override
  final String dealId;
  @override
  final Platform platform;
  @override
  final ContentType contentType;
  @override
  final String? description;
  @override
  final String? contentUrl;
  @override
  final String? thumbnailUrl;
  @override
  @JsonKey()
  final DeliverableStatus status;
  @override
  final String? rejectionReason;
  @override
  final String? revisionNotes;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Deliverable(id: $id, dealId: $dealId, platform: $platform, contentType: $contentType, description: $description, contentUrl: $contentUrl, thumbnailUrl: $thumbnailUrl, status: $status, rejectionReason: $rejectionReason, revisionNotes: $revisionNotes, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeliverableImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.dealId, dealId) || other.dealId == dealId) &&
            (identical(other.platform, platform) ||
                other.platform == platform) &&
            (identical(other.contentType, contentType) ||
                other.contentType == contentType) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.contentUrl, contentUrl) ||
                other.contentUrl == contentUrl) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                other.thumbnailUrl == thumbnailUrl) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.rejectionReason, rejectionReason) ||
                other.rejectionReason == rejectionReason) &&
            (identical(other.revisionNotes, revisionNotes) ||
                other.revisionNotes == revisionNotes) &&
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
      dealId,
      platform,
      contentType,
      description,
      contentUrl,
      thumbnailUrl,
      status,
      rejectionReason,
      revisionNotes,
      createdAt,
      updatedAt);

  /// Create a copy of Deliverable
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeliverableImplCopyWith<_$DeliverableImpl> get copyWith =>
      __$$DeliverableImplCopyWithImpl<_$DeliverableImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeliverableImplToJson(
      this,
    );
  }
}

abstract class _Deliverable implements Deliverable {
  const factory _Deliverable(
      {required final String id,
      required final String dealId,
      required final Platform platform,
      required final ContentType contentType,
      final String? description,
      final String? contentUrl,
      final String? thumbnailUrl,
      final DeliverableStatus status,
      final String? rejectionReason,
      final String? revisionNotes,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$DeliverableImpl;

  factory _Deliverable.fromJson(Map<String, dynamic> json) =
      _$DeliverableImpl.fromJson;

  @override
  String get id;
  @override
  String get dealId;
  @override
  Platform get platform;
  @override
  ContentType get contentType;
  @override
  String? get description;
  @override
  String? get contentUrl;
  @override
  String? get thumbnailUrl;
  @override
  DeliverableStatus get status;
  @override
  String? get rejectionReason;
  @override
  String? get revisionNotes;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of Deliverable
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeliverableImplCopyWith<_$DeliverableImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SubmitDeliverableRequest _$SubmitDeliverableRequestFromJson(
    Map<String, dynamic> json) {
  return _SubmitDeliverableRequest.fromJson(json);
}

/// @nodoc
mixin _$SubmitDeliverableRequest {
  String get contentUrl => throw _privateConstructorUsedError;
  String? get thumbnailUrl => throw _privateConstructorUsedError;

  /// Serializes this SubmitDeliverableRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SubmitDeliverableRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubmitDeliverableRequestCopyWith<SubmitDeliverableRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubmitDeliverableRequestCopyWith<$Res> {
  factory $SubmitDeliverableRequestCopyWith(SubmitDeliverableRequest value,
          $Res Function(SubmitDeliverableRequest) then) =
      _$SubmitDeliverableRequestCopyWithImpl<$Res, SubmitDeliverableRequest>;
  @useResult
  $Res call({String contentUrl, String? thumbnailUrl});
}

/// @nodoc
class _$SubmitDeliverableRequestCopyWithImpl<$Res,
        $Val extends SubmitDeliverableRequest>
    implements $SubmitDeliverableRequestCopyWith<$Res> {
  _$SubmitDeliverableRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubmitDeliverableRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contentUrl = null,
    Object? thumbnailUrl = freezed,
  }) {
    return _then(_value.copyWith(
      contentUrl: null == contentUrl
          ? _value.contentUrl
          : contentUrl // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnailUrl: freezed == thumbnailUrl
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SubmitDeliverableRequestImplCopyWith<$Res>
    implements $SubmitDeliverableRequestCopyWith<$Res> {
  factory _$$SubmitDeliverableRequestImplCopyWith(
          _$SubmitDeliverableRequestImpl value,
          $Res Function(_$SubmitDeliverableRequestImpl) then) =
      __$$SubmitDeliverableRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String contentUrl, String? thumbnailUrl});
}

/// @nodoc
class __$$SubmitDeliverableRequestImplCopyWithImpl<$Res>
    extends _$SubmitDeliverableRequestCopyWithImpl<$Res,
        _$SubmitDeliverableRequestImpl>
    implements _$$SubmitDeliverableRequestImplCopyWith<$Res> {
  __$$SubmitDeliverableRequestImplCopyWithImpl(
      _$SubmitDeliverableRequestImpl _value,
      $Res Function(_$SubmitDeliverableRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of SubmitDeliverableRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contentUrl = null,
    Object? thumbnailUrl = freezed,
  }) {
    return _then(_$SubmitDeliverableRequestImpl(
      contentUrl: null == contentUrl
          ? _value.contentUrl
          : contentUrl // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnailUrl: freezed == thumbnailUrl
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SubmitDeliverableRequestImpl implements _SubmitDeliverableRequest {
  const _$SubmitDeliverableRequestImpl(
      {required this.contentUrl, this.thumbnailUrl});

  factory _$SubmitDeliverableRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubmitDeliverableRequestImplFromJson(json);

  @override
  final String contentUrl;
  @override
  final String? thumbnailUrl;

  @override
  String toString() {
    return 'SubmitDeliverableRequest(contentUrl: $contentUrl, thumbnailUrl: $thumbnailUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubmitDeliverableRequestImpl &&
            (identical(other.contentUrl, contentUrl) ||
                other.contentUrl == contentUrl) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                other.thumbnailUrl == thumbnailUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, contentUrl, thumbnailUrl);

  /// Create a copy of SubmitDeliverableRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubmitDeliverableRequestImplCopyWith<_$SubmitDeliverableRequestImpl>
      get copyWith => __$$SubmitDeliverableRequestImplCopyWithImpl<
          _$SubmitDeliverableRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SubmitDeliverableRequestImplToJson(
      this,
    );
  }
}

abstract class _SubmitDeliverableRequest implements SubmitDeliverableRequest {
  const factory _SubmitDeliverableRequest(
      {required final String contentUrl,
      final String? thumbnailUrl}) = _$SubmitDeliverableRequestImpl;

  factory _SubmitDeliverableRequest.fromJson(Map<String, dynamic> json) =
      _$SubmitDeliverableRequestImpl.fromJson;

  @override
  String get contentUrl;
  @override
  String? get thumbnailUrl;

  /// Create a copy of SubmitDeliverableRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubmitDeliverableRequestImplCopyWith<_$SubmitDeliverableRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

RejectDeliverableRequest _$RejectDeliverableRequestFromJson(
    Map<String, dynamic> json) {
  return _RejectDeliverableRequest.fromJson(json);
}

/// @nodoc
mixin _$RejectDeliverableRequest {
  String get reason => throw _privateConstructorUsedError;
  String? get revisionNotes => throw _privateConstructorUsedError;

  /// Serializes this RejectDeliverableRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RejectDeliverableRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RejectDeliverableRequestCopyWith<RejectDeliverableRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RejectDeliverableRequestCopyWith<$Res> {
  factory $RejectDeliverableRequestCopyWith(RejectDeliverableRequest value,
          $Res Function(RejectDeliverableRequest) then) =
      _$RejectDeliverableRequestCopyWithImpl<$Res, RejectDeliverableRequest>;
  @useResult
  $Res call({String reason, String? revisionNotes});
}

/// @nodoc
class _$RejectDeliverableRequestCopyWithImpl<$Res,
        $Val extends RejectDeliverableRequest>
    implements $RejectDeliverableRequestCopyWith<$Res> {
  _$RejectDeliverableRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RejectDeliverableRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reason = null,
    Object? revisionNotes = freezed,
  }) {
    return _then(_value.copyWith(
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
      revisionNotes: freezed == revisionNotes
          ? _value.revisionNotes
          : revisionNotes // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RejectDeliverableRequestImplCopyWith<$Res>
    implements $RejectDeliverableRequestCopyWith<$Res> {
  factory _$$RejectDeliverableRequestImplCopyWith(
          _$RejectDeliverableRequestImpl value,
          $Res Function(_$RejectDeliverableRequestImpl) then) =
      __$$RejectDeliverableRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String reason, String? revisionNotes});
}

/// @nodoc
class __$$RejectDeliverableRequestImplCopyWithImpl<$Res>
    extends _$RejectDeliverableRequestCopyWithImpl<$Res,
        _$RejectDeliverableRequestImpl>
    implements _$$RejectDeliverableRequestImplCopyWith<$Res> {
  __$$RejectDeliverableRequestImplCopyWithImpl(
      _$RejectDeliverableRequestImpl _value,
      $Res Function(_$RejectDeliverableRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of RejectDeliverableRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reason = null,
    Object? revisionNotes = freezed,
  }) {
    return _then(_$RejectDeliverableRequestImpl(
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
      revisionNotes: freezed == revisionNotes
          ? _value.revisionNotes
          : revisionNotes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RejectDeliverableRequestImpl implements _RejectDeliverableRequest {
  const _$RejectDeliverableRequestImpl(
      {required this.reason, this.revisionNotes});

  factory _$RejectDeliverableRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$RejectDeliverableRequestImplFromJson(json);

  @override
  final String reason;
  @override
  final String? revisionNotes;

  @override
  String toString() {
    return 'RejectDeliverableRequest(reason: $reason, revisionNotes: $revisionNotes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RejectDeliverableRequestImpl &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.revisionNotes, revisionNotes) ||
                other.revisionNotes == revisionNotes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, reason, revisionNotes);

  /// Create a copy of RejectDeliverableRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RejectDeliverableRequestImplCopyWith<_$RejectDeliverableRequestImpl>
      get copyWith => __$$RejectDeliverableRequestImplCopyWithImpl<
          _$RejectDeliverableRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RejectDeliverableRequestImplToJson(
      this,
    );
  }
}

abstract class _RejectDeliverableRequest implements RejectDeliverableRequest {
  const factory _RejectDeliverableRequest(
      {required final String reason,
      final String? revisionNotes}) = _$RejectDeliverableRequestImpl;

  factory _RejectDeliverableRequest.fromJson(Map<String, dynamic> json) =
      _$RejectDeliverableRequestImpl.fromJson;

  @override
  String get reason;
  @override
  String? get revisionNotes;

  /// Create a copy of RejectDeliverableRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RejectDeliverableRequestImplCopyWith<_$RejectDeliverableRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
