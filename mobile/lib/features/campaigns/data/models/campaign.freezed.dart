// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'campaign.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Campaign _$CampaignFromJson(Map<String, dynamic> json) {
  return _Campaign.fromJson(json);
}

/// @nodoc
mixin _$Campaign {
  String get id => throw _privateConstructorUsedError;
  String get clientId => throw _privateConstructorUsedError;
  String? get clientDisplayName => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  double get budgetMin => throw _privateConstructorUsedError;
  double get budgetMax => throw _privateConstructorUsedError;
  CampaignStatus get status => throw _privateConstructorUsedError;
  List<String> get categories => throw _privateConstructorUsedError;
  List<Platform> get platforms => throw _privateConstructorUsedError;
  DateTime? get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  String? get requirements => throw _privateConstructorUsedError;
  String? get targetAudience => throw _privateConstructorUsedError;
  int get applicantCount => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Campaign to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Campaign
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CampaignCopyWith<Campaign> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CampaignCopyWith<$Res> {
  factory $CampaignCopyWith(Campaign value, $Res Function(Campaign) then) =
      _$CampaignCopyWithImpl<$Res, Campaign>;
  @useResult
  $Res call(
      {String id,
      String clientId,
      String? clientDisplayName,
      String title,
      String? description,
      double budgetMin,
      double budgetMax,
      CampaignStatus status,
      List<String> categories,
      List<Platform> platforms,
      DateTime? startDate,
      DateTime? endDate,
      String? imageUrl,
      String? requirements,
      String? targetAudience,
      int applicantCount,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$CampaignCopyWithImpl<$Res, $Val extends Campaign>
    implements $CampaignCopyWith<$Res> {
  _$CampaignCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Campaign
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? clientId = null,
    Object? clientDisplayName = freezed,
    Object? title = null,
    Object? description = freezed,
    Object? budgetMin = null,
    Object? budgetMax = null,
    Object? status = null,
    Object? categories = null,
    Object? platforms = null,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? imageUrl = freezed,
    Object? requirements = freezed,
    Object? targetAudience = freezed,
    Object? applicantCount = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      clientDisplayName: freezed == clientDisplayName
          ? _value.clientDisplayName
          : clientDisplayName // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      budgetMin: null == budgetMin
          ? _value.budgetMin
          : budgetMin // ignore: cast_nullable_to_non_nullable
              as double,
      budgetMax: null == budgetMax
          ? _value.budgetMax
          : budgetMax // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CampaignStatus,
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      platforms: null == platforms
          ? _value.platforms
          : platforms // ignore: cast_nullable_to_non_nullable
              as List<Platform>,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      requirements: freezed == requirements
          ? _value.requirements
          : requirements // ignore: cast_nullable_to_non_nullable
              as String?,
      targetAudience: freezed == targetAudience
          ? _value.targetAudience
          : targetAudience // ignore: cast_nullable_to_non_nullable
              as String?,
      applicantCount: null == applicantCount
          ? _value.applicantCount
          : applicantCount // ignore: cast_nullable_to_non_nullable
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
abstract class _$$CampaignImplCopyWith<$Res>
    implements $CampaignCopyWith<$Res> {
  factory _$$CampaignImplCopyWith(
          _$CampaignImpl value, $Res Function(_$CampaignImpl) then) =
      __$$CampaignImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String clientId,
      String? clientDisplayName,
      String title,
      String? description,
      double budgetMin,
      double budgetMax,
      CampaignStatus status,
      List<String> categories,
      List<Platform> platforms,
      DateTime? startDate,
      DateTime? endDate,
      String? imageUrl,
      String? requirements,
      String? targetAudience,
      int applicantCount,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$CampaignImplCopyWithImpl<$Res>
    extends _$CampaignCopyWithImpl<$Res, _$CampaignImpl>
    implements _$$CampaignImplCopyWith<$Res> {
  __$$CampaignImplCopyWithImpl(
      _$CampaignImpl _value, $Res Function(_$CampaignImpl) _then)
      : super(_value, _then);

  /// Create a copy of Campaign
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? clientId = null,
    Object? clientDisplayName = freezed,
    Object? title = null,
    Object? description = freezed,
    Object? budgetMin = null,
    Object? budgetMax = null,
    Object? status = null,
    Object? categories = null,
    Object? platforms = null,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? imageUrl = freezed,
    Object? requirements = freezed,
    Object? targetAudience = freezed,
    Object? applicantCount = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$CampaignImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      clientDisplayName: freezed == clientDisplayName
          ? _value.clientDisplayName
          : clientDisplayName // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      budgetMin: null == budgetMin
          ? _value.budgetMin
          : budgetMin // ignore: cast_nullable_to_non_nullable
              as double,
      budgetMax: null == budgetMax
          ? _value.budgetMax
          : budgetMax // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CampaignStatus,
      categories: null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      platforms: null == platforms
          ? _value._platforms
          : platforms // ignore: cast_nullable_to_non_nullable
              as List<Platform>,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      requirements: freezed == requirements
          ? _value.requirements
          : requirements // ignore: cast_nullable_to_non_nullable
              as String?,
      targetAudience: freezed == targetAudience
          ? _value.targetAudience
          : targetAudience // ignore: cast_nullable_to_non_nullable
              as String?,
      applicantCount: null == applicantCount
          ? _value.applicantCount
          : applicantCount // ignore: cast_nullable_to_non_nullable
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
class _$CampaignImpl extends _Campaign {
  const _$CampaignImpl(
      {required this.id,
      required this.clientId,
      this.clientDisplayName,
      required this.title,
      this.description,
      required this.budgetMin,
      required this.budgetMax,
      required this.status,
      final List<String> categories = const [],
      final List<Platform> platforms = const [],
      this.startDate,
      this.endDate,
      this.imageUrl,
      this.requirements,
      this.targetAudience,
      this.applicantCount = 0,
      this.createdAt,
      this.updatedAt})
      : _categories = categories,
        _platforms = platforms,
        super._();

  factory _$CampaignImpl.fromJson(Map<String, dynamic> json) =>
      _$$CampaignImplFromJson(json);

  @override
  final String id;
  @override
  final String clientId;
  @override
  final String? clientDisplayName;
  @override
  final String title;
  @override
  final String? description;
  @override
  final double budgetMin;
  @override
  final double budgetMax;
  @override
  final CampaignStatus status;
  final List<String> _categories;
  @override
  @JsonKey()
  List<String> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  final List<Platform> _platforms;
  @override
  @JsonKey()
  List<Platform> get platforms {
    if (_platforms is EqualUnmodifiableListView) return _platforms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_platforms);
  }

  @override
  final DateTime? startDate;
  @override
  final DateTime? endDate;
  @override
  final String? imageUrl;
  @override
  final String? requirements;
  @override
  final String? targetAudience;
  @override
  @JsonKey()
  final int applicantCount;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Campaign(id: $id, clientId: $clientId, clientDisplayName: $clientDisplayName, title: $title, description: $description, budgetMin: $budgetMin, budgetMax: $budgetMax, status: $status, categories: $categories, platforms: $platforms, startDate: $startDate, endDate: $endDate, imageUrl: $imageUrl, requirements: $requirements, targetAudience: $targetAudience, applicantCount: $applicantCount, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CampaignImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.clientDisplayName, clientDisplayName) ||
                other.clientDisplayName == clientDisplayName) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.budgetMin, budgetMin) ||
                other.budgetMin == budgetMin) &&
            (identical(other.budgetMax, budgetMax) ||
                other.budgetMax == budgetMax) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            const DeepCollectionEquality()
                .equals(other._platforms, _platforms) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.requirements, requirements) ||
                other.requirements == requirements) &&
            (identical(other.targetAudience, targetAudience) ||
                other.targetAudience == targetAudience) &&
            (identical(other.applicantCount, applicantCount) ||
                other.applicantCount == applicantCount) &&
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
      clientId,
      clientDisplayName,
      title,
      description,
      budgetMin,
      budgetMax,
      status,
      const DeepCollectionEquality().hash(_categories),
      const DeepCollectionEquality().hash(_platforms),
      startDate,
      endDate,
      imageUrl,
      requirements,
      targetAudience,
      applicantCount,
      createdAt,
      updatedAt);

  /// Create a copy of Campaign
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CampaignImplCopyWith<_$CampaignImpl> get copyWith =>
      __$$CampaignImplCopyWithImpl<_$CampaignImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CampaignImplToJson(
      this,
    );
  }
}

