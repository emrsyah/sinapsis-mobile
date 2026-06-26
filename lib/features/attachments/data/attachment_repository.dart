import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/api/api_client.dart';
import '../../../core/api/api_endpoints.dart';
import '../../../core/api/api_parse.dart';
import '../../../models/attachment.dart';

part 'attachment_repository.g.dart';

@riverpod
AttachmentRepository attachmentRepository(Ref ref) {
  return AttachmentRepository(ref.read(apiClientProvider));
}

class AttachmentRepository {
  final ApiClient _api;
  AttachmentRepository(this._api);

  Future<List<Attachment>> getAttachments(String noteId) async {
    final data = await _api.get(ApiEndpoints.noteAttachments(noteId));
    return dataList(data)
        .map((e) => Attachment.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<Attachment> uploadAttachment(
    String noteId,
    String filePath, {
    String? fileName,
  }) async {
    final data = await _api.upload(
      ApiEndpoints.noteAttachments(noteId),
      filePath,
      fileName: fileName,
    );
    return Attachment.fromJson(dataMap(data));
  }

  Future<void> deleteAttachment(String attachmentId) async {
    await _api.delete(ApiEndpoints.attachment(attachmentId));
  }
}
