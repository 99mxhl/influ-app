import 'package:freezed_annotation/freezed_annotation.dart';

part 'file_upload.freezed.dart';
part 'file_upload.g.dart';

enum FileType {
  @JsonValue('IMAGE')
  image,
  @JsonValue('VIDEO')
  video,
  @JsonValue('DOCUMENT')
  document,
}

@freezed
class PresignRequest with _$PresignRequest {
  const factory PresignRequest({
    required String fileName,
    required String contentType,
    FileType? type,
  }) = _PresignRequest;

  factory PresignRequest.fromJson(Map<String, dynamic> json) =>
      _$PresignRequestFromJson(json);
}

@freezed
class PresignResponse with _$PresignResponse {
  const factory PresignResponse({
    required String uploadUrl,
    required String fileKey,
    required String publicUrl,
  }) = _PresignResponse;

  factory PresignResponse.fromJson(Map<String, dynamic> json) =>
      _$PresignResponseFromJson(json);
}
