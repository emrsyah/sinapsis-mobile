import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../models/note.dart';
import '../data/note_repository.dart';

part 'note_provider.g.dart';

@riverpod
class NoteListNotifier extends _$NoteListNotifier {
  @override
  FutureOr<List<Note>> build({String? folderId, bool inTrash = false, String? tagId}) {
    return ref
        .read(noteRepositoryProvider)
        .getNotes(folderId: folderId, tagId: tagId, trash: inTrash);
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

  // Masuk ke tempat sampah (Soft Delete)
  Future<void> trashNote(String id) async {
    await ref.read(noteRepositoryProvider).deleteNote(id);
    ref.invalidateSelf();
  }

  // Memulihkan catatan dari tempat sampah
  Future<void> restoreNote(String id) async {
    await ref.read(noteRepositoryProvider).restoreNote(id);
    ref.invalidateSelf();
  }

  // Hapus permanen dari tempat sampah
  Future<void> deleteNotePermanently(String id) async {
    await ref.read(noteRepositoryProvider).forceDeleteNote(id);
    ref.invalidateSelf();
  }
}

@riverpod
Future<Note> noteDetail(Ref ref, String id) {
  return ref.read(noteRepositoryProvider).getNote(id);
}