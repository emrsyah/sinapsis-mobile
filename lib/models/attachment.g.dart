// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Attachment _$AttachmentFromJson(Map<String, dynamic> json) => _Attachment(
  id: json['id'] as String,
  noteId: json['note_id'] as String,
  userId: json['user_id'] as String,
  fileUrl: json['file_url'] as String,
  fileName: json['file_name'] as String,
  fileType: json['file_type'] as String?,
  fileSize: (json['file_size'] as num?)?.toInt(),
  createdAt: json['created_at'] as String,
);

Map<String, dynamic> _$AttachmentToJson(_Attachment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'note_id': instance.noteId,
      'user_id': instance.userId,
      'file_url': instance.fileUrl,
      'file_name': instance.fileName,
      'file_type': instance.fileType,
      'file_size': instance.fileSize,
      'created_at': instance.createdAt,
    };
