// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_upload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PresignRequestImpl _$$PresignRequestImplFromJson(Map<String, dynamic> json) =>
    _$PresignRequestImpl(
      fileName: json['fileName'] as String,
      contentType: json['contentType'] as String,
      type: $enumDecodeNullable(_$FileTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$$PresignRequestImplToJson(
        _$PresignRequestImpl instance) =>
    <String, dynamic>{
      'fileName': instance.fileName,
      'contentType': instance.contentType,
      'type': _$FileTypeEnumMap[instance.type],
    };

const _$FileTypeEnumMap = {
  FileType.image: 'IMAGE',
  FileType.video: 'VIDEO',
  FileType.document: 'DOCUMENT',
};

_$PresignResponseImpl _$$PresignResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$PresignResponseImpl(
      uploadUrl: json['uploadUrl'] as String,
      fileKey: json['fileKey'] as String,
      publicUrl: json['publicUrl'] as String,
    );

Map<String, dynamic> _$$PresignResponseImplToJson(
        _$PresignResponseImpl instance) =>
    <String, dynamic>{
      'uploadUrl': instance.uploadUrl,
      'fileKey': instance.fileKey,
      'publicUrl': instance.publicUrl,
    };
