import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/theme.dart';
import '../../data/models/file_upload.dart';
import '../../providers/file_upload_provider.dart';

class FilePickerButton extends ConsumerStatefulWidget {
  final FileType fileType;
  final ValueChanged<String> onUploadComplete;
  final ValueChanged<String>? onError;
  final Widget? child;

  const FilePickerButton({
    super.key,
    required this.fileType,
    required this.onUploadComplete,
    this.onError,
    this.child,
  });

  @override
  ConsumerState<FilePickerButton> createState() => _FilePickerButtonState();
}

class _FilePickerButtonState extends ConsumerState<FilePickerButton> {
  final ImagePicker _picker = ImagePicker();
  bool _isUploading = false;

  Future<void> _pickAndUpload() async {
    if (_isUploading) return;

    XFile? file;
    if (widget.fileType == FileType.image) {
      file = await _picker.pickImage(source: ImageSource.gallery);
    } else if (widget.fileType == FileType.video) {
      file = await _picker.pickVideo(source: ImageSource.gallery);
    }

    if (file == null) return;

    setState(() => _isUploading = true);

    try {
      final url = await ref
          .read(fileUploadProvider.notifier)
          .uploadFile(File(file.path), type: widget.fileType);

      if (url != null) {
        widget.onUploadComplete(url);
      } else {
        widget.onError?.call('Upload failed');
      }
    } catch (e) {
      widget.onError?.call(e.toString());
    } finally {
      if (mounted) {
        setState(() => _isUploading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.child != null) {
      return GestureDetector(
        onTap: _pickAndUpload,
        child: Stack(
          children: [
            widget.child!,
            if (_isUploading)
              Positioned.fill(
                child: Container(
                  color: Colors.black38,
                  child: const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
    }

    return OutlinedButton.icon(
      onPressed: _isUploading ? null : _pickAndUpload,
      icon: _isUploading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Icon(_getIcon()),
      label: Text(_isUploading ? 'Uploading...' : _getLabel()),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        side: BorderSide(color: AppColors.gray300),
        shape: RoundedRectangleBorder(borderRadius: AppRadius.button),
      ),
    );
  }

  IconData _getIcon() {
    return switch (widget.fileType) {
      FileType.image => LucideIcons.image,
      FileType.video => LucideIcons.video,
      FileType.document => LucideIcons.file,
    };
  }

  String _getLabel() {
    return switch (widget.fileType) {
      FileType.image => 'Upload Image',
      FileType.video => 'Upload Video',
      FileType.document => 'Upload File',
    };
  }
}
