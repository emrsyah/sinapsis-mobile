import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../models/study_tool_generation.dart';
import '../data/study_tool_repository.dart';

part 'study_tool_provider.g.dart';

@riverpod
Future<List<StudyToolGeneration>> studyToolList(
  Ref ref,
  String noteId, {
  String? type,
}) {
  return ref
      .read(studyToolRepositoryProvider)
      .getGenerations(noteId, type: type);
}

@riverpod
Future<StudyToolGeneration> studyToolDetail(Ref ref, String id) {
  return ref.read(studyToolRepositoryProvider).getGeneration(id);
}
