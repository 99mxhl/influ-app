// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'campaigns_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CampaignsState {
  List<Campaign> get campaigns => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isLoadingMore => throw _privateConstructorUsedError;
  bool get hasMore => throw _privateConstructorUsedError;
  bool get hasLoaded => throw _privateConstructorUsedError;
  int get currentPage => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Create a copy of CampaignsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CampaignsStateCopyWith<CampaignsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CampaignsStateCopyWith<$Res> {
  factory $CampaignsStateCopyWith(
          CampaignsState value, $Res Function(CampaignsState) then) =
      _$CampaignsStateCopyWithImpl<$Res, CampaignsState>;
  @useResult
  $Res call(
      {List<Campaign> campaigns,
      bool isLoading,
      bool isLoadingMore,
      bool hasMore,
      bool hasLoaded,
      int currentPage,
      String? error});
}

/// @nodoc
class _$CampaignsStateCopyWithImpl<$Res, $Val extends CampaignsState>
    implements $CampaignsStateCopyWith<$Res> {
  _$CampaignsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CampaignsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? campaigns = null,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? hasMore = null,
    Object? hasLoaded = null,
    Object? currentPage = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      campaigns: null == campaigns
          ? _value.campaigns
          : campaigns // ignore: cast_nullable_to_non_nullable
              as List<Campaign>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingMore: null == isLoadingMore
          ? _value.isLoadingMore
          : isLoadingMore // ignore: cast_nullable_to_non_nullable
              as bool,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      hasLoaded: null == hasLoaded
          ? _value.hasLoaded
          : hasLoaded // ignore: cast_nullable_to_non_nullable
              as bool,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CampaignsStateImplCopyWith<$Res>
    implements $CampaignsStateCopyWith<$Res> {
  factory _$$CampaignsStateImplCopyWith(_$CampaignsStateImpl value,
          $Res Function(_$CampaignsStateImpl) then) =
      __$$CampaignsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Campaign> campaigns,
      bool isLoading,
      bool isLoadingMore,
      bool hasMore,
      bool hasLoaded,
      int currentPage,
      String? error});
}

