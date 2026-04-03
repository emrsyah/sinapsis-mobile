import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/note_provider.dart';

class NoteListScreen extends ConsumerWidget {
  const NoteListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notesAsync = ref.watch(noteListProvider());
    return Scaffold(
      appBar: AppBar(title: const Text('Notes')),
      body: notesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data:
            (notes) =>
                notes.isEmpty
                    ? const Center(child: Text('No notes yet'))
                    : ListView.builder(
                      itemCount: notes.length,
                      itemBuilder:
                          (_, i) => ListTile(
                            title: Text(notes[i].title),
                            onTap: () => context.go('/notes/${notes[i].id}'),
                          ),
                    ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final note =
              await ref.read(noteListProvider().notifier).createNote();
          if (context.mounted) context.go('/notes/${note.id}');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
