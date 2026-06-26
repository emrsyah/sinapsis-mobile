import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/note_provider.dart';
import '../../../core/editor/content_converter.dart';

import '../data/note_repository.dart';
class NoteEditorScreen extends ConsumerStatefulWidget {
  final String noteId;
  final String? initialTitle;   // Tambahkan parameter opsional
  final String? initialContent; // Tambahkan parameter opsional untuk JSON Delta

  const NoteEditorScreen({
    required this.noteId, 
    this.initialTitle, 
    this.initialContent, 
    super.key,
  });

  @override
  ConsumerState<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends ConsumerState<NoteEditorScreen> {
  late QuillController _quillController;
  late TextEditingController _titleController;
  bool _isSaving = false;
  // True when the note's stored content couldn't be parsed on this client.
  // We then keep the original content untouched on save (title-only edits).
  bool _loadFailed = false;

  @override
  void initState() {
    super.initState();
    // Inisialisasi Judul dengan data lama jika ada
    _titleController = TextEditingController(text: widget.initialTitle ?? '');

    // Muat konten: HTML (web/Tiptap) atau Delta JSON lama (mobile) -> Document.
    final parsed = ContentConverter.parse(widget.initialContent);
    _loadFailed = parsed.failed;
    _quillController = QuillController(
      document: parsed.document,
      selection: const TextSelection.collapsed(offset: 0),
      // Lock the body when we couldn't parse it, so the user can't type into an
      // empty editor and unknowingly overwrite the real (unreadable) content.
      readOnly: _loadFailed,
    );
  }

  @override
  void dispose() {
    _quillController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _saveNote() async {
    final title = _titleController.text.trim();
    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Judul tidak boleh kosong!')),
      );
      return;
    }

    setState(() => _isSaving = true);

    try {
      // Simpan sebagai HTML (format kanonik, sama dengan web/Tiptap).
      // Jika konten gagal di-parse saat dibuka, JANGAN menimpa body asli —
      // kirim ulang konten asli apa adanya agar hanya judul yang berubah.
      final contentHtml = _loadFailed
          ? (widget.initialContent ?? '')
          : ContentConverter.documentToHtml(_quillController.document);

      // SINKRONISASI DISINI:
      // Panggil updateNote sesuai positional id, diikuti named parameters title dan content
      await ref.read(noteRepositoryProvider).updateNote(
        widget.noteId, // Positional parameter id
        title: title,   // Named parameter title
        content: contentHtml, // Named parameter content
      );

      // Paksa noteDetailProvider melakukan fetch ulang data dari backend
      ref.invalidate(noteDetailProvider(widget.noteId));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Catatan berhasil diperbarui!')),
        );
        // Kembali ke layar viewer sambil membawa data terbaru
        Navigator.pop(context, {'title': title, 'content': contentHtml});
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menyimpan ke server: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.initialTitle != null ? 'Edit Note' : 'New Note'),
        actions: [
          _isSaving
              ? const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Center(child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))),
                )
              : IconButton(
                  icon: const Icon(Icons.check), // Menggunakan ikon centang untuk menandakan selesai/save
                  onPressed: _saveNote,
                ),
        ],
      ),
      body: Column(
        children: [
          if (_loadFailed)
            Container(
              width: double.infinity,
              color: Theme.of(context).colorScheme.errorContainer,
              padding: const EdgeInsets.all(12),
              child: Text(
                "This note's content can't be opened for editing here, so the "
                'body is locked to protect it. You can still rename it, or edit '
                'the content on the web app.',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onErrorContainer,
                ),
              ),
            ),
          if (!_loadFailed)
            QuillSimpleToolbar(
              controller: _quillController,
              config: const QuillSimpleToolbarConfig(),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              controller: _titleController,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              decoration: const InputDecoration(hintText: 'Title', border: InputBorder.none),
            ),
          ),
          const Divider(height: 1, thickness: 1),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: QuillEditor.basic(
                controller: _quillController,
                config: const QuillEditorConfig(placeholder: 'Start writing...'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}