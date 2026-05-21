import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/shell/app_drawer.dart';
import '../providers/note_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notesAsync = ref.watch(noteListProvider());
    

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sinapsis'),
      ),
      drawer: const AppDrawer(),
      body: notesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (notes) {
          final sortedNotes = List.of(notes)
            ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Text(
                  _getGreeting(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: sortedNotes.isEmpty
                    ? const Center(child: Text('No notes yet. Create one!'))
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: sortedNotes.length,
                        itemBuilder: (_, i) {
                          final note = sortedNotes[i];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(color: Colors.grey.shade800),
                            ),
                            child: InkWell(
                              onTap: () async {
                                // 1. Tunggu proses melihat/mengedit catatan selesai
                                await context.push('/notes/${note.id}');
                                
                                // 2. Begitu menekan tombol kembali, langsung update daftarnya
                                ref.invalidate(noteListProvider());
                              },
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
                                    Builder(
                                      builder: (_) {
                                        final updatedAt = DateTime.parse(note.updatedAt);
                                        final updatedStr = updatedAt.toLocal().toString().split('.')[0];

                                        return Text(
                                          'Last updated: $updatedStr',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey.shade400,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            // 1. Buat catatan baru kosong di backend
            final note = await ref.read(noteListProvider().notifier).createNote();
            
            if (context.mounted) {
              // 2. Tunggu proses pengisian catatan di halaman editor sampai selesai
              await context.push('/notes/edit/${note.id}');
              
              // 3. Begitu kembali dari halaman editor, segarkan list catatan di home screen
              ref.invalidate(noteListProvider());
            }
          } catch (e) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Gagal membuat catatan: $e')),
              );
            }
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}