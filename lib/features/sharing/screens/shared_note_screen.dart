import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/editor/content_converter.dart';
import '../../tags/widgets/tag_chip.dart';
import '../providers/sharing_provider.dart';

/// Public read-only viewer for a shared note (no auth).
class SharedNoteScreen extends ConsumerWidget {
  final String token;
  const SharedNoteScreen({required this.token, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final noteAsync = ref.watch(sharedNoteProvider(token));

    return Scaffold(
      appBar: AppBar(title: const Text('Sinapsis')),
      body: noteAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => const Center(
          child: Padding(
            padding: EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Note not found',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'This note may have been unpublished or the link is invalid.',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        data: (note) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title.isNotEmpty ? note.title : 'Untitled',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (note.tags.isNotEmpty) ...[
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: note.tags.map((t) => TagChip(tag: t)).toList(),
                ),
              ],
              const SizedBox(height: 12),
              const Divider(),
              const SizedBox(height: 8),
              _SharedContent(content: note.content),
            ],
          ),
        ),
      ),
    );
  }
}

class _SharedContent extends StatelessWidget {
  final String? content;
  const _SharedContent({required this.content});

  @override
  Widget build(BuildContext context) {
    // Renders both web-authored HTML and legacy Quill Delta JSON as rich text.
    final doc = ContentConverter.documentFromStored(content);
    final controller = QuillController(
      document: doc,
      selection: const TextSelection.collapsed(offset: 0),
      readOnly: true,
    );
    return QuillEditor.basic(
      controller: controller,
      config: const QuillEditorConfig(showCursor: false),
    );
  }
}
