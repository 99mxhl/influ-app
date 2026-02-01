// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'deals_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DealsState {
  List<Deal> get deals => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isLoadingMore => throw _privateConstructorUsedError;
  bool get hasMore => throw _privateConstructorUsedError;
  bool get hasLoaded => throw _privateConstructorUsedError;
  int get currentPage => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Create a copy of DealsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DealsStateCopyWith<DealsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DealsStateCopyWith<$Res> {
  factory $DealsStateCopyWith(
          DealsState value, $Res Function(DealsState) then) =
      _$DealsStateCopyWithImpl<$Res, DealsState>;
  @useResult
  $Res call(
      {List<Deal> deals,
      bool isLoading,
      bool isLoadingMore,
      bool hasMore,
      bool hasLoaded,
      int currentPage,
      String? error});
}

/// @nodoc
class _$DealsStateCopyWithImpl<$Res, $Val extends DealsState>
    implements $DealsStateCopyWith<$Res> {
  _$DealsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DealsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deals = null,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? hasMore = null,
    Object? hasLoaded = null,
    Object? currentPage = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      deals: null == deals
          ? _value.deals
          : deals // ignore: cast_nullable_to_non_nullable
              as List<Deal>,
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
abstract class _$$DealsStateImplCopyWith<$Res>
    implements $DealsStateCopyWith<$Res> {
  factory _$$DealsStateImplCopyWith(
          _$DealsStateImpl value, $Res Function(_$DealsStateImpl) then) =
      __$$DealsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Deal> deals,
      bool isLoading,
      bool isLoadingMore,
      bool hasMore,
      bool hasLoaded,
      int currentPage,
      String? error});
}

/// @nodoc
class __$$DealsStateImplCopyWithImpl<$Res>
    extends _$DealsStateCopyWithImpl<$Res, _$DealsStateImpl>
    implements _$$DealsStateImplCopyWith<$Res> {
  __$$DealsStateImplCopyWithImpl(
      _$DealsStateImpl _value, $Res Function(_$DealsStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of DealsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deals = null,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? hasMore = null,
    Object? hasLoaded = null,
    Object? currentPage = null,
    Object? error = freezed,
  }) {
    return _then(_$DealsStateImpl(
      deals: null == deals
          ? _value._deals
          : deals // ignore: cast_nullable_to_non_nullable
              as List<Deal>,
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

class _$DealsStateImpl implements _DealsState {
  const _$DealsStateImpl(
      {final List<Deal> deals = const [],
      this.isLoading = false,
      this.isLoadingMore = false,
      this.hasMore = false,
      this.hasLoaded = false,
      this.currentPage = 0,
      this.error})
      : _deals = deals;

  final List<Deal> _deals;
  @override
  @JsonKey()
  List<Deal> get deals {
    if (_deals is EqualUnmodifiableListView) return _deals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_deals);
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
    return 'DealsState(deals: $deals, isLoading: $isLoading, isLoadingMore: $isLoadingMore, hasMore: $hasMore, hasLoaded: $hasLoaded, currentPage: $currentPage, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DealsStateImpl &&
            const DeepCollectionEquality().equals(other._deals, _deals) &&
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
      const DeepCollectionEquality().hash(_deals),
      isLoading,
      isLoadingMore,
      hasMore,
      hasLoaded,
      currentPage,
      error);

  /// Create a copy of DealsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DealsStateImplCopyWith<_$DealsStateImpl> get copyWith =>
      __$$DealsStateImplCopyWithImpl<_$DealsStateImpl>(this, _$identity);
}

abstract class _DealsState implements DealsState {
  const factory _DealsState(
      {final List<Deal> deals,
      final bool isLoading,
      final bool isLoadingMore,
      final bool hasMore,
      final bool hasLoaded,
      final int currentPage,
      final String? error}) = _$DealsStateImpl;

  @override
  List<Deal> get deals;
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

  /// Create a copy of DealsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DealsStateImplCopyWith<_$DealsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
