import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/note_provider.dart';

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

    return Scaffold(
      appBar: AppBar(title: Text(title ?? 'Notes')),
      drawer: const AppDrawer(),
      body: notesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (notes) => notes.isEmpty
            ? const Center(child: Text('No notes yet'))
            : ListView.builder(
                itemCount: notes.length,
                itemBuilder: (_, i) => ListTile(
                  title: Text(notes[i].title),
                  onTap: () => context.push('/notes/${notes[i].id}'),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            final note = await ref
                .read(noteListProvider(folderId: folderId, tagId: tagId).notifier)
                .createNote(folderId: folderId);

            if (context.mounted) {
              // 1. Tunggu sampai user selesai mengisi catatan baru
              await context.push('/notes/edit/${note.id}');

              // 2. Segera refresh list folder begitu user kembali
              ref.invalidate(noteListProvider(folderId: folderId, tagId: tagId));
            }
          } catch (e) {
            // Handle error
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}