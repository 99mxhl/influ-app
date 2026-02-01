import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../data/file_repository.dart';
import '../data/models/file_upload.dart';

part 'file_upload_provider.freezed.dart';

@freezed
class FileUploadState with _$FileUploadState {
  const factory FileUploadState.idle() = _Idle;
  const factory FileUploadState.uploading({required double progress}) = _Uploading;
  const factory FileUploadState.success({required String url}) = _Success;
  const factory FileUploadState.error({required String message}) = _Error;
}

class FileUploadNotifier extends StateNotifier<FileUploadState> {
  final FileRepository _repository;

  FileUploadNotifier(this._repository) : super(const FileUploadState.idle());

  Future<String?> uploadFile(File file, {FileType? type}) async {
    state = const FileUploadState.uploading(progress: 0);

    try {
      final mimeType = _repository.getMimeType(file.path.split('/').last);
      final fileType = type ?? _repository.getFileTypeFromMime(mimeType);

      final url = await _repository.uploadFile(file, mimeType, type: fileType);
      state = FileUploadState.success(url: url);
      return url;
    } catch (e) {
      state = FileUploadState.error(message: e.toString());
      return null;
    }
  }

  void reset() {
    state = const FileUploadState.idle();
  }
}

final fileUploadProvider =
    StateNotifierProvider.autoDispose<FileUploadNotifier, FileUploadState>((ref) {
  return FileUploadNotifier(ref.watch(fileRepositoryProvider));
});
