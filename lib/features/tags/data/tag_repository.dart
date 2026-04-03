import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/api/api_client.dart';
import '../../../core/api/api_endpoints.dart';
import '../../../models/tag.dart';

part 'tag_repository.g.dart';

@riverpod
TagRepository tagRepository(Ref ref) {
  return TagRepository(ref.read(apiClientProvider));
}

class TagRepository {
  final ApiClient _api;
  TagRepository(this._api);

  Future<List<Tag>> getTags() async {
    final data = await _api.get(ApiEndpoints.tags) as Map<String, dynamic>;
    return (data['data'] as List)
        .map((e) => Tag.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<Tag> createTag(String name, {String? color}) async {
    final data =
        await _api.post(
              ApiEndpoints.tags,
              body: {'name': name, if (color != null) 'color': color},
            )
            as Map<String, dynamic>;
    return Tag.fromJson(data['data'] as Map<String, dynamic>);
  }

  Future<void> deleteTag(String id) async {
    await _api.delete(ApiEndpoints.tag(id));
  }

  Future<void> attachTag(String noteId, String tagId) async {
    await _api.post(ApiEndpoints.noteTagsUrl(noteId), body: {'tag_id': tagId});
  }

  Future<void> detachTag(String noteId, String tagId) async {
    await _api.delete(ApiEndpoints.noteTagDetach(noteId, tagId));
  }
}
