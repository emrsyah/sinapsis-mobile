import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../models/tag.dart';
import '../../notes/providers/note_provider.dart';
import '../data/tag_repository.dart';

part 'tag_provider.g.dart';

@riverpod
class TagListNotifier extends _$TagListNotifier {
  @override
  Future<List<Tag>> build() {
    return ref.read(tagRepositoryProvider).getTags();
  }

  Future<Tag> createTag(String name, {String? color}) async {
    final tag = await ref
        .read(tagRepositoryProvider)
        .createTag(name, color: color);
    ref.invalidateSelf();
    return tag;
  }

  Future<void> deleteTag(String id) async {
    await ref.read(tagRepositoryProvider).deleteTag(id);
    ref.invalidateSelf();
  }

  Future<void> attachTag(String noteId, String tagId) async {
    await ref.read(tagRepositoryProvider).attachTag(noteId, tagId);
    // Refresh the note detail so its tag chips update.
    ref.invalidate(noteDetailProvider(noteId));
  }

  Future<void> detachTag(String noteId, String tagId) async {
    await ref.read(tagRepositoryProvider).detachTag(noteId, tagId);
    ref.invalidate(noteDetailProvider(noteId));
  }
}
