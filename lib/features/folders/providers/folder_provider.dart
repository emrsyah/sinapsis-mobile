import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../models/folder.dart';
import '../data/folder_repository.dart';

part 'folder_provider.g.dart';

@riverpod
class FolderListNotifier extends _$FolderListNotifier {
  @override
  Future<List<Folder>> build() {
    return ref.read(folderRepositoryProvider).getFolders();
  }

  Future<void> createFolder(String name, {String? parentId}) async {
    await ref
        .read(folderRepositoryProvider)
        .createFolder(name, parentId: parentId);
    ref.invalidateSelf();
  }

  Future<void> deleteFolder(String id) async {
    await ref.read(folderRepositoryProvider).deleteFolder(id);
    ref.invalidateSelf();
  }
}
