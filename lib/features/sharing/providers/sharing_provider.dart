import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../models/note.dart';
import '../../notes/providers/note_provider.dart';
import '../data/sharing_repository.dart';

part 'sharing_provider.g.dart';

// keepAlive: this is a stateless action controller invoked via `ref.read`
// (never watched), so without keepAlive it would be auto-disposed mid-publish,
// and the post-await `ref.invalidate` would throw "used after disposed".
@Riverpod(keepAlive: true)
class SharingController extends _$SharingController {
  @override
  void build() {}

  Future<Note> publish(String noteId) async {
    final note = await ref.read(sharingRepositoryProvider).publish(noteId);
    ref.invalidate(noteDetailProvider(noteId));
    return note;
  }

  Future<void> unpublish(String noteId) async {
    await ref.read(sharingRepositoryProvider).unpublish(noteId);
    ref.invalidate(noteDetailProvider(noteId));
  }
}

/// Public shared note by token (no auth).
@riverpod
Future<Note> sharedNote(Ref ref, String token) {
  return ref.read(sharingRepositoryProvider).getShared(token);
}