abstract class _Campaign extends Campaign {
  const factory _Campaign(
      {required final String id,
      required final String clientId,
      final String? clientDisplayName,
      required final String title,
      final String? description,
      required final double budgetMin,
      required final double budgetMax,
      required final CampaignStatus status,
      final List<String> categories,
      final List<Platform> platforms,
      final DateTime? startDate,
      final DateTime? endDate,
      final String? imageUrl,
      final String? requirements,
      final String? targetAudience,
      final int applicantCount,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$CampaignImpl;
  const _Campaign._() : super._();

  factory _Campaign.fromJson(Map<String, dynamic> json) =
      _$CampaignImpl.fromJson;

  @override
  String get id;
  @override
  String get clientId;
  @override
  String? get clientDisplayName;
  @override
  String get title;
  @override
  String? get description;
  @override
  double get budgetMin;
  @override
  double get budgetMax;
  @override
  CampaignStatus get status;
  @override
  List<String> get categories;
  @override
  List<Platform> get platforms;
  @override
  DateTime? get startDate;
  @override
  DateTime? get endDate;
  @override
  String? get imageUrl;
  @override
  String? get requirements;
  @override
  String? get targetAudience;
  @override
  int get applicantCount;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of Campaign
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CampaignImplCopyWith<_$CampaignImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreateCampaignRequest _$CreateCampaignRequestFromJson(
    Map<String, dynamic> json) {
  return _CreateCampaignRequest.fromJson(json);
}

/// @nodoc
mixin _$CreateCampaignRequest {
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  double get budgetMin => throw _privateConstructorUsedError;
  double get budgetMax => throw _privateConstructorUsedError;
  List<String> get categories => throw _privateConstructorUsedError;
  List<Platform> get platforms => throw _privateConstructorUsedError;
  DateTime? get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;

  /// Serializes this CreateCampaignRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateCampaignRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateCampaignRequestCopyWith<CreateCampaignRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateCampaignRequestCopyWith<$Res> {
  factory $CreateCampaignRequestCopyWith(CreateCampaignRequest value,
          $Res Function(CreateCampaignRequest) then) =
      _$CreateCampaignRequestCopyWithImpl<$Res, CreateCampaignRequest>;
  @useResult
  $Res call(
      {String title,
      String? description,
      double budgetMin,
      double budgetMax,
      List<String> categories,
      List<Platform> platforms,
      DateTime? startDate,
      DateTime? endDate});
}

/// @nodoc
class _$CreateCampaignRequestCopyWithImpl<$Res,
        $Val extends CreateCampaignRequest>
    implements $CreateCampaignRequestCopyWith<$Res> {
  _$CreateCampaignRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateCampaignRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = freezed,
    Object? budgetMin = null,
    Object? budgetMax = null,
    Object? categories = null,
    Object? platforms = null,
    Object? startDate = freezed,
    Object? endDate = freezed,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      budgetMin: null == budgetMin
          ? _value.budgetMin
          : budgetMin // ignore: cast_nullable_to_non_nullable
              as double,
      budgetMax: null == budgetMax
          ? _value.budgetMax
          : budgetMax // ignore: cast_nullable_to_non_nullable
              as double,
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      platforms: null == platforms
          ? _value.platforms
          : platforms // ignore: cast_nullable_to_non_nullable
              as List<Platform>,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateCampaignRequestImplCopyWith<$Res>
    implements $CreateCampaignRequestCopyWith<$Res> {
  factory _$$CreateCampaignRequestImplCopyWith(
          _$CreateCampaignRequestImpl value,
          $Res Function(_$CreateCampaignRequestImpl) then) =
      __$$CreateCampaignRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String? description,
      double budgetMin,
      double budgetMax,
      List<String> categories,
      List<Platform> platforms,
      DateTime? startDate,
      DateTime? endDate});
}

/// @nodoc
class __$$CreateCampaignRequestImplCopyWithImpl<$Res>
    extends _$CreateCampaignRequestCopyWithImpl<$Res,
        _$CreateCampaignRequestImpl>
    implements _$$CreateCampaignRequestImplCopyWith<$Res> {
  __$$CreateCampaignRequestImplCopyWithImpl(_$CreateCampaignRequestImpl _value,
      $Res Function(_$CreateCampaignRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateCampaignRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = freezed,
    Object? budgetMin = null,
    Object? budgetMax = null,
    Object? categories = null,
    Object? platforms = null,
    Object? startDate = freezed,
    Object? endDate = freezed,
  }) {
    return _then(_$CreateCampaignRequestImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      budgetMin: null == budgetMin
          ? _value.budgetMin
          : budgetMin // ignore: cast_nullable_to_non_nullable
              as double,
      budgetMax: null == budgetMax
          ? _value.budgetMax
          : budgetMax // ignore: cast_nullable_to_non_nullable
              as double,
      categories: null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      platforms: null == platforms
          ? _value._platforms
          : platforms // ignore: cast_nullable_to_non_nullable
              as List<Platform>,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateCampaignRequestImpl implements _CreateCampaignRequest {
  const _$CreateCampaignRequestImpl(
      {required this.title,
      this.description,
      required this.budgetMin,
      required this.budgetMax,
      final List<String> categories = const [],
      final List<Platform> platforms = const [],
      this.startDate,
      this.endDate})
      : _categories = categories,
        _platforms = platforms;

  factory _$CreateCampaignRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateCampaignRequestImplFromJson(json);

  @override
  final String title;
  @override
  final String? description;
  @override
  final double budgetMin;
  @override
  final double budgetMax;
  final List<String> _categories;
  @override
  @JsonKey()
  List<String> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  final List<Platform> _platforms;
  @override
  @JsonKey()
  List<Platform> get platforms {
    if (_platforms is EqualUnmodifiableListView) return _platforms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_platforms);
  }

  @override
  final DateTime? startDate;
  @override
  final DateTime? endDate;

  @override
  String toString() {
    return 'CreateCampaignRequest(title: $title, description: $description, budgetMin: $budgetMin, budgetMax: $budgetMax, categories: $categories, platforms: $platforms, startDate: $startDate, endDate: $endDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateCampaignRequestImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.budgetMin, budgetMin) ||
                other.budgetMin == budgetMin) &&
            (identical(other.budgetMax, budgetMax) ||
                other.budgetMax == budgetMax) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            const DeepCollectionEquality()
                .equals(other._platforms, _platforms) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      description,
      budgetMin,
      budgetMax,
      const DeepCollectionEquality().hash(_categories),
      const DeepCollectionEquality().hash(_platforms),
      startDate,
      endDate);

  /// Create a copy of CreateCampaignRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateCampaignRequestImplCopyWith<_$CreateCampaignRequestImpl>
      get copyWith => __$$CreateCampaignRequestImplCopyWithImpl<
          _$CreateCampaignRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateCampaignRequestImplToJson(
      this,
    );
  }
}

abstract class _CreateCampaignRequest implements CreateCampaignRequest {
  const factory _CreateCampaignRequest(
      {required final String title,
      final String? description,
      required final double budgetMin,
      required final double budgetMax,
      final List<String> categories,
      final List<Platform> platforms,
      final DateTime? startDate,
      final DateTime? endDate}) = _$CreateCampaignRequestImpl;

  factory _CreateCampaignRequest.fromJson(Map<String, dynamic> json) =
      _$CreateCampaignRequestImpl.fromJson;

  @override
  String get title;
  @override
  String? get description;
  @override
  double get budgetMin;
  @override
  double get budgetMax;
  @override
  List<String> get categories;
  @override
  List<Platform> get platforms;
  @override
  DateTime? get startDate;
  @override
  DateTime? get endDate;

  /// Create a copy of CreateCampaignRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateCampaignRequestImplCopyWith<_$CreateCampaignRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

UpdateCampaignRequest _$UpdateCampaignRequestFromJson(
    Map<String, dynamic> json) {
  return _UpdateCampaignRequest.fromJson(json);
}

/// @nodoc
mixin _$UpdateCampaignRequest {
  String? get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  double? get budgetMin => throw _privateConstructorUsedError;
  double? get budgetMax => throw _privateConstructorUsedError;
  CampaignStatus? get status => throw _privateConstructorUsedError;
  List<String>? get categories => throw _privateConstructorUsedError;
  List<Platform>? get platforms => throw _privateConstructorUsedError;
  DateTime? get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;

  /// Serializes this UpdateCampaignRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdateCampaignRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdateCampaignRequestCopyWith<UpdateCampaignRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateCampaignRequestCopyWith<$Res> {
  factory $UpdateCampaignRequestCopyWith(UpdateCampaignRequest value,
          $Res Function(UpdateCampaignRequest) then) =
      _$UpdateCampaignRequestCopyWithImpl<$Res, UpdateCampaignRequest>;
  @useResult
  $Res call(
      {String? title,
      String? description,
      double? budgetMin,
      double? budgetMax,
      CampaignStatus? status,
      List<String>? categories,
      List<Platform>? platforms,
      DateTime? startDate,
      DateTime? endDate});
}

/// @nodoc
class _$UpdateCampaignRequestCopyWithImpl<$Res,
        $Val extends UpdateCampaignRequest>
    implements $UpdateCampaignRequestCopyWith<$Res> {
  _$UpdateCampaignRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdateCampaignRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? description = freezed,
    Object? budgetMin = freezed,
    Object? budgetMax = freezed,
    Object? status = freezed,
    Object? categories = freezed,
    Object? platforms = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
  }) {
    return _then(_value.copyWith(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      budgetMin: freezed == budgetMin
          ? _value.budgetMin
          : budgetMin // ignore: cast_nullable_to_non_nullable
              as double?,
      budgetMax: freezed == budgetMax
          ? _value.budgetMax
          : budgetMax // ignore: cast_nullable_to_non_nullable
              as double?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CampaignStatus?,
      categories: freezed == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      platforms: freezed == platforms
          ? _value.platforms
          : platforms // ignore: cast_nullable_to_non_nullable
              as List<Platform>?,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UpdateCampaignRequestImplCopyWith<$Res>
    implements $UpdateCampaignRequestCopyWith<$Res> {
  factory _$$UpdateCampaignRequestImplCopyWith(
          _$UpdateCampaignRequestImpl value,
          $Res Function(_$UpdateCampaignRequestImpl) then) =
      __$$UpdateCampaignRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? title,
      String? description,
      double? budgetMin,
      double? budgetMax,
      CampaignStatus? status,
      List<String>? categories,
      List<Platform>? platforms,
      DateTime? startDate,
      DateTime? endDate});
}

/// @nodoc
class __$$UpdateCampaignRequestImplCopyWithImpl<$Res>
    extends _$UpdateCampaignRequestCopyWithImpl<$Res,
        _$UpdateCampaignRequestImpl>
    implements _$$UpdateCampaignRequestImplCopyWith<$Res> {
  __$$UpdateCampaignRequestImplCopyWithImpl(_$UpdateCampaignRequestImpl _value,
      $Res Function(_$UpdateCampaignRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of UpdateCampaignRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? description = freezed,
    Object? budgetMin = freezed,
    Object? budgetMax = freezed,
    Object? status = freezed,
    Object? categories = freezed,
    Object? platforms = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
  }) {
    return _then(_$UpdateCampaignRequestImpl(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      budgetMin: freezed == budgetMin
          ? _value.budgetMin
          : budgetMin // ignore: cast_nullable_to_non_nullable
              as double?,
      budgetMax: freezed == budgetMax
          ? _value.budgetMax
          : budgetMax // ignore: cast_nullable_to_non_nullable
              as double?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CampaignStatus?,
      categories: freezed == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      platforms: freezed == platforms
          ? _value._platforms
          : platforms // ignore: cast_nullable_to_non_nullable
              as List<Platform>?,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateCampaignRequestImpl implements _UpdateCampaignRequest {
  const _$UpdateCampaignRequestImpl(
      {this.title,
      this.description,
      this.budgetMin,
      this.budgetMax,
      this.status,
      final List<String>? categories,
      final List<Platform>? platforms,
      this.startDate,
      this.endDate})
      : _categories = categories,
        _platforms = platforms;

  factory _$UpdateCampaignRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateCampaignRequestImplFromJson(json);

  @override
  final String? title;
  @override
  final String? description;
  @override
  final double? budgetMin;
  @override
  final double? budgetMax;
  @override
  final CampaignStatus? status;
  final List<String>? _categories;
  @override
  List<String>? get categories {
    final value = _categories;
    if (value == null) return null;
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<Platform>? _platforms;
  @override
  List<Platform>? get platforms {
    final value = _platforms;
    if (value == null) return null;
    if (_platforms is EqualUnmodifiableListView) return _platforms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final DateTime? startDate;
  @override
  final DateTime? endDate;

  @override
  String toString() {
    return 'UpdateCampaignRequest(title: $title, description: $description, budgetMin: $budgetMin, budgetMax: $budgetMax, status: $status, categories: $categories, platforms: $platforms, startDate: $startDate, endDate: $endDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateCampaignRequestImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.budgetMin, budgetMin) ||
                other.budgetMin == budgetMin) &&
            (identical(other.budgetMax, budgetMax) ||
                other.budgetMax == budgetMax) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            const DeepCollectionEquality()
                .equals(other._platforms, _platforms) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      description,
      budgetMin,
      budgetMax,
      status,
      const DeepCollectionEquality().hash(_categories),
      const DeepCollectionEquality().hash(_platforms),
      startDate,
      endDate);

  /// Create a copy of UpdateCampaignRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateCampaignRequestImplCopyWith<_$UpdateCampaignRequestImpl>
      get copyWith => __$$UpdateCampaignRequestImplCopyWithImpl<
          _$UpdateCampaignRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateCampaignRequestImplToJson(
      this,
    );
  }
}

abstract class _UpdateCampaignRequest implements UpdateCampaignRequest {
  const factory _UpdateCampaignRequest(
      {final String? title,
      final String? description,
      final double? budgetMin,
      final double? budgetMax,
      final CampaignStatus? status,
      final List<String>? categories,
      final List<Platform>? platforms,
      final DateTime? startDate,
      final DateTime? endDate}) = _$UpdateCampaignRequestImpl;

  factory _UpdateCampaignRequest.fromJson(Map<String, dynamic> json) =
      _$UpdateCampaignRequestImpl.fromJson;

  @override
  String? get title;
  @override
  String? get description;
  @override
  double? get budgetMin;
  @override
  double? get budgetMax;
  @override
  CampaignStatus? get status;
  @override
  List<String>? get categories;
  @override
  List<Platform>? get platforms;
  @override
  DateTime? get startDate;
  @override
  DateTime? get endDate;

  /// Create a copy of UpdateCampaignRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateCampaignRequestImplCopyWith<_$UpdateCampaignRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
