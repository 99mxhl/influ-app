// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'deal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Deal _$DealFromJson(Map<String, dynamic> json) {
  return _Deal.fromJson(json);
}

/// @nodoc
mixin _$Deal {
  String get id => throw _privateConstructorUsedError;
  String get campaignId => throw _privateConstructorUsedError;
  String get influencerId => throw _privateConstructorUsedError;
  String get clientId => throw _privateConstructorUsedError;
  DealStatus get status => throw _privateConstructorUsedError;
  double? get agreedAmount => throw _privateConstructorUsedError;
  double? get platformFee => throw _privateConstructorUsedError;
  String? get campaignTitle => throw _privateConstructorUsedError;
  @JsonKey(name: 'influencerDisplayName')
  String? get influencerName => throw _privateConstructorUsedError;
  @JsonKey(name: 'clientDisplayName')
  String? get clientName => throw _privateConstructorUsedError;
  DealTerms? get currentTerms => throw _privateConstructorUsedError;
  List<DealTerms> get termsHistory => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Deal to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Deal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DealCopyWith<Deal> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DealCopyWith<$Res> {
  factory $DealCopyWith(Deal value, $Res Function(Deal) then) =
      _$DealCopyWithImpl<$Res, Deal>;
  @useResult
  $Res call(
      {String id,
      String campaignId,
      String influencerId,
      String clientId,
      DealStatus status,
      double? agreedAmount,
      double? platformFee,
      String? campaignTitle,
      @JsonKey(name: 'influencerDisplayName') String? influencerName,
      @JsonKey(name: 'clientDisplayName') String? clientName,
      DealTerms? currentTerms,
      List<DealTerms> termsHistory,
      DateTime? createdAt,
      DateTime? updatedAt});

  $DealTermsCopyWith<$Res>? get currentTerms;
}

/// @nodoc
class _$DealCopyWithImpl<$Res, $Val extends Deal>
    implements $DealCopyWith<$Res> {
  _$DealCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Deal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? campaignId = null,
    Object? influencerId = null,
    Object? clientId = null,
    Object? status = null,
    Object? agreedAmount = freezed,
    Object? platformFee = freezed,
    Object? campaignTitle = freezed,
    Object? influencerName = freezed,
    Object? clientName = freezed,
    Object? currentTerms = freezed,
    Object? termsHistory = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      campaignId: null == campaignId
          ? _value.campaignId
          : campaignId // ignore: cast_nullable_to_non_nullable
              as String,
      influencerId: null == influencerId
          ? _value.influencerId
          : influencerId // ignore: cast_nullable_to_non_nullable
              as String,
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as DealStatus,
      agreedAmount: freezed == agreedAmount
          ? _value.agreedAmount
          : agreedAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      platformFee: freezed == platformFee
          ? _value.platformFee
          : platformFee // ignore: cast_nullable_to_non_nullable
              as double?,
      campaignTitle: freezed == campaignTitle
          ? _value.campaignTitle
          : campaignTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      influencerName: freezed == influencerName
          ? _value.influencerName
          : influencerName // ignore: cast_nullable_to_non_nullable
              as String?,
      clientName: freezed == clientName
          ? _value.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String?,
      currentTerms: freezed == currentTerms
          ? _value.currentTerms
          : currentTerms // ignore: cast_nullable_to_non_nullable
              as DealTerms?,
      termsHistory: null == termsHistory
          ? _value.termsHistory
          : termsHistory // ignore: cast_nullable_to_non_nullable
              as List<DealTerms>,
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

  /// Create a copy of Deal
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DealTermsCopyWith<$Res>? get currentTerms {
    if (_value.currentTerms == null) {
      return null;
    }

    return $DealTermsCopyWith<$Res>(_value.currentTerms!, (value) {
      return _then(_value.copyWith(currentTerms: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DealImplCopyWith<$Res> implements $DealCopyWith<$Res> {
  factory _$$DealImplCopyWith(
          _$DealImpl value, $Res Function(_$DealImpl) then) =
      __$$DealImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String campaignId,
      String influencerId,
      String clientId,
      DealStatus status,
      double? agreedAmount,
      double? platformFee,
      String? campaignTitle,
      @JsonKey(name: 'influencerDisplayName') String? influencerName,
      @JsonKey(name: 'clientDisplayName') String? clientName,
      DealTerms? currentTerms,
      List<DealTerms> termsHistory,
      DateTime? createdAt,
      DateTime? updatedAt});

  @override
  $DealTermsCopyWith<$Res>? get currentTerms;
}

/// @nodoc
class __$$DealImplCopyWithImpl<$Res>
    extends _$DealCopyWithImpl<$Res, _$DealImpl>
    implements _$$DealImplCopyWith<$Res> {
  __$$DealImplCopyWithImpl(_$DealImpl _value, $Res Function(_$DealImpl) _then)
      : super(_value, _then);

  /// Create a copy of Deal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? campaignId = null,
    Object? influencerId = null,
    Object? clientId = null,
    Object? status = null,
    Object? agreedAmount = freezed,
    Object? platformFee = freezed,
    Object? campaignTitle = freezed,
    Object? influencerName = freezed,
    Object? clientName = freezed,
    Object? currentTerms = freezed,
    Object? termsHistory = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$DealImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      campaignId: null == campaignId
          ? _value.campaignId
          : campaignId // ignore: cast_nullable_to_non_nullable
              as String,
      influencerId: null == influencerId
          ? _value.influencerId
          : influencerId // ignore: cast_nullable_to_non_nullable
              as String,
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as DealStatus,
      agreedAmount: freezed == agreedAmount
          ? _value.agreedAmount
          : agreedAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      platformFee: freezed == platformFee
          ? _value.platformFee
          : platformFee // ignore: cast_nullable_to_non_nullable
              as double?,
      campaignTitle: freezed == campaignTitle
          ? _value.campaignTitle
          : campaignTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      influencerName: freezed == influencerName
          ? _value.influencerName
          : influencerName // ignore: cast_nullable_to_non_nullable
              as String?,
      clientName: freezed == clientName
          ? _value.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String?,
      currentTerms: freezed == currentTerms
          ? _value.currentTerms
          : currentTerms // ignore: cast_nullable_to_non_nullable
              as DealTerms?,
      termsHistory: null == termsHistory
          ? _value._termsHistory
          : termsHistory // ignore: cast_nullable_to_non_nullable
              as List<DealTerms>,
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
class _$DealImpl implements _Deal {
  const _$DealImpl(
      {required this.id,
      required this.campaignId,
      required this.influencerId,
      required this.clientId,
      required this.status,
      this.agreedAmount,
      this.platformFee,
      this.campaignTitle,
      @JsonKey(name: 'influencerDisplayName') this.influencerName,
      @JsonKey(name: 'clientDisplayName') this.clientName,
      this.currentTerms,
      final List<DealTerms> termsHistory = const [],
      this.createdAt,
      this.updatedAt})
      : _termsHistory = termsHistory;

  factory _$DealImpl.fromJson(Map<String, dynamic> json) =>
      _$$DealImplFromJson(json);

  @override
  final String id;
  @override
  final String campaignId;
  @override
  final String influencerId;
  @override
  final String clientId;
  @override
  final DealStatus status;
  @override
  final double? agreedAmount;
  @override
  final double? platformFee;
  @override
  final String? campaignTitle;
  @override
  @JsonKey(name: 'influencerDisplayName')
  final String? influencerName;
  @override
  @JsonKey(name: 'clientDisplayName')
  final String? clientName;
  @override
  final DealTerms? currentTerms;
  final List<DealTerms> _termsHistory;
  @override
  @JsonKey()
  List<DealTerms> get termsHistory {
    if (_termsHistory is EqualUnmodifiableListView) return _termsHistory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_termsHistory);
  }

  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Deal(id: $id, campaignId: $campaignId, influencerId: $influencerId, clientId: $clientId, status: $status, agreedAmount: $agreedAmount, platformFee: $platformFee, campaignTitle: $campaignTitle, influencerName: $influencerName, clientName: $clientName, currentTerms: $currentTerms, termsHistory: $termsHistory, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DealImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.campaignId, campaignId) ||
                other.campaignId == campaignId) &&
            (identical(other.influencerId, influencerId) ||
                other.influencerId == influencerId) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.agreedAmount, agreedAmount) ||
                other.agreedAmount == agreedAmount) &&
            (identical(other.platformFee, platformFee) ||
                other.platformFee == platformFee) &&
            (identical(other.campaignTitle, campaignTitle) ||
                other.campaignTitle == campaignTitle) &&
            (identical(other.influencerName, influencerName) ||
                other.influencerName == influencerName) &&
            (identical(other.clientName, clientName) ||
                other.clientName == clientName) &&
            (identical(other.currentTerms, currentTerms) ||
                other.currentTerms == currentTerms) &&
            const DeepCollectionEquality()
                .equals(other._termsHistory, _termsHistory) &&
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
      campaignId,
      influencerId,
      clientId,
      status,
      agreedAmount,
      platformFee,
      campaignTitle,
      influencerName,
      clientName,
      currentTerms,
      const DeepCollectionEquality().hash(_termsHistory),
      createdAt,
      updatedAt);

  /// Create a copy of Deal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DealImplCopyWith<_$DealImpl> get copyWith =>
      __$$DealImplCopyWithImpl<_$DealImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DealImplToJson(
      this,
    );
  }
}

