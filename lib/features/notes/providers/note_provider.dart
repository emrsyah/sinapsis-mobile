import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../models/note.dart';
import '../data/note_repository.dart';

part 'note_provider.g.dart';

@riverpod
class NoteListNotifier extends _$NoteListNotifier {
  @override
  Future<List<Note>> build({String? folderId, String? tagId}) {
    return ref
        .read(noteRepositoryProvider)
        .getNotes(folderId: folderId, tagId: tagId);
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }

  Future<Note> createNote({String? folderId}) async {
    final note = await ref
        .read(noteRepositoryProvider)
        .createNote(folderId: folderId);
    ref.invalidateSelf();
    return note;
  }

  Future<void> deleteNote(String id) async {
    await ref.read(noteRepositoryProvider).deleteNote(id);
    ref.invalidateSelf();
  }
}

@riverpod
Future<Note> noteDetail(Ref ref, String id) {
  return ref.read(noteRepositoryProvider).getNote(id);
}
