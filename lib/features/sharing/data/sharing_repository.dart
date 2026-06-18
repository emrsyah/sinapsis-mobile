import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/api/api_client.dart';
import '../../../core/api/api_endpoints.dart';
import '../../../models/note.dart';

part 'sharing_repository.g.dart';

@riverpod
SharingRepository sharingRepository(Ref ref) {
  return SharingRepository(ref.read(apiClientProvider));
}

class SharingRepository {
  final ApiClient _api;
  SharingRepository(this._api);

  /// Publishes a note and returns the updated note (with `share_token` set).
  Future<Note> publish(String noteId) async {
    final data =
        await _api.post(ApiEndpoints.notePublish(noteId))
            as Map<String, dynamic>;
    return Note.fromJson(data['data'] as Map<String, dynamic>);
  }

  Future<void> unpublish(String noteId) async {
    await _api.delete(ApiEndpoints.notePublish(noteId));
  }

  /// Fetches a publicly published note by its share token (no auth required).
  Future<Note> getShared(String token) async {
    final data =
        await _api.get(ApiEndpoints.shared(token)) as Map<String, dynamic>;
    return Note.fromJson(data['data'] as Map<String, dynamic>);
  }
}
