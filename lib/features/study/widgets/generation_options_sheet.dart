import 'package:flutter/material.dart';
import '../../../models/study_tool_generation.dart';

/// Bottom sheet to configure a study-tool generation. Returns the options map
/// to send to the AI endpoint, or null if cancelled.
class GenerationOptionsSheet extends StatefulWidget {
  final StudyToolType type;
  const GenerationOptionsSheet({super.key, required this.type});

  static Future<Map<String, dynamic>?> show(
    BuildContext context,
    StudyToolType type,
  ) {
    return showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => GenerationOptionsSheet(type: type),
    );
  }

  @override
  State<GenerationOptionsSheet> createState() => _GenerationOptionsSheetState();
}

class _GenerationOptionsSheetState extends State<GenerationOptionsSheet> {
  // Shared
  final _focusController = TextEditingController();

  // Flashcard / Quiz
  double _amount = 6;
  String _answerStyle = 'concise';
  String _difficulty = 'medium';

  // Mindmap
  double _branchCount = 5;
  String _depth = 'balanced';

  bool get _isMindmap => widget.type == StudyToolType.mindmap;
  bool get _isQuiz => widget.type == StudyToolType.quiz;
  bool get _isFlashcard => widget.type == StudyToolType.flashcard;

  @override
  void dispose() {
    _focusController.dispose();
    super.dispose();
  }

  Map<String, dynamic> _buildOptions() {
    final focus = _focusController.text.trim();
    return {
      if (_isFlashcard) ...{
        'amount': _amount.round(),
        'answerStyle': _answerStyle,
      },
      if (_isQuiz) ...{
        'amount': _amount.round(),
        'difficulty': _difficulty,
      },
      if (_isMindmap) ...{
        'branchCount': _branchCount.round(),
        'depth': _depth,
      },
      if (focus.isNotEmpty) 'focus': focus,
    };
  }

  @override
  Widget build(BuildContext context) {
    final title = switch (widget.type) {
      StudyToolType.flashcard => 'Generate Flashcards',
      StudyToolType.quiz => 'Generate Quiz',
      StudyToolType.mindmap => 'Generate Mind Map',
    };

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          16,
          8,
          16,
          16 + MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),

            // Amount (flashcard/quiz) or Branch count (mindmap)
            if (_isMindmap) ...[
              Text('Branches: ${_branchCount.round()}'),
              Slider(
                value: _branchCount,
                min: 2,
                max: 10,
                divisions: 8,
                label: '${_branchCount.round()}',
                onChanged: (v) => setState(() => _branchCount = v),
              ),
            ] else ...[
              Text('Amount: ${_amount.round()}'),
              Slider(
                value: _amount,
                min: 3,
                max: 20,
                divisions: 17,
                label: '${_amount.round()}',
                onChanged: (v) => setState(() => _amount = v),
              ),
            ],
            const SizedBox(height: 8),

            // Type-specific choice
            if (_isFlashcard)
              _ChoiceRow(
                label: 'Answer style',
                value: _answerStyle,
                options: const ['concise', 'detailed'],
                onChanged: (v) => setState(() => _answerStyle = v),
              ),
            if (_isQuiz)
              _ChoiceRow(
                label: 'Difficulty',
                value: _difficulty,
                options: const ['easy', 'medium', 'hard'],
                onChanged: (v) => setState(() => _difficulty = v),
              ),
            if (_isMindmap)
              _ChoiceRow(
                label: 'Depth',
                value: _depth,
                options: const ['overview', 'balanced', 'detailed'],
                onChanged: (v) => setState(() => _depth = v),
              ),
            const SizedBox(height: 16),

            TextField(
              controller: _focusController,
              decoration: const InputDecoration(
                labelText: 'Focus (optional)',
                hintText: 'e.g. definitions, key dates',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                icon: const Icon(Icons.auto_awesome),
                label: const Text('Generate'),
                onPressed: () => Navigator.pop(context, _buildOptions()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChoiceRow extends StatelessWidget {
  final String label;
  final String value;
  final List<String> options;
  final ValueChanged<String> onChanged;

  const _ChoiceRow({
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: options.map((o) {
            return ChoiceChip(
              label: Text(o),
              selected: value == o,
              onSelected: (_) => onChanged(o),
            );
          }).toList(),
        ),
      ],
    );
  }
}
