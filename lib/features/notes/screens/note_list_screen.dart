import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/note_provider.dart';

import '../../../core/shell/app_drawer.dart';

class NoteListScreen extends ConsumerWidget {
  final String? folderId;

  const NoteListScreen({super.key, this.folderId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notesAsync = ref.watch(noteListProvider(folderId: folderId));
    
    return Scaffold(
      appBar: AppBar(title: const Text('Notes')),
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
                .read(noteListProvider(folderId: folderId).notifier)
                .createNote(folderId: folderId);
                
            if (context.mounted) {
              // 1. Tunggu sampai user selesai mengisi catatan baru
              await context.push('/notes/edit/${note.id}');
              
              // 2. Segera refresh list folder begitu user kembali
              ref.invalidate(noteListProvider(folderId: folderId));
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