/// @nodoc
class __$$CampaignsStateImplCopyWithImpl<$Res>
    extends _$CampaignsStateCopyWithImpl<$Res, _$CampaignsStateImpl>
    implements _$$CampaignsStateImplCopyWith<$Res> {
  __$$CampaignsStateImplCopyWithImpl(
      _$CampaignsStateImpl _value, $Res Function(_$CampaignsStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CampaignsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? campaigns = null,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? hasMore = null,
    Object? hasLoaded = null,
    Object? currentPage = null,
    Object? error = freezed,
  }) {
    return _then(_$CampaignsStateImpl(
      campaigns: null == campaigns
          ? _value._campaigns
          : campaigns // ignore: cast_nullable_to_non_nullable
              as List<Campaign>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingMore: null == isLoadingMore
          ? _value.isLoadingMore
          : isLoadingMore // ignore: cast_nullable_to_non_nullable
              as bool,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      hasLoaded: null == hasLoaded
          ? _value.hasLoaded
          : hasLoaded // ignore: cast_nullable_to_non_nullable
              as bool,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$CampaignsStateImpl implements _CampaignsState {
  const _$CampaignsStateImpl(
      {final List<Campaign> campaigns = const [],
      this.isLoading = false,
      this.isLoadingMore = false,
      this.hasMore = false,
      this.hasLoaded = false,
      this.currentPage = 0,
      this.error})
      : _campaigns = campaigns;

  final List<Campaign> _campaigns;
  @override
  @JsonKey()
  List<Campaign> get campaigns {
    if (_campaigns is EqualUnmodifiableListView) return _campaigns;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_campaigns);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isLoadingMore;
  @override
  @JsonKey()
  final bool hasMore;
  @override
  @JsonKey()
  final bool hasLoaded;
  @override
  @JsonKey()
  final int currentPage;
  @override
  final String? error;

  @override
  String toString() {
    return 'CampaignsState(campaigns: $campaigns, isLoading: $isLoading, isLoadingMore: $isLoadingMore, hasMore: $hasMore, hasLoaded: $hasLoaded, currentPage: $currentPage, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CampaignsStateImpl &&
            const DeepCollectionEquality()
                .equals(other._campaigns, _campaigns) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.hasLoaded, hasLoaded) ||
                other.hasLoaded == hasLoaded) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_campaigns),
      isLoading,
      isLoadingMore,
      hasMore,
      hasLoaded,
      currentPage,
      error);

  /// Create a copy of CampaignsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CampaignsStateImplCopyWith<_$CampaignsStateImpl> get copyWith =>
      __$$CampaignsStateImplCopyWithImpl<_$CampaignsStateImpl>(
          this, _$identity);
}

abstract class _CampaignsState implements CampaignsState {
  const factory _CampaignsState(
      {final List<Campaign> campaigns,
      final bool isLoading,
      final bool isLoadingMore,
      final bool hasMore,
      final bool hasLoaded,
      final int currentPage,
      final String? error}) = _$CampaignsStateImpl;

  @override
  List<Campaign> get campaigns;
  @override
  bool get isLoading;
  @override
  bool get isLoadingMore;
  @override
  bool get hasMore;
  @override
  bool get hasLoaded;
  @override
  int get currentPage;
  @override
  String? get error;

  /// Create a copy of CampaignsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CampaignsStateImplCopyWith<_$CampaignsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MyCampaignsState {
  List<Campaign> get campaigns => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get hasLoaded => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Create a copy of MyCampaignsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MyCampaignsStateCopyWith<MyCampaignsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyCampaignsStateCopyWith<$Res> {
  factory $MyCampaignsStateCopyWith(
          MyCampaignsState value, $Res Function(MyCampaignsState) then) =
      _$MyCampaignsStateCopyWithImpl<$Res, MyCampaignsState>;
  @useResult
  $Res call(
      {List<Campaign> campaigns,
      bool isLoading,
      bool hasLoaded,
      String? error});
}

/// @nodoc
class _$MyCampaignsStateCopyWithImpl<$Res, $Val extends MyCampaignsState>
    implements $MyCampaignsStateCopyWith<$Res> {
  _$MyCampaignsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MyCampaignsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? campaigns = null,
    Object? isLoading = null,
    Object? hasLoaded = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      campaigns: null == campaigns
          ? _value.campaigns
          : campaigns // ignore: cast_nullable_to_non_nullable
              as List<Campaign>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      hasLoaded: null == hasLoaded
          ? _value.hasLoaded
          : hasLoaded // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MyCampaignsStateImplCopyWith<$Res>
    implements $MyCampaignsStateCopyWith<$Res> {
  factory _$$MyCampaignsStateImplCopyWith(_$MyCampaignsStateImpl value,
          $Res Function(_$MyCampaignsStateImpl) then) =
      __$$MyCampaignsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Campaign> campaigns,
      bool isLoading,
      bool hasLoaded,
      String? error});
}

/// @nodoc
class __$$MyCampaignsStateImplCopyWithImpl<$Res>
    extends _$MyCampaignsStateCopyWithImpl<$Res, _$MyCampaignsStateImpl>
    implements _$$MyCampaignsStateImplCopyWith<$Res> {
  __$$MyCampaignsStateImplCopyWithImpl(_$MyCampaignsStateImpl _value,
      $Res Function(_$MyCampaignsStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of MyCampaignsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? campaigns = null,
    Object? isLoading = null,
    Object? hasLoaded = null,
    Object? error = freezed,
  }) {
    return _then(_$MyCampaignsStateImpl(
      campaigns: null == campaigns
          ? _value._campaigns
          : campaigns // ignore: cast_nullable_to_non_nullable
              as List<Campaign>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      hasLoaded: null == hasLoaded
          ? _value.hasLoaded
          : hasLoaded // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$MyCampaignsStateImpl implements _MyCampaignsState {
  const _$MyCampaignsStateImpl(
      {final List<Campaign> campaigns = const [],
      this.isLoading = false,
      this.hasLoaded = false,
      this.error})
      : _campaigns = campaigns;

  final List<Campaign> _campaigns;
  @override
  @JsonKey()
  List<Campaign> get campaigns {
    if (_campaigns is EqualUnmodifiableListView) return _campaigns;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_campaigns);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool hasLoaded;
  @override
  final String? error;

  @override
  String toString() {
    return 'MyCampaignsState(campaigns: $campaigns, isLoading: $isLoading, hasLoaded: $hasLoaded, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MyCampaignsStateImpl &&
            const DeepCollectionEquality()
                .equals(other._campaigns, _campaigns) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.hasLoaded, hasLoaded) ||
                other.hasLoaded == hasLoaded) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_campaigns),
      isLoading,
      hasLoaded,
      error);

  /// Create a copy of MyCampaignsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MyCampaignsStateImplCopyWith<_$MyCampaignsStateImpl> get copyWith =>
      __$$MyCampaignsStateImplCopyWithImpl<_$MyCampaignsStateImpl>(
          this, _$identity);
}

abstract class _MyCampaignsState implements MyCampaignsState {
  const factory _MyCampaignsState(
      {final List<Campaign> campaigns,
      final bool isLoading,
      final bool hasLoaded,
      final String? error}) = _$MyCampaignsStateImpl;

  @override
  List<Campaign> get campaigns;
  @override
  bool get isLoading;
  @override
  bool get hasLoaded;
  @override
  String? get error;

  /// Create a copy of MyCampaignsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MyCampaignsStateImplCopyWith<_$MyCampaignsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
