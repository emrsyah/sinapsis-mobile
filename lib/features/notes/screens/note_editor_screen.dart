import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/note_provider.dart';

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

  @override
  void initState() {
    super.initState();
    // Inisialisasi Judul dengan data lama jika ada
    _titleController = TextEditingController(text: widget.initialTitle ?? '');

    // Inisialisasi Konten Quill dengan data JSON lama jika ada
    if (widget.initialContent != null && widget.initialContent!.isNotEmpty) {
      try {
        final doc = Document.fromJson(jsonDecode(widget.initialContent!));
        _quillController = QuillController(
          document: doc,
          selection: const TextSelection.collapsed(offset: 0),
        );
      } catch (e) {
        // Fallback jika format JSON bermasalah
        _quillController = QuillController.basic();
      }
    } else {
      _quillController = QuillController.basic();
    }
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
      // Ubah dokumen dokumen Quill menjadi string JSON Delta
      final contentJson = jsonEncode(_quillController.document.toDelta().toJson());
      
      // SINKRONISASI DISINI: 
      // Panggil updateNote sesuai positional id, diikuti named parameters title dan content
      await ref.read(noteRepositoryProvider).updateNote(
        widget.noteId, // Positional parameter id
        title: title,   // Named parameter title
        content: contentJson, // Named parameter content
      );

      // Paksa noteDetailProvider melakukan fetch ulang data dari backend
      ref.invalidate(noteDetailProvider(widget.noteId));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Catatan berhasil diperbarui!')),
        );
        // Kembali ke layar viewer sambil membawa data terbaru
        Navigator.pop(context, {'title': title, 'content': contentJson});
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