abstract class _Deal implements Deal {
  const factory _Deal(
      {required final String id,
      required final String campaignId,
      required final String influencerId,
      required final String clientId,
      required final DealStatus status,
      final double? agreedAmount,
      final double? platformFee,
      final String? campaignTitle,
      @JsonKey(name: 'influencerDisplayName') final String? influencerName,
      @JsonKey(name: 'clientDisplayName') final String? clientName,
      final DealTerms? currentTerms,
      final List<DealTerms> termsHistory,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$DealImpl;

  factory _Deal.fromJson(Map<String, dynamic> json) = _$DealImpl.fromJson;

  @override
  String get id;
  @override
  String get campaignId;
  @override
  String get influencerId;
  @override
  String get clientId;
  @override
  DealStatus get status;
  @override
  double? get agreedAmount;
  @override
  double? get platformFee;
  @override
  String? get campaignTitle;
  @override
  @JsonKey(name: 'influencerDisplayName')
  String? get influencerName;
  @override
  @JsonKey(name: 'clientDisplayName')
  String? get clientName;
  @override
  DealTerms? get currentTerms;
  @override
  List<DealTerms> get termsHistory;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of Deal
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DealImplCopyWith<_$DealImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DealTerms _$DealTermsFromJson(Map<String, dynamic> json) {
  return _DealTerms.fromJson(json);
}

/// @nodoc
mixin _$DealTerms {
  String get id => throw _privateConstructorUsedError;
  String get dealId => throw _privateConstructorUsedError;
  int get version => throw _privateConstructorUsedError;
  String get proposedById => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  DealTermsStatus get status => throw _privateConstructorUsedError;
  List<DeliverableSpec> get deliverables => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this DealTerms to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DealTerms
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DealTermsCopyWith<DealTerms> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DealTermsCopyWith<$Res> {
  factory $DealTermsCopyWith(DealTerms value, $Res Function(DealTerms) then) =
      _$DealTermsCopyWithImpl<$Res, DealTerms>;
  @useResult
  $Res call(
      {String id,
      String dealId,
      int version,
      String proposedById,
      double amount,
      DealTermsStatus status,
      List<DeliverableSpec> deliverables,
      String? notes,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$DealTermsCopyWithImpl<$Res, $Val extends DealTerms>
    implements $DealTermsCopyWith<$Res> {
  _$DealTermsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DealTerms
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? dealId = null,
    Object? version = null,
    Object? proposedById = null,
    Object? amount = null,
    Object? status = null,
    Object? deliverables = null,
    Object? notes = freezed,
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
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
      proposedById: null == proposedById
          ? _value.proposedById
          : proposedById // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as DealTermsStatus,
      deliverables: null == deliverables
          ? _value.deliverables
          : deliverables // ignore: cast_nullable_to_non_nullable
              as List<DeliverableSpec>,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
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
abstract class _$$DealTermsImplCopyWith<$Res>
    implements $DealTermsCopyWith<$Res> {
  factory _$$DealTermsImplCopyWith(
          _$DealTermsImpl value, $Res Function(_$DealTermsImpl) then) =
      __$$DealTermsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String dealId,
      int version,
      String proposedById,
      double amount,
      DealTermsStatus status,
      List<DeliverableSpec> deliverables,
      String? notes,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$DealTermsImplCopyWithImpl<$Res>
    extends _$DealTermsCopyWithImpl<$Res, _$DealTermsImpl>
    implements _$$DealTermsImplCopyWith<$Res> {
  __$$DealTermsImplCopyWithImpl(
      _$DealTermsImpl _value, $Res Function(_$DealTermsImpl) _then)
      : super(_value, _then);

  /// Create a copy of DealTerms
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? dealId = null,
    Object? version = null,
    Object? proposedById = null,
    Object? amount = null,
    Object? status = null,
    Object? deliverables = null,
    Object? notes = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$DealTermsImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      dealId: null == dealId
          ? _value.dealId
          : dealId // ignore: cast_nullable_to_non_nullable
              as String,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
      proposedById: null == proposedById
          ? _value.proposedById
          : proposedById // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as DealTermsStatus,
      deliverables: null == deliverables
          ? _value._deliverables
          : deliverables // ignore: cast_nullable_to_non_nullable
              as List<DeliverableSpec>,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
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
class _$DealTermsImpl implements _DealTerms {
  const _$DealTermsImpl(
      {required this.id,
      required this.dealId,
      required this.version,
      required this.proposedById,
      required this.amount,
      required this.status,
      final List<DeliverableSpec> deliverables = const [],
      this.notes,
      this.createdAt,
      this.updatedAt})
      : _deliverables = deliverables;

  factory _$DealTermsImpl.fromJson(Map<String, dynamic> json) =>
      _$$DealTermsImplFromJson(json);

  @override
  final String id;
  @override
  final String dealId;
  @override
  final int version;
  @override
  final String proposedById;
  @override
  final double amount;
  @override
  final DealTermsStatus status;
  final List<DeliverableSpec> _deliverables;
  @override
  @JsonKey()
  List<DeliverableSpec> get deliverables {
    if (_deliverables is EqualUnmodifiableListView) return _deliverables;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_deliverables);
  }

  @override
  final String? notes;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'DealTerms(id: $id, dealId: $dealId, version: $version, proposedById: $proposedById, amount: $amount, status: $status, deliverables: $deliverables, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DealTermsImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.dealId, dealId) || other.dealId == dealId) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.proposedById, proposedById) ||
                other.proposedById == proposedById) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other._deliverables, _deliverables) &&
            (identical(other.notes, notes) || other.notes == notes) &&
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
      version,
      proposedById,
      amount,
      status,
      const DeepCollectionEquality().hash(_deliverables),
      notes,
      createdAt,
      updatedAt);

  /// Create a copy of DealTerms
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DealTermsImplCopyWith<_$DealTermsImpl> get copyWith =>
      __$$DealTermsImplCopyWithImpl<_$DealTermsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DealTermsImplToJson(
      this,
    );
  }
}

abstract class _DealTerms implements DealTerms {
  const factory _DealTerms(
      {required final String id,
      required final String dealId,
      required final int version,
      required final String proposedById,
      required final double amount,
      required final DealTermsStatus status,
      final List<DeliverableSpec> deliverables,
      final String? notes,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$DealTermsImpl;

  factory _DealTerms.fromJson(Map<String, dynamic> json) =
      _$DealTermsImpl.fromJson;

  @override
  String get id;
  @override
  String get dealId;
  @override
  int get version;
  @override
  String get proposedById;
  @override
  double get amount;
  @override
  DealTermsStatus get status;
  @override
  List<DeliverableSpec> get deliverables;
  @override
  String? get notes;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of DealTerms
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DealTermsImplCopyWith<_$DealTermsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DeliverableSpec _$DeliverableSpecFromJson(Map<String, dynamic> json) {
  return _DeliverableSpec.fromJson(json);
}

/// @nodoc
mixin _$DeliverableSpec {
  Platform get platform => throw _privateConstructorUsedError;
  ContentType get contentType => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  /// Serializes this DeliverableSpec to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DeliverableSpec
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeliverableSpecCopyWith<DeliverableSpec> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeliverableSpecCopyWith<$Res> {
  factory $DeliverableSpecCopyWith(
          DeliverableSpec value, $Res Function(DeliverableSpec) then) =
      _$DeliverableSpecCopyWithImpl<$Res, DeliverableSpec>;
  @useResult
  $Res call(
      {Platform platform,
      ContentType contentType,
      int quantity,
      String? description});
}

/// @nodoc
class _$DeliverableSpecCopyWithImpl<$Res, $Val extends DeliverableSpec>
    implements $DeliverableSpecCopyWith<$Res> {
  _$DeliverableSpecCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DeliverableSpec
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? platform = null,
    Object? contentType = null,
    Object? quantity = null,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      platform: null == platform
          ? _value.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as Platform,
      contentType: null == contentType
          ? _value.contentType
          : contentType // ignore: cast_nullable_to_non_nullable
              as ContentType,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DeliverableSpecImplCopyWith<$Res>
    implements $DeliverableSpecCopyWith<$Res> {
  factory _$$DeliverableSpecImplCopyWith(_$DeliverableSpecImpl value,
          $Res Function(_$DeliverableSpecImpl) then) =
      __$$DeliverableSpecImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Platform platform,
      ContentType contentType,
      int quantity,
      String? description});
}

/// @nodoc
class __$$DeliverableSpecImplCopyWithImpl<$Res>
    extends _$DeliverableSpecCopyWithImpl<$Res, _$DeliverableSpecImpl>
    implements _$$DeliverableSpecImplCopyWith<$Res> {
  __$$DeliverableSpecImplCopyWithImpl(
      _$DeliverableSpecImpl _value, $Res Function(_$DeliverableSpecImpl) _then)
      : super(_value, _then);

  /// Create a copy of DeliverableSpec
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? platform = null,
    Object? contentType = null,
    Object? quantity = null,
    Object? description = freezed,
  }) {
    return _then(_$DeliverableSpecImpl(
      platform: null == platform
          ? _value.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as Platform,
      contentType: null == contentType
          ? _value.contentType
          : contentType // ignore: cast_nullable_to_non_nullable
              as ContentType,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DeliverableSpecImpl implements _DeliverableSpec {
  const _$DeliverableSpecImpl(
      {required this.platform,
      required this.contentType,
      required this.quantity,
      this.description});

  factory _$DeliverableSpecImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeliverableSpecImplFromJson(json);

  @override
  final Platform platform;
  @override
  final ContentType contentType;
  @override
  final int quantity;
  @override
  final String? description;

  @override
  String toString() {
    return 'DeliverableSpec(platform: $platform, contentType: $contentType, quantity: $quantity, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeliverableSpecImpl &&
            (identical(other.platform, platform) ||
                other.platform == platform) &&
            (identical(other.contentType, contentType) ||
                other.contentType == contentType) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, platform, contentType, quantity, description);

  /// Create a copy of DeliverableSpec
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeliverableSpecImplCopyWith<_$DeliverableSpecImpl> get copyWith =>
      __$$DeliverableSpecImplCopyWithImpl<_$DeliverableSpecImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeliverableSpecImplToJson(
      this,
    );
  }
}

abstract class _DeliverableSpec implements DeliverableSpec {
  const factory _DeliverableSpec(
      {required final Platform platform,
      required final ContentType contentType,
      required final int quantity,
      final String? description}) = _$DeliverableSpecImpl;

  factory _DeliverableSpec.fromJson(Map<String, dynamic> json) =
      _$DeliverableSpecImpl.fromJson;

  @override
  Platform get platform;
  @override
  ContentType get contentType;
  @override
  int get quantity;
  @override
  String? get description;

  /// Create a copy of DeliverableSpec
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeliverableSpecImplCopyWith<_$DeliverableSpecImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProposeTermsRequest _$ProposeTermsRequestFromJson(Map<String, dynamic> json) {
  return _ProposeTermsRequest.fromJson(json);
}

/// @nodoc
mixin _$ProposeTermsRequest {
  double get amount => throw _privateConstructorUsedError;
  List<DeliverableSpec> get deliverables => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  /// Serializes this ProposeTermsRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProposeTermsRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProposeTermsRequestCopyWith<ProposeTermsRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProposeTermsRequestCopyWith<$Res> {
  factory $ProposeTermsRequestCopyWith(
          ProposeTermsRequest value, $Res Function(ProposeTermsRequest) then) =
      _$ProposeTermsRequestCopyWithImpl<$Res, ProposeTermsRequest>;
  @useResult
  $Res call({double amount, List<DeliverableSpec> deliverables, String? notes});
}

/// @nodoc
class _$ProposeTermsRequestCopyWithImpl<$Res, $Val extends ProposeTermsRequest>
    implements $ProposeTermsRequestCopyWith<$Res> {
  _$ProposeTermsRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProposeTermsRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? deliverables = null,
    Object? notes = freezed,
  }) {
    return _then(_value.copyWith(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      deliverables: null == deliverables
          ? _value.deliverables
          : deliverables // ignore: cast_nullable_to_non_nullable
              as List<DeliverableSpec>,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProposeTermsRequestImplCopyWith<$Res>
    implements $ProposeTermsRequestCopyWith<$Res> {
  factory _$$ProposeTermsRequestImplCopyWith(_$ProposeTermsRequestImpl value,
          $Res Function(_$ProposeTermsRequestImpl) then) =
      __$$ProposeTermsRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double amount, List<DeliverableSpec> deliverables, String? notes});
}

/// @nodoc
class __$$ProposeTermsRequestImplCopyWithImpl<$Res>
    extends _$ProposeTermsRequestCopyWithImpl<$Res, _$ProposeTermsRequestImpl>
    implements _$$ProposeTermsRequestImplCopyWith<$Res> {
  __$$ProposeTermsRequestImplCopyWithImpl(_$ProposeTermsRequestImpl _value,
      $Res Function(_$ProposeTermsRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProposeTermsRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? deliverables = null,
    Object? notes = freezed,
  }) {
    return _then(_$ProposeTermsRequestImpl(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      deliverables: null == deliverables
          ? _value._deliverables
          : deliverables // ignore: cast_nullable_to_non_nullable
              as List<DeliverableSpec>,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProposeTermsRequestImpl implements _ProposeTermsRequest {
  const _$ProposeTermsRequestImpl(
      {required this.amount,
      required final List<DeliverableSpec> deliverables,
      this.notes})
      : _deliverables = deliverables;

  factory _$ProposeTermsRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProposeTermsRequestImplFromJson(json);

  @override
  final double amount;
  final List<DeliverableSpec> _deliverables;
  @override
  List<DeliverableSpec> get deliverables {
    if (_deliverables is EqualUnmodifiableListView) return _deliverables;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_deliverables);
  }

  @override
  final String? notes;

  @override
  String toString() {
    return 'ProposeTermsRequest(amount: $amount, deliverables: $deliverables, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProposeTermsRequestImpl &&
            (identical(other.amount, amount) || other.amount == amount) &&
            const DeepCollectionEquality()
                .equals(other._deliverables, _deliverables) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, amount,
      const DeepCollectionEquality().hash(_deliverables), notes);

  /// Create a copy of ProposeTermsRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProposeTermsRequestImplCopyWith<_$ProposeTermsRequestImpl> get copyWith =>
      __$$ProposeTermsRequestImplCopyWithImpl<_$ProposeTermsRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProposeTermsRequestImplToJson(
      this,
    );
  }
}

abstract class _ProposeTermsRequest implements ProposeTermsRequest {
  const factory _ProposeTermsRequest(
      {required final double amount,
      required final List<DeliverableSpec> deliverables,
      final String? notes}) = _$ProposeTermsRequestImpl;

  factory _ProposeTermsRequest.fromJson(Map<String, dynamic> json) =
      _$ProposeTermsRequestImpl.fromJson;

  @override
  double get amount;
  @override
  List<DeliverableSpec> get deliverables;
  @override
  String? get notes;

  /// Create a copy of ProposeTermsRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProposeTermsRequestImplCopyWith<_$ProposeTermsRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ApplyToCampaignRequest _$ApplyToCampaignRequestFromJson(
    Map<String, dynamic> json) {
  return _ApplyToCampaignRequest.fromJson(json);
}

/// @nodoc
mixin _$ApplyToCampaignRequest {
  String get campaignId => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this ApplyToCampaignRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ApplyToCampaignRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApplyToCampaignRequestCopyWith<ApplyToCampaignRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApplyToCampaignRequestCopyWith<$Res> {
  factory $ApplyToCampaignRequestCopyWith(ApplyToCampaignRequest value,
          $Res Function(ApplyToCampaignRequest) then) =
      _$ApplyToCampaignRequestCopyWithImpl<$Res, ApplyToCampaignRequest>;
  @useResult
  $Res call({String campaignId, String? message});
}

/// @nodoc
class _$ApplyToCampaignRequestCopyWithImpl<$Res,
        $Val extends ApplyToCampaignRequest>
    implements $ApplyToCampaignRequestCopyWith<$Res> {
  _$ApplyToCampaignRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApplyToCampaignRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? campaignId = null,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      campaignId: null == campaignId
          ? _value.campaignId
          : campaignId // ignore: cast_nullable_to_non_nullable
              as String,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ApplyToCampaignRequestImplCopyWith<$Res>
    implements $ApplyToCampaignRequestCopyWith<$Res> {
  factory _$$ApplyToCampaignRequestImplCopyWith(
          _$ApplyToCampaignRequestImpl value,
          $Res Function(_$ApplyToCampaignRequestImpl) then) =
      __$$ApplyToCampaignRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String campaignId, String? message});
}

/// @nodoc
class __$$ApplyToCampaignRequestImplCopyWithImpl<$Res>
    extends _$ApplyToCampaignRequestCopyWithImpl<$Res,
        _$ApplyToCampaignRequestImpl>
    implements _$$ApplyToCampaignRequestImplCopyWith<$Res> {
  __$$ApplyToCampaignRequestImplCopyWithImpl(
      _$ApplyToCampaignRequestImpl _value,
      $Res Function(_$ApplyToCampaignRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of ApplyToCampaignRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? campaignId = null,
    Object? message = freezed,
  }) {
    return _then(_$ApplyToCampaignRequestImpl(
      campaignId: null == campaignId
          ? _value.campaignId
          : campaignId // ignore: cast_nullable_to_non_nullable
              as String,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ApplyToCampaignRequestImpl implements _ApplyToCampaignRequest {
  const _$ApplyToCampaignRequestImpl({required this.campaignId, this.message});

  factory _$ApplyToCampaignRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApplyToCampaignRequestImplFromJson(json);

  @override
  final String campaignId;
  @override
  final String? message;

  @override
  String toString() {
    return 'ApplyToCampaignRequest(campaignId: $campaignId, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApplyToCampaignRequestImpl &&
            (identical(other.campaignId, campaignId) ||
                other.campaignId == campaignId) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, campaignId, message);

  /// Create a copy of ApplyToCampaignRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApplyToCampaignRequestImplCopyWith<_$ApplyToCampaignRequestImpl>
      get copyWith => __$$ApplyToCampaignRequestImplCopyWithImpl<
          _$ApplyToCampaignRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApplyToCampaignRequestImplToJson(
      this,
    );
  }
}

abstract class _ApplyToCampaignRequest implements ApplyToCampaignRequest {
  const factory _ApplyToCampaignRequest(
      {required final String campaignId,
      final String? message}) = _$ApplyToCampaignRequestImpl;

  factory _ApplyToCampaignRequest.fromJson(Map<String, dynamic> json) =
      _$ApplyToCampaignRequestImpl.fromJson;

  @override
  String get campaignId;
  @override
  String? get message;

  /// Create a copy of ApplyToCampaignRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApplyToCampaignRequestImplCopyWith<_$ApplyToCampaignRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

InviteInfluencerRequest _$InviteInfluencerRequestFromJson(
    Map<String, dynamic> json) {
  return _InviteInfluencerRequest.fromJson(json);
}

/// @nodoc
mixin _$InviteInfluencerRequest {
  String get campaignId => throw _privateConstructorUsedError;
  String get influencerId => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this InviteInfluencerRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InviteInfluencerRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InviteInfluencerRequestCopyWith<InviteInfluencerRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InviteInfluencerRequestCopyWith<$Res> {
  factory $InviteInfluencerRequestCopyWith(InviteInfluencerRequest value,
          $Res Function(InviteInfluencerRequest) then) =
      _$InviteInfluencerRequestCopyWithImpl<$Res, InviteInfluencerRequest>;
  @useResult
  $Res call({String campaignId, String influencerId, String? message});
}

/// @nodoc
class _$InviteInfluencerRequestCopyWithImpl<$Res,
        $Val extends InviteInfluencerRequest>
    implements $InviteInfluencerRequestCopyWith<$Res> {
  _$InviteInfluencerRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InviteInfluencerRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? campaignId = null,
    Object? influencerId = null,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      campaignId: null == campaignId
          ? _value.campaignId
          : campaignId // ignore: cast_nullable_to_non_nullable
              as String,
      influencerId: null == influencerId
          ? _value.influencerId
          : influencerId // ignore: cast_nullable_to_non_nullable
              as String,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InviteInfluencerRequestImplCopyWith<$Res>
    implements $InviteInfluencerRequestCopyWith<$Res> {
  factory _$$InviteInfluencerRequestImplCopyWith(
          _$InviteInfluencerRequestImpl value,
          $Res Function(_$InviteInfluencerRequestImpl) then) =
      __$$InviteInfluencerRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String campaignId, String influencerId, String? message});
}

/// @nodoc
class __$$InviteInfluencerRequestImplCopyWithImpl<$Res>
    extends _$InviteInfluencerRequestCopyWithImpl<$Res,
        _$InviteInfluencerRequestImpl>
    implements _$$InviteInfluencerRequestImplCopyWith<$Res> {
  __$$InviteInfluencerRequestImplCopyWithImpl(
      _$InviteInfluencerRequestImpl _value,
      $Res Function(_$InviteInfluencerRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of InviteInfluencerRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? campaignId = null,
    Object? influencerId = null,
    Object? message = freezed,
  }) {
    return _then(_$InviteInfluencerRequestImpl(
      campaignId: null == campaignId
          ? _value.campaignId
          : campaignId // ignore: cast_nullable_to_non_nullable
              as String,
      influencerId: null == influencerId
          ? _value.influencerId
          : influencerId // ignore: cast_nullable_to_non_nullable
              as String,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InviteInfluencerRequestImpl implements _InviteInfluencerRequest {
  const _$InviteInfluencerRequestImpl(
      {required this.campaignId, required this.influencerId, this.message});

  factory _$InviteInfluencerRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$InviteInfluencerRequestImplFromJson(json);

  @override
  final String campaignId;
  @override
  final String influencerId;
  @override
  final String? message;

  @override
  String toString() {
    return 'InviteInfluencerRequest(campaignId: $campaignId, influencerId: $influencerId, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InviteInfluencerRequestImpl &&
            (identical(other.campaignId, campaignId) ||
                other.campaignId == campaignId) &&
            (identical(other.influencerId, influencerId) ||
                other.influencerId == influencerId) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, campaignId, influencerId, message);

  /// Create a copy of InviteInfluencerRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InviteInfluencerRequestImplCopyWith<_$InviteInfluencerRequestImpl>
      get copyWith => __$$InviteInfluencerRequestImplCopyWithImpl<
          _$InviteInfluencerRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InviteInfluencerRequestImplToJson(
      this,
    );
  }
}

abstract class _InviteInfluencerRequest implements InviteInfluencerRequest {
  const factory _InviteInfluencerRequest(
      {required final String campaignId,
      required final String influencerId,
      final String? message}) = _$InviteInfluencerRequestImpl;

  factory _InviteInfluencerRequest.fromJson(Map<String, dynamic> json) =
      _$InviteInfluencerRequestImpl.fromJson;

  @override
  String get campaignId;
  @override
  String get influencerId;
  @override
  String? get message;

  /// Create a copy of InviteInfluencerRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InviteInfluencerRequestImplCopyWith<_$InviteInfluencerRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
