import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/editor/note_text.dart';
import '../../../models/study_tool_generation.dart';
import '../../notes/providers/note_provider.dart';
import '../data/study_tool_repository.dart';
import '../providers/study_tool_provider.dart';
import 'generation_options_sheet.dart';

/// Shared scaffold for the three study-tool screens. Handles fetching the
/// latest generation, the generate/regenerate flow, and loading/empty states.
/// [contentBuilder] renders the actual viewer for a completed generation.
class StudyToolView extends ConsumerStatefulWidget {
  final String noteId;
  final StudyToolType type;
  final String title;
  final Widget Function(StudyToolGeneration generation) contentBuilder;

  const StudyToolView({
    super.key,
    required this.noteId,
    required this.type,
    required this.title,
    required this.contentBuilder,
  });

  @override
  ConsumerState<StudyToolView> createState() => _StudyToolViewState();
}

class _StudyToolViewState extends ConsumerState<StudyToolView> {
  bool _generating = false;

  Future<void> _generate() async {
    final options = await GenerationOptionsSheet.show(context, widget.type);
    if (options == null || !mounted) return;

    // Pull the note's text to feed the AI.
    final note = await ref.read(noteDetailProvider(widget.noteId).future);
    final plainText = noteContentToPlainText(note.content);
    if (plainText.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Note has no content to generate from.')),
        );
      }
      return;
    }

    setState(() => _generating = true);
    try {
      await ref.read(studyToolRepositoryProvider).generateAndSave(
            noteId: widget.noteId,
            type: widget.type,
            plainText: plainText,
            options: options,
          );
      ref.invalidate(
        studyToolListProvider(widget.noteId, type: widget.type.name),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Generation failed: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _generating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final listAsync = ref.watch(
      studyToolListProvider(widget.noteId, type: widget.type.name),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.auto_awesome),
            tooltip: 'Generate',
            onPressed: _generating ? null : _generate,
          ),
        ],
      ),
      body: _generating
          ? const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Generating with AI...'),
                ],
              ),
            )
          : listAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
              data: (generations) {
                if (generations.isEmpty) {
                  return _EmptyState(title: widget.title, onGenerate: _generate);
                }
                return widget.contentBuilder(generations.first);
              },
            ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final String title;
  final VoidCallback onGenerate;
  const _EmptyState({required this.title, required this.onGenerate});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.auto_awesome, size: 48),
            const SizedBox(height: 16),
            Text(
              'No $title yet',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Generate'),
              onPressed: onGenerate,
            ),
          ],
        ),
      ),
    );
  }
}
