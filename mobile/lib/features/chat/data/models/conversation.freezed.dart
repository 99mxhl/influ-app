// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'conversation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Conversation _$ConversationFromJson(Map<String, dynamic> json) {
  return _Conversation.fromJson(json);
}

/// @nodoc
mixin _$Conversation {
  String get id => throw _privateConstructorUsedError;
  String get dealId => throw _privateConstructorUsedError;
  String? get dealTitle => throw _privateConstructorUsedError;
  String get influencerId => throw _privateConstructorUsedError;
  String? get influencerDisplayName => throw _privateConstructorUsedError;
  String get clientId => throw _privateConstructorUsedError;
  String? get clientDisplayName => throw _privateConstructorUsedError;
  Message? get lastMessage => throw _privateConstructorUsedError;
  int get unreadCount => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Conversation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConversationCopyWith<Conversation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConversationCopyWith<$Res> {
  factory $ConversationCopyWith(
          Conversation value, $Res Function(Conversation) then) =
      _$ConversationCopyWithImpl<$Res, Conversation>;
  @useResult
  $Res call(
      {String id,
      String dealId,
      String? dealTitle,
      String influencerId,
      String? influencerDisplayName,
      String clientId,
      String? clientDisplayName,
      Message? lastMessage,
      int unreadCount,
      DateTime? createdAt});

  $MessageCopyWith<$Res>? get lastMessage;
}

/// @nodoc
class _$ConversationCopyWithImpl<$Res, $Val extends Conversation>
    implements $ConversationCopyWith<$Res> {
  _$ConversationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? dealId = null,
    Object? dealTitle = freezed,
    Object? influencerId = null,
    Object? influencerDisplayName = freezed,
    Object? clientId = null,
    Object? clientDisplayName = freezed,
    Object? lastMessage = freezed,
    Object? unreadCount = null,
    Object? createdAt = freezed,
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
      dealTitle: freezed == dealTitle
          ? _value.dealTitle
          : dealTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      influencerId: null == influencerId
          ? _value.influencerId
          : influencerId // ignore: cast_nullable_to_non_nullable
              as String,
      influencerDisplayName: freezed == influencerDisplayName
          ? _value.influencerDisplayName
          : influencerDisplayName // ignore: cast_nullable_to_non_nullable
              as String?,
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      clientDisplayName: freezed == clientDisplayName
          ? _value.clientDisplayName
          : clientDisplayName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastMessage: freezed == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as Message?,
      unreadCount: null == unreadCount
          ? _value.unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MessageCopyWith<$Res>? get lastMessage {
    if (_value.lastMessage == null) {
      return null;
    }

    return $MessageCopyWith<$Res>(_value.lastMessage!, (value) {
      return _then(_value.copyWith(lastMessage: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ConversationImplCopyWith<$Res>
    implements $ConversationCopyWith<$Res> {
  factory _$$ConversationImplCopyWith(
          _$ConversationImpl value, $Res Function(_$ConversationImpl) then) =
      __$$ConversationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String dealId,
      String? dealTitle,
      String influencerId,
      String? influencerDisplayName,
      String clientId,
      String? clientDisplayName,
      Message? lastMessage,
      int unreadCount,
      DateTime? createdAt});

  @override
  $MessageCopyWith<$Res>? get lastMessage;
}

/// @nodoc
class __$$ConversationImplCopyWithImpl<$Res>
    extends _$ConversationCopyWithImpl<$Res, _$ConversationImpl>
    implements _$$ConversationImplCopyWith<$Res> {
  __$$ConversationImplCopyWithImpl(
      _$ConversationImpl _value, $Res Function(_$ConversationImpl) _then)
      : super(_value, _then);

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? dealId = null,
    Object? dealTitle = freezed,
    Object? influencerId = null,
    Object? influencerDisplayName = freezed,
    Object? clientId = null,
    Object? clientDisplayName = freezed,
    Object? lastMessage = freezed,
    Object? unreadCount = null,
    Object? createdAt = freezed,
  }) {
    return _then(_$ConversationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      dealId: null == dealId
          ? _value.dealId
          : dealId // ignore: cast_nullable_to_non_nullable
              as String,
      dealTitle: freezed == dealTitle
          ? _value.dealTitle
          : dealTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      influencerId: null == influencerId
          ? _value.influencerId
          : influencerId // ignore: cast_nullable_to_non_nullable
              as String,
      influencerDisplayName: freezed == influencerDisplayName
          ? _value.influencerDisplayName
          : influencerDisplayName // ignore: cast_nullable_to_non_nullable
              as String?,
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      clientDisplayName: freezed == clientDisplayName
          ? _value.clientDisplayName
          : clientDisplayName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastMessage: freezed == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as Message?,
      unreadCount: null == unreadCount
          ? _value.unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConversationImpl implements _Conversation {
  const _$ConversationImpl(
      {required this.id,
      required this.dealId,
      this.dealTitle,
      required this.influencerId,
      this.influencerDisplayName,
      required this.clientId,
      this.clientDisplayName,
      this.lastMessage,
      this.unreadCount = 0,
      this.createdAt});

  factory _$ConversationImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConversationImplFromJson(json);

  @override
  final String id;
  @override
  final String dealId;
  @override
  final String? dealTitle;
  @override
  final String influencerId;
  @override
  final String? influencerDisplayName;
  @override
  final String clientId;
  @override
  final String? clientDisplayName;
  @override
  final Message? lastMessage;
  @override
  @JsonKey()
  final int unreadCount;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'Conversation(id: $id, dealId: $dealId, dealTitle: $dealTitle, influencerId: $influencerId, influencerDisplayName: $influencerDisplayName, clientId: $clientId, clientDisplayName: $clientDisplayName, lastMessage: $lastMessage, unreadCount: $unreadCount, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConversationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.dealId, dealId) || other.dealId == dealId) &&
            (identical(other.dealTitle, dealTitle) ||
                other.dealTitle == dealTitle) &&
            (identical(other.influencerId, influencerId) ||
                other.influencerId == influencerId) &&
            (identical(other.influencerDisplayName, influencerDisplayName) ||
                other.influencerDisplayName == influencerDisplayName) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.clientDisplayName, clientDisplayName) ||
                other.clientDisplayName == clientDisplayName) &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage) &&
            (identical(other.unreadCount, unreadCount) ||
                other.unreadCount == unreadCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      dealId,
      dealTitle,
      influencerId,
      influencerDisplayName,
      clientId,
      clientDisplayName,
      lastMessage,
      unreadCount,
      createdAt);

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConversationImplCopyWith<_$ConversationImpl> get copyWith =>
      __$$ConversationImplCopyWithImpl<_$ConversationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConversationImplToJson(
      this,
    );
  }
}

abstract class _Conversation implements Conversation {
  const factory _Conversation(
      {required final String id,
      required final String dealId,
      final String? dealTitle,
      required final String influencerId,
      final String? influencerDisplayName,
      required final String clientId,
      final String? clientDisplayName,
      final Message? lastMessage,
      final int unreadCount,
      final DateTime? createdAt}) = _$ConversationImpl;

  factory _Conversation.fromJson(Map<String, dynamic> json) =
      _$ConversationImpl.fromJson;

  @override
  String get id;
  @override
  String get dealId;
  @override
  String? get dealTitle;
  @override
  String get influencerId;
  @override
  String? get influencerDisplayName;
  @override
  String get clientId;
  @override
  String? get clientDisplayName;
  @override
  Message? get lastMessage;
  @override
  int get unreadCount;
  @override
  DateTime? get createdAt;

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConversationImplCopyWith<_$ConversationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
