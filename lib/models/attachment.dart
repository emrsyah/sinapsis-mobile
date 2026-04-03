import 'package:freezed_annotation/freezed_annotation.dart';

part 'attachment.freezed.dart';
part 'attachment.g.dart';

@freezed
abstract class Attachment with _$Attachment {
  const factory Attachment({
    required String id,
    @JsonKey(name: 'note_id') required String noteId,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'file_url') required String fileUrl,
    @JsonKey(name: 'file_name') required String fileName,
    @JsonKey(name: 'file_type') String? fileType,
    @JsonKey(name: 'file_size') int? fileSize,
    @JsonKey(name: 'created_at') required String createdAt,
  }) = _Attachment;

  factory Attachment.fromJson(Map<String, dynamic> json) =>
      _$AttachmentFromJson(json);
}
