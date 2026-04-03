// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Note _$NoteFromJson(Map<String, dynamic> json) => _Note(
  id: json['id'] as String,
  userId: json['user_id'] as String,
  folderId: json['folder_id'] as String?,
  title: json['title'] as String,
  content: json['content'] as String?,
  isPublished: json['is_published'] as bool? ?? false,
  shareToken: json['share_token'] as String?,
  deletedAt: json['deleted_at'] as String?,
  createdAt: json['created_at'] as String,
  updatedAt: json['updated_at'] as String,
  tags:
      (json['tags'] as List<dynamic>?)
          ?.map((e) => Tag.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  backlinks:
      (json['backlinks'] as List<dynamic>?)
          ?.map((e) => Note.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$NoteToJson(_Note instance) => <String, dynamic>{
  'id': instance.id,
  'user_id': instance.userId,
  'folder_id': instance.folderId,
  'title': instance.title,
  'content': instance.content,
  'is_published': instance.isPublished,
  'share_token': instance.shareToken,
  'deleted_at': instance.deletedAt,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
  'tags': instance.tags,
  'backlinks': instance.backlinks,
};
