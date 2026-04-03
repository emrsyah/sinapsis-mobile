import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/api/api_client.dart';
import '../../../core/api/api_endpoints.dart';
import '../../../models/study_tool_generation.dart';

part 'study_tool_repository.g.dart';

@riverpod
StudyToolRepository studyToolRepository(Ref ref) {
  return StudyToolRepository(ref.read(apiClientProvider));
}

class StudyToolRepository {
  final ApiClient _api;
  StudyToolRepository(this._api);

  Future<List<StudyToolGeneration>> getGenerations(
    String noteId, {
    String? type,
  }) async {
    final data =
        await _api.get(
              ApiEndpoints.noteStudyTools(noteId),
              params: {if (type != null) 'type': type},
            )
            as Map<String, dynamic>;
    return (data['data'] as List)
        .map((e) => StudyToolGeneration.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<StudyToolGeneration> getGeneration(String id) async {
    final data =
        await _api.get(ApiEndpoints.studyTool(id)) as Map<String, dynamic>;
    return StudyToolGeneration.fromJson(data['data'] as Map<String, dynamic>);
  }
}
