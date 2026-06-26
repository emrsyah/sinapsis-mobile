import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/api/api_client.dart';
import '../../../core/api/api_endpoints.dart';
import '../../../core/api/api_parse.dart';
import '../../../models/study_tool_generation.dart';
import 'ai_client.dart';

part 'study_tool_repository.g.dart';

@riverpod
StudyToolRepository studyToolRepository(Ref ref) {
  return StudyToolRepository(
    ref.read(apiClientProvider),
    ref.read(aiClientProvider),
  );
}

class StudyToolRepository {
  final ApiClient _api;
  final AiClient _ai;
  StudyToolRepository(this._api, this._ai);

  Future<List<StudyToolGeneration>> getGenerations(
    String noteId, {
    String? type,
  }) async {
    final data = await _api.get(
      ApiEndpoints.noteStudyTools(noteId),
      params: {if (type != null) 'type': type},
    );
    return dataList(data)
        .map((e) => StudyToolGeneration.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<StudyToolGeneration> getGeneration(String id) async {
    final data = await _api.get(ApiEndpoints.studyTool(id));
    return StudyToolGeneration.fromJson(dataMap(data));
  }

  /// Generates content via the Next.js AI endpoint, then persists the result
  /// to the Laravel backend as a completed generation (mirrors the web flow).
  Future<StudyToolGeneration> generateAndSave({
    required String noteId,
    required StudyToolType type,
    required String plainText,
    Map<String, dynamic>? options,
  }) async {
    final typeName = type.name;
    final content = await _ai.generate(
      typeName,
      content: plainText,
      options: options,
    );

    final data = await _api.post(
      ApiEndpoints.noteStudyTools(noteId),
      body: {
        'note_id': noteId,
        'type': typeName,
        'content': content,
        'status': 'completed',
      },
    );
    return StudyToolGeneration.fromJson(dataMap(data));
  }
}
