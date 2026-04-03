import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/api/api_client.dart';
import '../../../core/api/api_endpoints.dart';
import '../../../models/note.dart';

part 'note_repository.g.dart';

@riverpod
NoteRepository noteRepository(Ref ref) {
  return NoteRepository(ref.read(apiClientProvider));
}

class NoteRepository {
  final ApiClient _api;
  NoteRepository(this._api);

  Future<List<Note>> getNotes({
    String? folderId,
    String? tagId,
    String? search,
    bool trash = false,
  }) async {
    final endpoint = trash ? ApiEndpoints.notesTrashed : ApiEndpoints.notes;
    final data =
        await _api.get(
              endpoint,
              params: {
                if (folderId != null) 'folder_id': folderId,
                if (tagId != null) 'tag_id': tagId,
                if (search != null) 'search': search,
              },
            )
            as Map<String, dynamic>;
    return (data['data'] as List)
        .map((e) => Note.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<Note> getNote(String id) async {
    final data =
        await _api.get(
              ApiEndpoints.note(id),
              params: {'include': 'tags,backlinks'},
            )
            as Map<String, dynamic>;
    return Note.fromJson(data['data'] as Map<String, dynamic>);
  }

  Future<Note> createNote({String title = 'Untitled', String? folderId}) async {
    final data =
        await _api.post(
              ApiEndpoints.notes,
              body: {
                'title': title,
                if (folderId != null) 'folder_id': folderId,
              },
            )
            as Map<String, dynamic>;
    return Note.fromJson(data['data'] as Map<String, dynamic>);
  }

  Future<Note> updateNote(
    String id, {
    String? title,
    String? content,
    String? folderId,
  }) async {
    final data =
        await _api.patch(
              ApiEndpoints.note(id),
              body: {
                if (title != null) 'title': title,
                if (content != null) 'content': content,
                if (folderId != null) 'folder_id': folderId,
              },
            )
            as Map<String, dynamic>;
    return Note.fromJson(data['data'] as Map<String, dynamic>);
  }

  Future<void> deleteNote(String id) async {
    await _api.delete(ApiEndpoints.note(id));
  }

  Future<Note> restoreNote(String id) async {
    final data =
        await _api.patch(ApiEndpoints.noteRestore(id), body: {})
            as Map<String, dynamic>;
    return Note.fromJson(data['data'] as Map<String, dynamic>);
  }

  Future<void> forceDeleteNote(String id) async {
    await _api.delete(ApiEndpoints.noteForce(id));
  }

  Future<void> createLink(String sourceId, String targetId) async {
    await _api.post(
      ApiEndpoints.noteLinks(sourceId),
      body: {'target_note_id': targetId},
    );
  }

  Future<void> deleteLink(String sourceId, String targetId) async {
    await _api.delete(ApiEndpoints.noteLink(sourceId, targetId));
  }
}
