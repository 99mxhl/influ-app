// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'file_upload.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PresignRequest _$PresignRequestFromJson(Map<String, dynamic> json) {
  return _PresignRequest.fromJson(json);
}

/// @nodoc
mixin _$PresignRequest {
  String get fileName => throw _privateConstructorUsedError;
  String get contentType => throw _privateConstructorUsedError;
  FileType? get type => throw _privateConstructorUsedError;

  /// Serializes this PresignRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PresignRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PresignRequestCopyWith<PresignRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PresignRequestCopyWith<$Res> {
  factory $PresignRequestCopyWith(
          PresignRequest value, $Res Function(PresignRequest) then) =
      _$PresignRequestCopyWithImpl<$Res, PresignRequest>;
  @useResult
  $Res call({String fileName, String contentType, FileType? type});
}

/// @nodoc
class _$PresignRequestCopyWithImpl<$Res, $Val extends PresignRequest>
    implements $PresignRequestCopyWith<$Res> {
  _$PresignRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PresignRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fileName = null,
    Object? contentType = null,
    Object? type = freezed,
  }) {
    return _then(_value.copyWith(
      fileName: null == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String,
      contentType: null == contentType
          ? _value.contentType
          : contentType // ignore: cast_nullable_to_non_nullable
              as String,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as FileType?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PresignRequestImplCopyWith<$Res>
    implements $PresignRequestCopyWith<$Res> {
  factory _$$PresignRequestImplCopyWith(_$PresignRequestImpl value,
          $Res Function(_$PresignRequestImpl) then) =
      __$$PresignRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String fileName, String contentType, FileType? type});
}

/// @nodoc
class __$$PresignRequestImplCopyWithImpl<$Res>
    extends _$PresignRequestCopyWithImpl<$Res, _$PresignRequestImpl>
    implements _$$PresignRequestImplCopyWith<$Res> {
  __$$PresignRequestImplCopyWithImpl(
      _$PresignRequestImpl _value, $Res Function(_$PresignRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of PresignRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fileName = null,
    Object? contentType = null,
    Object? type = freezed,
  }) {
    return _then(_$PresignRequestImpl(
      fileName: null == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String,
      contentType: null == contentType
          ? _value.contentType
          : contentType // ignore: cast_nullable_to_non_nullable
              as String,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as FileType?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PresignRequestImpl implements _PresignRequest {
  const _$PresignRequestImpl(
      {required this.fileName, required this.contentType, this.type});

  factory _$PresignRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$PresignRequestImplFromJson(json);

  @override
  final String fileName;
  @override
  final String contentType;
  @override
  final FileType? type;

  @override
  String toString() {
    return 'PresignRequest(fileName: $fileName, contentType: $contentType, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PresignRequestImpl &&
            (identical(other.fileName, fileName) ||
                other.fileName == fileName) &&
            (identical(other.contentType, contentType) ||
                other.contentType == contentType) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, fileName, contentType, type);

  /// Create a copy of PresignRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PresignRequestImplCopyWith<_$PresignRequestImpl> get copyWith =>
      __$$PresignRequestImplCopyWithImpl<_$PresignRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PresignRequestImplToJson(
      this,
    );
  }
}

abstract class _PresignRequest implements PresignRequest {
  const factory _PresignRequest(
      {required final String fileName,
      required final String contentType,
      final FileType? type}) = _$PresignRequestImpl;

  factory _PresignRequest.fromJson(Map<String, dynamic> json) =
      _$PresignRequestImpl.fromJson;

  @override
  String get fileName;
  @override
  String get contentType;
  @override
  FileType? get type;

  /// Create a copy of PresignRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PresignRequestImplCopyWith<_$PresignRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PresignResponse _$PresignResponseFromJson(Map<String, dynamic> json) {
  return _PresignResponse.fromJson(json);
}

/// @nodoc
mixin _$PresignResponse {
  String get uploadUrl => throw _privateConstructorUsedError;
  String get fileKey => throw _privateConstructorUsedError;
  String get publicUrl => throw _privateConstructorUsedError;

  /// Serializes this PresignResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PresignResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PresignResponseCopyWith<PresignResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PresignResponseCopyWith<$Res> {
  factory $PresignResponseCopyWith(
          PresignResponse value, $Res Function(PresignResponse) then) =
      _$PresignResponseCopyWithImpl<$Res, PresignResponse>;
  @useResult
  $Res call({String uploadUrl, String fileKey, String publicUrl});
}

/// @nodoc
class _$PresignResponseCopyWithImpl<$Res, $Val extends PresignResponse>
    implements $PresignResponseCopyWith<$Res> {
  _$PresignResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PresignResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uploadUrl = null,
    Object? fileKey = null,
    Object? publicUrl = null,
  }) {
    return _then(_value.copyWith(
      uploadUrl: null == uploadUrl
          ? _value.uploadUrl
          : uploadUrl // ignore: cast_nullable_to_non_nullable
              as String,
      fileKey: null == fileKey
          ? _value.fileKey
          : fileKey // ignore: cast_nullable_to_non_nullable
              as String,
      publicUrl: null == publicUrl
          ? _value.publicUrl
          : publicUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PresignResponseImplCopyWith<$Res>
    implements $PresignResponseCopyWith<$Res> {
  factory _$$PresignResponseImplCopyWith(_$PresignResponseImpl value,
          $Res Function(_$PresignResponseImpl) then) =
      __$$PresignResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String uploadUrl, String fileKey, String publicUrl});
}

/// @nodoc
class __$$PresignResponseImplCopyWithImpl<$Res>
    extends _$PresignResponseCopyWithImpl<$Res, _$PresignResponseImpl>
    implements _$$PresignResponseImplCopyWith<$Res> {
  __$$PresignResponseImplCopyWithImpl(
      _$PresignResponseImpl _value, $Res Function(_$PresignResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of PresignResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uploadUrl = null,
    Object? fileKey = null,
    Object? publicUrl = null,
  }) {
    return _then(_$PresignResponseImpl(
      uploadUrl: null == uploadUrl
          ? _value.uploadUrl
          : uploadUrl // ignore: cast_nullable_to_non_nullable
              as String,
      fileKey: null == fileKey
          ? _value.fileKey
          : fileKey // ignore: cast_nullable_to_non_nullable
              as String,
      publicUrl: null == publicUrl
          ? _value.publicUrl
          : publicUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PresignResponseImpl implements _PresignResponse {
  const _$PresignResponseImpl(
      {required this.uploadUrl,
      required this.fileKey,
      required this.publicUrl});

  factory _$PresignResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PresignResponseImplFromJson(json);

  @override
  final String uploadUrl;
  @override
  final String fileKey;
  @override
  final String publicUrl;

  @override
  String toString() {
    return 'PresignResponse(uploadUrl: $uploadUrl, fileKey: $fileKey, publicUrl: $publicUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PresignResponseImpl &&
            (identical(other.uploadUrl, uploadUrl) ||
                other.uploadUrl == uploadUrl) &&
            (identical(other.fileKey, fileKey) || other.fileKey == fileKey) &&
            (identical(other.publicUrl, publicUrl) ||
                other.publicUrl == publicUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, uploadUrl, fileKey, publicUrl);

  /// Create a copy of PresignResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PresignResponseImplCopyWith<_$PresignResponseImpl> get copyWith =>
      __$$PresignResponseImplCopyWithImpl<_$PresignResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PresignResponseImplToJson(
      this,
    );
  }
}

abstract class _PresignResponse implements PresignResponse {
  const factory _PresignResponse(
      {required final String uploadUrl,
      required final String fileKey,
      required final String publicUrl}) = _$PresignResponseImpl;

  factory _PresignResponse.fromJson(Map<String, dynamic> json) =
      _$PresignResponseImpl.fromJson;

  @override
  String get uploadUrl;
  @override
  String get fileKey;
  @override
  String get publicUrl;

  /// Create a copy of PresignResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PresignResponseImplCopyWith<_$PresignResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
