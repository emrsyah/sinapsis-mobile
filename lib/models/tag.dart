import 'package:freezed_annotation/freezed_annotation.dart';

part 'tag.freezed.dart';
part 'tag.g.dart';

@freezed
abstract class Tag with _$Tag {
  const factory Tag({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    required String name,
    String? color,
    // Backend TagData.created_at is nullable (?string, no fallback), so this
    // must be nullable too or parsing a tag with a null timestamp throws.
    @JsonKey(name: 'created_at') String? createdAt,
  }) = _Tag;

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);
}
