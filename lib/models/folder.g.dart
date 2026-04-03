// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'folder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Folder _$FolderFromJson(Map<String, dynamic> json) => _Folder(
  id: json['id'] as String,
  userId: json['user_id'] as String,
  parentId: json['parent_id'] as String?,
  name: json['name'] as String,
  createdAt: json['created_at'] as String,
  updatedAt: json['updated_at'] as String,
  children:
      (json['children'] as List<dynamic>?)
          ?.map((e) => Folder.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$FolderToJson(_Folder instance) => <String, dynamic>{
  'id': instance.id,
  'user_id': instance.userId,
  'parent_id': instance.parentId,
  'name': instance.name,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
  'children': instance.children,
};
