import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../models/note.dart';
import '../data/note_repository.dart';

part 'search_provider.g.dart';

/// Full-text note search. Returns an empty list for blank queries so the UI
/// can render an idle/empty state without hitting the network.
@riverpod
Future<List<Note>> searchNotes(Ref ref, String query) async {
  final trimmed = query.trim();
  if (trimmed.isEmpty) return const [];
  return ref.read(noteRepositoryProvider).getNotes(search: trimmed);
}
