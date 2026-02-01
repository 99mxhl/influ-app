import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification.freezed.dart';
part 'notification.g.dart';

enum NotificationType {
  @JsonValue('MESSAGE')
  message,
  @JsonValue('DEAL')
  deal,
  @JsonValue('PAYMENT')
  payment,
  @JsonValue('APPLICATION')
  application,
  @JsonValue('INVITATION')
  invitation,
  @JsonValue('REVIEW')
  review,
  @JsonValue('SYSTEM')
  system,
}

@freezed
class AppNotification with _$AppNotification {
  const factory AppNotification({
    required String id,
    required NotificationType type,
    required String title,
    required String description,
    String? actionUrl,
    String? referenceId,
    @Default(false) bool read,
    DateTime? readAt,
    DateTime? createdAt,
  }) = _AppNotification;

  factory AppNotification.fromJson(Map<String, dynamic> json) =>
      _$AppNotificationFromJson(json);
}
