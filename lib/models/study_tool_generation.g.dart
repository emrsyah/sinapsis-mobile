// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_tool_generation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FlashCard _$FlashCardFromJson(Map<String, dynamic> json) => _FlashCard(
  question: json['question'] as String,
  answer: json['answer'] as String,
);

Map<String, dynamic> _$FlashCardToJson(_FlashCard instance) =>
    <String, dynamic>{'question': instance.question, 'answer': instance.answer};

_FlashcardContent _$FlashcardContentFromJson(Map<String, dynamic> json) =>
    _FlashcardContent(
      cards:
          (json['cards'] as List<dynamic>)
              .map((e) => FlashCard.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$FlashcardContentToJson(_FlashcardContent instance) =>
    <String, dynamic>{'cards': instance.cards};

_QuizQuestion _$QuizQuestionFromJson(Map<String, dynamic> json) =>
    _QuizQuestion(
      question: json['question'] as String,
      options:
          (json['options'] as List<dynamic>).map((e) => e as String).toList(),
      correctIndex: (json['correct_index'] as num).toInt(),
      explanation: json['explanation'] as String,
    );

Map<String, dynamic> _$QuizQuestionToJson(_QuizQuestion instance) =>
    <String, dynamic>{
      'question': instance.question,
      'options': instance.options,
      'correct_index': instance.correctIndex,
      'explanation': instance.explanation,
    };

_QuizContent _$QuizContentFromJson(Map<String, dynamic> json) => _QuizContent(
  questions:
      (json['questions'] as List<dynamic>)
          .map((e) => QuizQuestion.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$QuizContentToJson(_QuizContent instance) =>
    <String, dynamic>{'questions': instance.questions};

_MindMapNode _$MindMapNodeFromJson(Map<String, dynamic> json) => _MindMapNode(
  label: json['label'] as String,
  children:
      (json['children'] as List<dynamic>?)
          ?.map((e) => MindMapNode.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$MindMapNodeToJson(_MindMapNode instance) =>
    <String, dynamic>{'label': instance.label, 'children': instance.children};

_MindmapContent _$MindmapContentFromJson(Map<String, dynamic> json) =>
    _MindmapContent(
      root: json['root'] as String,
      children:
          (json['children'] as List<dynamic>?)
              ?.map((e) => MindMapNode.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      imageUrl: json['image_url'] as String?,
    );

Map<String, dynamic> _$MindmapContentToJson(_MindmapContent instance) =>
    <String, dynamic>{
      'root': instance.root,
      'children': instance.children,
      'image_url': instance.imageUrl,
    };
