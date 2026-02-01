import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.freezed.dart';
part 'message.g.dart';

enum MessageType {
  @JsonValue('TEXT')
  text,
  @JsonValue('TERMS_PROPOSAL')
  termsProposal,
  @JsonValue('SYSTEM')
  system,
  @JsonValue('DELIVERABLE_UPDATE')
  deliverableUpdate,
  @JsonValue('PAYMENT_UPDATE')
  paymentUpdate,
}

@freezed
class Message with _$Message {
  const factory Message({
    required String id,
    required String conversationId,
    String? senderId,
    String? senderDisplayName,
    @Default(MessageType.text) MessageType type,
    required String content,
    String? referenceId,
    DateTime? createdAt,
    DateTime? readAt,
  }) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
}

@freezed
class SendMessageRequest with _$SendMessageRequest {
  const factory SendMessageRequest({
    required String content,
    @Default(MessageType.text) MessageType type,
    String? referenceId,
  }) = _SendMessageRequest;

  factory SendMessageRequest.fromJson(Map<String, dynamic> json) =>
      _$SendMessageRequestFromJson(json);
}
