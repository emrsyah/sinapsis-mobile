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
    @JsonKey(name: 'created_at') required String createdAt,
  }) = _Tag;

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);
}
