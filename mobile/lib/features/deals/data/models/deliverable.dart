import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/models/enums.dart';

part 'deliverable.freezed.dart';
part 'deliverable.g.dart';

@freezed
class Deliverable with _$Deliverable {
  const factory Deliverable({
    required String id,
    required String dealId,
    required Platform platform,
    required ContentType contentType,
    String? description,
    String? contentUrl,
    String? thumbnailUrl,
    @Default(DeliverableStatus.pending) DeliverableStatus status,
    String? rejectionReason,
    String? revisionNotes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Deliverable;

  factory Deliverable.fromJson(Map<String, dynamic> json) =>
      _$DeliverableFromJson(json);
}

@freezed
class SubmitDeliverableRequest with _$SubmitDeliverableRequest {
  const factory SubmitDeliverableRequest({
    required String contentUrl,
    String? thumbnailUrl,
  }) = _SubmitDeliverableRequest;

  factory SubmitDeliverableRequest.fromJson(Map<String, dynamic> json) =>
      _$SubmitDeliverableRequestFromJson(json);
}

@freezed
class RejectDeliverableRequest with _$RejectDeliverableRequest {
  const factory RejectDeliverableRequest({
    required String reason,
    String? revisionNotes,
  }) = _RejectDeliverableRequest;

  factory RejectDeliverableRequest.fromJson(Map<String, dynamic> json) =>
      _$RejectDeliverableRequestFromJson(json);
}
