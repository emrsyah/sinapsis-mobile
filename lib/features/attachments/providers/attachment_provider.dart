import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../models/attachment.dart';
import '../data/attachment_repository.dart';

part 'attachment_provider.g.dart';

@riverpod
class AttachmentListNotifier extends _$AttachmentListNotifier {
  @override
  Future<List<Attachment>> build(String noteId) {
    return ref.read(attachmentRepositoryProvider).getAttachments(noteId);
  }

  Future<void> upload(String filePath, {String? fileName}) async {
    await ref
        .read(attachmentRepositoryProvider)
        .uploadAttachment(noteId, filePath, fileName: fileName);
    ref.invalidateSelf();
  }

  Future<void> delete(String attachmentId) async {
    await ref
        .read(attachmentRepositoryProvider)
        .deleteAttachment(attachmentId);
    ref.invalidateSelf();
  }
}
