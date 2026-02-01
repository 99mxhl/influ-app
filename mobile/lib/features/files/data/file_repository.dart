import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_parser/http_parser.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/api_response.dart';
import 'models/file_upload.dart';

final fileRepositoryProvider = Provider<FileRepository>((ref) {
  return FileRepository(ref.watch(apiClientProvider));
});

class FileRepository {
  final ApiClient _apiClient;
  final Dio _uploadDio = Dio();

  FileRepository(this._apiClient);

  Future<PresignResponse> getPresignedUrl(PresignRequest request) async {
    try {
      final response = await _apiClient.post(
        '/api/files/presign',
        data: request.toJson(),
      );

      return parseApiResponse(
        response.data as Map<String, dynamic>,
        (data) => PresignResponse.fromJson(data as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      if (e.response?.data != null) {
        throw ApiException.fromResponse(
          e.response!.data as Map<String, dynamic>,
          e.response?.statusCode,
        );
      }
      throw ApiException(message: 'Failed to get upload URL');
    }
  }

  Future<String> uploadFile(File file, String contentType, {FileType? type}) async {
    // Step 1: Get presigned URL
    final fileName = file.path.split('/').last;
    final presignResponse = await getPresignedUrl(PresignRequest(
      fileName: fileName,
      contentType: contentType,
      type: type,
    ));

    // Step 2: Upload file to S3
    final bytes = await file.readAsBytes();
    await _uploadDio.put(
      presignResponse.uploadUrl,
      data: bytes,
      options: Options(
        contentType: contentType,
        headers: {
          'Content-Length': bytes.length,
        },
      ),
    );

    // Step 3: Confirm upload
    await confirmUpload(presignResponse.fileKey);

    return presignResponse.publicUrl;
  }

  Future<void> confirmUpload(String fileKey) async {
    try {
      await _apiClient.post(
        '/api/files/confirm',
        data: {'fileKey': fileKey},
      );
    } on DioException {
      // Silently fail for confirm
    }
  }

  FileType getFileTypeFromMime(String mimeType) {
    if (mimeType.startsWith('image/')) {
      return FileType.image;
    } else if (mimeType.startsWith('video/')) {
      return FileType.video;
    } else {
      return FileType.document;
    }
  }

  String getMimeType(String fileName) {
    final extension = fileName.split('.').last.toLowerCase();
    return switch (extension) {
      'jpg' || 'jpeg' => 'image/jpeg',
      'png' => 'image/png',
      'gif' => 'image/gif',
      'webp' => 'image/webp',
      'mp4' => 'video/mp4',
      'mov' => 'video/quicktime',
      'avi' => 'video/x-msvideo',
      'pdf' => 'application/pdf',
      'doc' => 'application/msword',
      'docx' => 'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
      _ => 'application/octet-stream',
    };
  }
}
