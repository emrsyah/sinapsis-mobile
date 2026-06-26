import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// 1. Import file provider asli kamu (sesuaikan path foldernya)
import '../providers/note_provider.dart';
import '../../../core/editor/content_converter.dart';
import 'note_editor_screen.dart';
import '../../tags/widgets/tag_chip.dart';
import '../../tags/widgets/tag_selector_sheet.dart';
import '../../sharing/widgets/share_sheet.dart';

class NoteViewerScreen extends ConsumerStatefulWidget {
  final String noteId;
  const NoteViewerScreen({required this.noteId, super.key});

  @override
  ConsumerState<NoteViewerScreen> createState() => _NoteViewerScreenState();
}

class _NoteViewerScreenState extends ConsumerState<NoteViewerScreen> {
  QuillController? _quillController;
  String? _loadedTitle;
  String? _loadedContentJson;

  void _setupQuillController(String title, String? contentJson) {
    if (_quillController == null) {
      _loadedTitle = title;
      _loadedContentJson = contentJson ?? '';

      final doc = ContentConverter.documentFromStored(_loadedContentJson);
      _quillController = QuillController(
        document: doc,
        selection: const TextSelection.collapsed(offset: 0),
        readOnly: true,
      );
    }
  }

  Future<void> _navigateToEdit() async {
    if (_quillController == null) return;

    final result = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(
        builder: (context) => NoteEditorScreen(
          noteId: widget.noteId,
          initialTitle: _loadedTitle,
          initialContent: _loadedContentJson,
        ),
      ),
    );

    if (result != null && mounted) {
      setState(() {
        _loadedTitle = result['title']!;
        _loadedContentJson = result['content']!;

        final doc = ContentConverter.documentFromStored(_loadedContentJson);
        _quillController = QuillController(
          document: doc,
          selection: const TextSelection.collapsed(offset: 0),
          readOnly: true,
        );
      });
    }
  }

  @override
  void dispose() {
    _quillController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 3. Panggil noteDetailProvider bawaan dari file kamu dengan mengoper widget.noteId
    final noteAsync = ref.watch(noteDetailProvider(widget.noteId));

    return noteAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(child: Text('Gagal memuat catatan: $error')),
      ),
      data: (note) {
        // Inisialisasi controller menggunakan data real dari repositori kamu
        _setupQuillController(note.title, note.content);

        return Scaffold(
          appBar: AppBar(
            title: const Text('View Note'),
            
            actions: [
              PopupMenuButton<String>(
                icon: const Icon(Icons.school_outlined),
                tooltip: 'Study Tools',
                onSelected: (value) =>
                    context.push('/notes/${note.id}/study/$value'),
                itemBuilder: (_) => const [
                  PopupMenuItem(value: 'flashcard', child: Text('Flashcards')),
                  PopupMenuItem(value: 'quiz', child: Text('Quiz')),
                  PopupMenuItem(value: 'mindmap', child: Text('Mind Map')),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.attach_file),
                tooltip: 'Attachments',
                onPressed: () =>
                    context.push('/notes/${note.id}/attachments'),
              ),
              IconButton(
                icon: Icon(
                  note.isPublished ? Icons.public : Icons.ios_share,
                ),
                tooltip: 'Share',
                onPressed: () => ShareSheet.show(context, note),
              ),
              IconButton(
                icon: const Icon(Icons.label_outline),
                tooltip: 'Manage Tags',
                onPressed: () => TagSelectorSheet.show(
                  context,
                  noteId: note.id,
                  attached: note.tags,
                ),
              ),
              IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Pindahkan ke Sampah',
            onPressed: () async {
              // 1. Tampilkan dialog konfirmasi
              final confirm = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text("Hapus Catatan?"),
                  content: const Text("Catatan ini akan dipindahkan ke folder Sampah."),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx, false),
                      child: const Text("Batal"),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(ctx, true),
                      child: const Text("Hapus", style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              );

              if (confirm == true && context.mounted) {
                // 2. Pindahkan catatan ke sampah lewat provider utama
                await ref
                    .read(noteListProvider(inTrash: false).notifier)
                    .trashNote(note.id);

                // 3. SOLUSI UTAMA: Paksa Riverpod untuk memperbarui data di folder sampah
                // Ini akan memicu fungsi ambil data ulang (fetch) pada TrashScreen
                ref.invalidate(noteListProvider(inTrash: true)); 

                // 4. Kembali ke halaman list utama
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Catatan dipindahkan ke Sampah")),
                  );
                }
              }
            },
              ),
      
              IconButton(
                icon: const Icon(Icons.edit_note),
                tooltip: 'Edit Note',
                onPressed: _navigateToEdit,
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _loadedTitle ?? note.title,
                  style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                if (note.tags.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: note.tags
                        .map((t) => TagChip(tag: t))
                        .toList(),
                  ),
                ],
                const SizedBox(height: 8),
                const Divider(thickness: 1),
                const SizedBox(height: 8),
                Expanded(
                  child: QuillEditor.basic(
                    controller: _quillController!,
                    config: const QuillEditorConfig(
                      scrollable: true,
                      autoFocus: false,
                      expands: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}