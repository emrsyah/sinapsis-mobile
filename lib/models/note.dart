import 'package:freezed_annotation/freezed_annotation.dart';
import 'tag.dart';

part 'note.freezed.dart';
part 'note.g.dart';

@freezed
abstract class Note with _$Note {
  const factory Note({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'folder_id') String? folderId,
    required String title,
    String? content,
    @JsonKey(name: 'is_published') @Default(false) bool isPublished,
    @JsonKey(name: 'share_token') String? shareToken,
    @JsonKey(name: 'deleted_at') String? deletedAt,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'updated_at') required String updatedAt,
    @Default([]) List<Tag> tags,
    @Default([]) List<Note> backlinks,
  }) = _Note;

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);
}
