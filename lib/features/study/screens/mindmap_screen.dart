import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/study_tool_generation.dart';
import '../widgets/study_tool_view.dart';

class MindmapScreen extends ConsumerWidget {
  final String noteId;
  final String? generationId;
  const MindmapScreen({required this.noteId, this.generationId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StudyToolView(
      noteId: noteId,
      type: StudyToolType.mindmap,
      title: 'Mind Map',
      contentBuilder: (generation) {
        final content = generation.content;
        if (content is! MindmapStudyContent) {
          return const Center(child: Text('Invalid mind map content'));
        }
        final data = content.data;
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Root node
            Card(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  data.root,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
            const SizedBox(height: 8),
            ...data.children.map((node) => _MindMapNodeTile(node: node, depth: 0)),
          ],
        );
      },
    );
  }
}

class _MindMapNodeTile extends StatelessWidget {
  final MindMapNode node;
  final int depth;
  const _MindMapNodeTile({required this.node, required this.depth});

  @override
  Widget build(BuildContext context) {
    final indent = depth * 16.0;
    if (node.children.isEmpty) {
      return Padding(
        padding: EdgeInsets.only(left: indent + 16, top: 4, bottom: 4),
        child: Row(
          children: [
            const Icon(Icons.circle, size: 8),
            const SizedBox(width: 8),
            Expanded(child: Text(node.label)),
          ],
        ),
      );
    }
    return Padding(
      padding: EdgeInsets.only(left: indent),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: depth < 1,
          tilePadding: const EdgeInsets.symmetric(horizontal: 8),
          title: Text(
            node.label,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          childrenPadding: EdgeInsets.zero,
          children: node.children
              .map((c) => _MindMapNodeTile(node: c, depth: depth + 1))
              .toList(),
        ),
      ),
    );
  }
}
