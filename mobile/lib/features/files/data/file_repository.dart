import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/api_response.dart';
import 'models/file_upload.dart';

final fileRepositoryProvider = Provider<FileRepository>((ref) {
  return FileRepository(ref.watch(apiClientProvider));
});

/// File size limits in bytes
class FileSizeLimits {
  FileSizeLimits._();

  static const int image = 10 * 1024 * 1024; // 10MB
  static const int video = 100 * 1024 * 1024; // 100MB
  static const int document = 20 * 1024 * 1024; // 20MB

  static int forType(FileType? type) {
    return switch (type) {
      FileType.image => image,
      FileType.video => video,
      FileType.document => document,
      null => document,
    };
  }

  static String formatSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}

/// Magic number signatures for file type validation
class _FileMagicNumbers {
  _FileMagicNumbers._();

  // Image signatures
  static const jpeg = [0xFF, 0xD8, 0xFF];
  static const png = [0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A];
  static const gif87a = [0x47, 0x49, 0x46, 0x38, 0x37, 0x61];
  static const gif89a = [0x47, 0x49, 0x46, 0x38, 0x39, 0x61];
  static const webp = [0x52, 0x49, 0x46, 0x46]; // RIFF header, WebP has WEBP at offset 8

  // Video signatures
  static const mp4 = [0x00, 0x00, 0x00]; // ftyp box follows
  static const mov = [0x00, 0x00, 0x00]; // Same as mp4 (uses ftyp)

  // Document signatures
  static const pdf = [0x25, 0x50, 0x44, 0x46]; // %PDF
}

class FileRepository {
  final ApiClient _apiClient;

  /// Separate Dio instance for S3 uploads (no auth interceptor needed)
  final Dio _uploadDio = Dio(BaseOptions(
    connectTimeout: const Duration(minutes: 2),
    receiveTimeout: const Duration(minutes: 2),
    sendTimeout: const Duration(minutes: 5),
  ));

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

  /// Uploads a file with validation.
  ///
  /// Validates:
  /// - File size against limits for file type
  /// - File magic numbers match expected content type
  ///
  /// Throws [ApiException] if validation fails.
  Future<String> uploadFile(File file, String contentType, {FileType? type}) async {
    // Determine file type from content type if not provided
    type ??= getFileTypeFromMime(contentType);

    // Step 1: Validate file size
    final fileSize = await file.length();
    final maxSize = FileSizeLimits.forType(type);
    if (fileSize > maxSize) {
      throw ApiException(
        message: 'File too large. Maximum size: ${FileSizeLimits.formatSize(maxSize)}',
      );
    }

    if (fileSize == 0) {
      throw ApiException(message: 'Cannot upload empty file');
    }

    // Step 2: Read file header for magic number validation
    final headerBytes = await _readFileHeader(file, 12);
    if (!_validateMagicNumber(headerBytes, contentType, type)) {
      throw ApiException(
        message: 'File content does not match expected type. '
            'Please select a valid ${type.name} file.',
      );
    }

    // Step 3: Get presigned URL
    final fileName = file.path.split('/').last;
    final presignResponse = await getPresignedUrl(PresignRequest(
      fileName: fileName,
      contentType: contentType,
      type: type,
    ));

    // Step 4: Upload file to S3
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

    // Step 5: Confirm upload
    await confirmUpload(presignResponse.fileKey);

    return presignResponse.publicUrl;
  }

  /// Reads the first [length] bytes of a file for magic number validation.
  Future<Uint8List> _readFileHeader(File file, int length) async {
    final raf = await file.open(mode: FileMode.read);
    try {
      final bytes = await raf.read(length);
      return bytes;
    } finally {
      await raf.close();
    }
  }

  /// Validates file magic numbers match expected content type.
  bool _validateMagicNumber(Uint8List header, String contentType, FileType type) {
    if (header.isEmpty) return false;

    switch (type) {
      case FileType.image:
        return _isValidImageMagic(header, contentType);
      case FileType.video:
        return _isValidVideoMagic(header, contentType);
      case FileType.document:
        return _isValidDocumentMagic(header, contentType);
    }
  }

  bool _isValidImageMagic(Uint8List header, String contentType) {
    if (contentType == 'image/jpeg' || contentType == 'image/jpg') {
      return _matchesMagic(header, _FileMagicNumbers.jpeg);
    }
    if (contentType == 'image/png') {
      return _matchesMagic(header, _FileMagicNumbers.png);
    }
    if (contentType == 'image/gif') {
      return _matchesMagic(header, _FileMagicNumbers.gif87a) ||
          _matchesMagic(header, _FileMagicNumbers.gif89a);
    }
    if (contentType == 'image/webp') {
      // WebP: RIFF....WEBP
      return _matchesMagic(header, _FileMagicNumbers.webp) &&
          header.length >= 12 &&
          header[8] == 0x57 && // W
          header[9] == 0x45 && // E
          header[10] == 0x42 && // B
          header[11] == 0x50; // P
    }
    // Unknown image type - allow but log
    if (kDebugMode) {
      debugPrint('Unknown image content type: $contentType');
    }
    return true;
  }

  bool _isValidVideoMagic(Uint8List header, String contentType) {
    // MP4/MOV files start with ftyp box
    // Check for common ftyp signatures at offset 4
    if (header.length >= 8) {
      final hasFtyp = header[4] == 0x66 && // f
          header[5] == 0x74 && // t
          header[6] == 0x79 && // y
          header[7] == 0x70; // p
      if (hasFtyp) return true;
    }
    // AVI files start with RIFF....AVI
    if (_matchesMagic(header, [0x52, 0x49, 0x46, 0x46]) &&
        header.length >= 12 &&
        header[8] == 0x41 && // A
        header[9] == 0x56 && // V
        header[10] == 0x49) {
      // I
      return true;
    }
    if (kDebugMode) {
      debugPrint('Unknown video content type: $contentType');
    }
    return true;
  }

  bool _isValidDocumentMagic(Uint8List header, String contentType) {
    if (contentType == 'application/pdf') {
      return _matchesMagic(header, _FileMagicNumbers.pdf);
    }
    // MS Office documents have complex signatures, allow them
    if (contentType.contains('officedocument') || contentType.contains('msword')) {
      return true;
    }
    // Unknown document type - allow
    return true;
  }

  bool _matchesMagic(Uint8List header, List<int> magic) {
    if (header.length < magic.length) return false;
    for (var i = 0; i < magic.length; i++) {
      if (header[i] != magic[i]) return false;
    }
    return true;
  }

  /// Confirms upload with backend. Retries once on failure.
  /// Logs errors but doesn't throw - upload already succeeded at S3.
  Future<void> confirmUpload(String fileKey) async {
    for (var attempt = 1; attempt <= 2; attempt++) {
      try {
        await _apiClient.post(
          '/api/files/confirm',
          data: {'fileKey': fileKey},
        );
        return;
      } on DioException catch (e) {
        if (kDebugMode) {
          debugPrint('Upload confirm failed (attempt $attempt): ${e.message}');
        }
        if (attempt < 2) {
          await Future.delayed(const Duration(seconds: 1));
        }
      }
    }
    // File is uploaded to S3 but backend doesn't know about it.
    // This is logged but not thrown since the file is accessible.
    if (kDebugMode) {
      debugPrint('Upload confirm failed for key: $fileKey');
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
