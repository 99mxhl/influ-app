import 'package:freezed_annotation/freezed_annotation.dart';
import 'message.dart';

part 'conversation.freezed.dart';
part 'conversation.g.dart';

@freezed
class Conversation with _$Conversation {
  const factory Conversation({
    required String id,
    required String dealId,
    String? dealTitle,
    required String influencerId,
    String? influencerDisplayName,
    required String clientId,
    String? clientDisplayName,
    Message? lastMessage,
    @Default(0) int unreadCount,
    DateTime? createdAt,
  }) = _Conversation;

  factory Conversation.fromJson(Map<String, dynamic> json) =>
      _$ConversationFromJson(json);
}
