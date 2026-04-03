import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/api/api_client.dart';
import '../../../core/api/api_endpoints.dart';
import '../../../models/folder.dart';

part 'folder_repository.g.dart';

@riverpod
FolderRepository folderRepository(Ref ref) {
  return FolderRepository(ref.read(apiClientProvider));
}

class FolderRepository {
  final ApiClient _api;
  FolderRepository(this._api);

  Future<List<Folder>> getFolders() async {
    final data = await _api.get(ApiEndpoints.folders) as Map<String, dynamic>;
    return (data['data'] as List)
        .map((e) => Folder.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<Folder> createFolder(String name, {String? parentId}) async {
    final data =
        await _api.post(
              ApiEndpoints.folders,
              body: {'name': name, if (parentId != null) 'parent_id': parentId},
            )
            as Map<String, dynamic>;
    return Folder.fromJson(data['data'] as Map<String, dynamic>);
  }

  Future<Folder> updateFolder(
    String id, {
    String? name,
    String? parentId,
  }) async {
    final data =
        await _api.patch(
              ApiEndpoints.folder(id),
              body: {
                if (name != null) 'name': name,
                if (parentId != null) 'parent_id': parentId,
              },
            )
            as Map<String, dynamic>;
    return Folder.fromJson(data['data'] as Map<String, dynamic>);
  }

  Future<void> deleteFolder(String id) async {
    await _api.delete(ApiEndpoints.folder(id));
  }
}
