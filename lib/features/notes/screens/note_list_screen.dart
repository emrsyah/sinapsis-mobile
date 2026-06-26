import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/ui/ui_helpers.dart';
import '../../../models/folder.dart';
import '../../folders/providers/folder_provider.dart';
import '../providers/note_provider.dart';
import '../widgets/new_note_sheet.dart';
import '../widgets/note_card.dart';

import '../../../core/shell/app_drawer.dart';

class NoteListScreen extends ConsumerWidget {
  final String? folderId;
  final String? tagId;
  final String? title;

  const NoteListScreen({super.key, this.folderId, this.tagId, this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notesAsync =
        ref.watch(noteListProvider(folderId: folderId, tagId: tagId));
    final folders =
        ref.watch(folderListProvider).value ?? const <Folder>[];
    final folderById = {for (final f in folders) f.id: f};
    final headerLabel = folderId != null ? folderById[folderId]?.name : null;

    return Scaffold(
      appBar: AppBar(title: Text(title ?? headerLabel ?? 'Notes')),
      drawer: const AppDrawer(),
      drawerEdgeDragWidth: 80,
      body: notesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (notes) {
          if (notes.isEmpty) {
            return Center(
              child: Text(
                'No notes yet',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(
                noteListProvider(folderId: folderId, tagId: tagId),
              );
              await ref.read(
                noteListProvider(folderId: folderId, tagId: tagId).future,
              );
            },
            child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
            itemCount: notes.length,
            itemBuilder: (_, i) {
              final note = notes[i];
              final folder =
                  note.folderId == null ? null : folderById[note.folderId];
              return NoteCard(
                note: note,
                categoryLabel: folder?.name ?? headerLabel,
                categoryColor: categoryColorFor(note.folderId ?? folderId),
                onTap: () async {
                  await context.push('/notes/${note.id}');
                  ref.invalidate(
                    noteListProvider(folderId: folderId, tagId: tagId),
                  );
                },
              );
            },
          ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showNewNoteSheet(context, folderId: folderId),
        child: const Icon(Icons.add),
      ),
    );
  }
}
