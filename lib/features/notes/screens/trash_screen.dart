import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/shell/app_drawer.dart';
import '../providers/note_provider.dart';

class TrashScreen extends ConsumerWidget {
  const TrashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Ganti menjadi inTrash: true
    final trashNotesAsync = ref.watch(noteListProvider(inTrash: true));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trash'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(noteListProvider(inTrash: true)),
          )
        ],
      ),
      drawer: const AppDrawer(),
      body: trashNotesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SelectableText(
              'Gagal memuat data sampah:\n$error',
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ),
        data: (notes) {
          if (notes.isEmpty) {
            return const Center(
              child: Text('Tempat sampah kosong.'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: notes.length,
            itemBuilder: (context, i) {
              final note = notes[i];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  // Menampilkan judul saja
                  title: Text(note.title.isNotEmpty ? note.title : 'Untitled Note'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Tombol Pulihkan Catatan
                      IconButton(
                        icon: const Icon(Icons.restore, color: Colors.green),
                        onPressed: () async {
                          await ref
                              .read(noteListProvider(inTrash: true).notifier)
                              .restoreNote(note.id);
                          
                          // Segarkan halaman utama (inTrash: false)
                          ref.invalidate(noteListProvider(inTrash: false));
                        },
                      ),
                      // Tombol Hapus Permanen
                      IconButton(
                        icon: const Icon(Icons.delete_forever, color: Colors.red),
                        onPressed: () => _showDeleteDialog(context, ref, note.id),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, WidgetRef ref, String noteId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus Permanen?'),
        content: const Text('Tindakan ini tidak dapat dibatalkan. Catatan akan hilang selamanya.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await ref
                  .read(noteListProvider(inTrash: true).notifier)
                  .deleteNotePermanently(noteId);
            },
            child: const Text('Hapus', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}