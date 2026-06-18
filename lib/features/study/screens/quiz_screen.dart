import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/study_tool_generation.dart';
import '../widgets/study_tool_view.dart';

class QuizScreen extends ConsumerWidget {
  final String noteId;
  final String? generationId;
  const QuizScreen({required this.noteId, this.generationId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StudyToolView(
      noteId: noteId,
      type: StudyToolType.quiz,
      title: 'Quiz',
      contentBuilder: (generation) {
        final content = generation.content;
        if (content is! QuizStudyContent) {
          return const Center(child: Text('Invalid quiz content'));
        }
        final questions = content.data.questions;
        if (questions.isEmpty) {
          return const Center(child: Text('No questions generated'));
        }
        // Rebuild a fresh quiz per generation id.
        return _QuizRunner(key: ValueKey(generation.id), questions: questions);
      },
    );
  }
}

class _QuizRunner extends StatefulWidget {
  final List<QuizQuestion> questions;
  const _QuizRunner({super.key, required this.questions});

  @override
  State<_QuizRunner> createState() => _QuizRunnerState();
}

class _QuizRunnerState extends State<_QuizRunner> {
  // selected option index per question (null = unanswered)
  late final List<int?> _answers = List.filled(widget.questions.length, null);
  bool _submitted = false;

  int get _score {
    var score = 0;
    for (var i = 0; i < widget.questions.length; i++) {
      if (_answers[i] == widget.questions[i].correctIndex) score++;
    }
    return score;
  }

  bool get _allAnswered => !_answers.contains(null);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_submitted)
          Container(
            width: double.infinity,
            color: Theme.of(context).colorScheme.primaryContainer,
            padding: const EdgeInsets.all(16),
            child: Text(
              'Score: $_score / ${widget.questions.length}',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
          ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: widget.questions.length,
            itemBuilder: (_, i) => _QuestionCard(
              index: i,
              question: widget.questions[i],
              selected: _answers[i],
              submitted: _submitted,
              onSelect: _submitted
                  ? null
                  : (opt) => setState(() => _answers[i] = opt),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            child: _submitted
                ? OutlinedButton(
                    onPressed: () => setState(() {
                      _submitted = false;
                      for (var i = 0; i < _answers.length; i++) {
                        _answers[i] = null;
                      }
                    }),
                    child: const Text('Retry'),
                  )
                : FilledButton(
                    onPressed: _allAnswered
                        ? () => setState(() => _submitted = true)
                        : null,
                    child: Text(
                      _allAnswered ? 'Submit' : 'Answer all questions',
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}

class _QuestionCard extends StatelessWidget {
  final int index;
  final QuizQuestion question;
  final int? selected;
  final bool submitted;
  final ValueChanged<int>? onSelect;

  const _QuestionCard({
    required this.index,
    required this.question,
    required this.selected,
    required this.submitted,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Q${index + 1}. ${question.question}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            ...List.generate(question.options.length, (o) {
              final isSelected = selected == o;
              final isCorrect = o == question.correctIndex;
              Color? tileColor;
              if (submitted) {
                if (isCorrect) {
                  tileColor = Colors.green.withValues(alpha: 0.2);
                } else if (isSelected) {
                  tileColor = scheme.errorContainer;
                }
              } else if (isSelected) {
                tileColor = scheme.secondaryContainer;
              }
              return Card(
                elevation: 0,
                color: tileColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: scheme.outlineVariant),
                ),
                child: ListTile(
                  dense: true,
                  title: Text(question.options[o]),
                  leading: Icon(
                    isSelected
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked,
                  ),
                  trailing: submitted && isCorrect
                      ? const Icon(Icons.check, color: Colors.green)
                      : null,
                  onTap: onSelect == null ? null : () => onSelect!(o),
                ),
              );
            }),
            if (submitted) ...[
              const SizedBox(height: 8),
              Text(
                'Explanation: ${question.explanation}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
