import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/shell/app_drawer.dart';
import '../providers/note_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // We could pass specific parameters to filter recent if the provider supported it,
    // but for now we'll fetch all notes.
    final notesAsync = ref.watch(noteListProvider());

    return Scaffold(
      appBar: AppBar(title: const Text('Recent Notes')),
      drawer: const AppDrawer(),
      body: notesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (notes) {
          if (notes.isEmpty) {
            return const Center(child: Text('No notes yet. Create one!'));
          }

          // Sort by updated at descending if possible
          final sortedNotes = List.of(notes)
            ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: sortedNotes.length,
            itemBuilder: (_, i) {
              final note = sortedNotes[i];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.grey.shade200),
                ),
                child: InkWell(
                  onTap: () => context.push('/notes/${note.id}'),
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          note.title.isNotEmpty ? note.title : 'Untitled Note',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Last updated: ${DateTime.parse(note.updatedAt).toLocal().toString().split('.')[0]}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final note = await ref.read(noteListProvider().notifier).createNote();
          if (context.mounted) context.push('/notes/${note.id}');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
