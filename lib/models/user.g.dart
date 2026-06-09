// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
  id: json['user_id'] as String,
  name: json['name'] as String,
  email: json['email'] as String,
  avatarUrl: json['image'] as String?,
  lastOpenedNoteId: json['last_opened_note_id'] as String?,
  createdAt: json['created_at'] as String,
  updatedAt: json['updated_at'] as String,
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'user_id': instance.id,
  'name': instance.name,
  'email': instance.email,
  'image': instance.avatarUrl,
  'last_opened_note_id': instance.lastOpenedNoteId,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
};
