import 'package:freezed_annotation/freezed_annotation.dart';

part 'study_tool_generation.freezed.dart';
part 'study_tool_generation.g.dart';

// ── Content sealed classes ────────────────────────────────────

@freezed
abstract class FlashCard with _$FlashCard {
  const factory FlashCard({required String question, required String answer}) =
      _FlashCard;

  factory FlashCard.fromJson(Map<String, dynamic> json) =>
      _$FlashCardFromJson(json);
}

@freezed
abstract class FlashcardContent with _$FlashcardContent {
  const factory FlashcardContent({required List<FlashCard> cards}) =
      _FlashcardContent;

  factory FlashcardContent.fromJson(Map<String, dynamic> json) =>
      _$FlashcardContentFromJson(json);
}

@freezed
abstract class QuizQuestion with _$QuizQuestion {
  const factory QuizQuestion({
    required String question,
    required List<String> options,
    @JsonKey(name: 'correct_index') required int correctIndex,
    required String explanation,
  }) = _QuizQuestion;

  factory QuizQuestion.fromJson(Map<String, dynamic> json) =>
      _$QuizQuestionFromJson(json);
}

@freezed
abstract class QuizContent with _$QuizContent {
  const factory QuizContent({required List<QuizQuestion> questions}) =
      _QuizContent;

  factory QuizContent.fromJson(Map<String, dynamic> json) =>
      _$QuizContentFromJson(json);
}

@freezed
abstract class MindMapNode with _$MindMapNode {
  const factory MindMapNode({
    required String label,
    @Default([]) List<MindMapNode> children,
  }) = _MindMapNode;

  factory MindMapNode.fromJson(Map<String, dynamic> json) =>
      _$MindMapNodeFromJson(json);
}

@freezed
abstract class MindmapContent with _$MindmapContent {
  const factory MindmapContent({
    required String root,
    @Default([]) List<MindMapNode> children,
    @JsonKey(name: 'image_url') String? imageUrl,
  }) = _MindmapContent;

  factory MindmapContent.fromJson(Map<String, dynamic> json) =>
      _$MindmapContentFromJson(json);
}

// ── Sealed study tool content ─────────────────────────────────

sealed class StudyToolContent {
  const StudyToolContent();

  factory StudyToolContent.fromJson(String type, Map<String, dynamic> json) {
    return switch (type) {
      'flashcard' => FlashcardStudyContent(FlashcardContent.fromJson(json)),
      'quiz' => QuizStudyContent(QuizContent.fromJson(json)),
      'mindmap' => MindmapStudyContent(MindmapContent.fromJson(json)),
      _ => throw ArgumentError('Unknown study tool type: $type'),
    };
  }
}

class FlashcardStudyContent extends StudyToolContent {
  final FlashcardContent data;
  const FlashcardStudyContent(this.data);
}

class QuizStudyContent extends StudyToolContent {
  final QuizContent data;
  const QuizStudyContent(this.data);
}

class MindmapStudyContent extends StudyToolContent {
  final MindmapContent data;
  const MindmapStudyContent(this.data);
}

// ── Main model ────────────────────────────────────────────────

enum StudyToolType { flashcard, quiz, mindmap }

enum StudyToolStatus { pending, completed, failed }

class StudyToolGeneration {
  final String id;
  final String noteId;
  final String userId;
  final StudyToolType type;
  final StudyToolContent content;
  final String? imageUrl;
  final StudyToolStatus status;
  final String createdAt;

  const StudyToolGeneration({
    required this.id,
    required this.noteId,
    required this.userId,
    required this.type,
    required this.content,
    this.imageUrl,
    required this.status,
    required this.createdAt,
  });

  factory StudyToolGeneration.fromJson(Map<String, dynamic> json) {
    final typeStr = json['type'] as String;
    final contentJson = json['content'] as Map<String, dynamic>;

    return StudyToolGeneration(
      id: json['id'] as String,
      noteId: json['note_id'] as String,
      userId: json['user_id'] as String,
      type: StudyToolType.values.byName(typeStr),
      content: StudyToolContent.fromJson(typeStr, contentJson),
      imageUrl: json['image_url'] as String?,
      status: StudyToolStatus.values.byName(json['status'] as String),
      createdAt: json['created_at'] as String,
    );
  }
}
