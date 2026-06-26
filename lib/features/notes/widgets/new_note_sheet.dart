import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/editor/content_converter.dart';
import '../../../core/ui/ui_helpers.dart';
import '../../../models/tag.dart';
import '../../tags/data/tag_repository.dart';
import '../../tags/providers/tag_provider.dart';
import '../data/note_repository.dart';
import '../providers/note_provider.dart';

/// Opens the quick-capture "New note" sheet. Starts as a partial bottom sheet
/// and can be dragged up to (near) full screen.
Future<void> showNewNoteSheet(
  BuildContext context, {
  String? folderId,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _NewNoteSheet(folderId: folderId),
  );
}

class _NewNoteSheet extends ConsumerStatefulWidget {
  final String? folderId;
  const _NewNoteSheet({this.folderId});

  @override
  ConsumerState<_NewNoteSheet> createState() => _NewNoteSheetState();
}

class _NewNoteSheetState extends ConsumerState<_NewNoteSheet> {
  final _titleController = TextEditingController();
  final _quillController = QuillController.basic();
  final _selectedTagIds = <String>{};
  bool _saving = false;

  @override
  void dispose() {
    _titleController.dispose();
    _quillController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_saving) return;
    setState(() => _saving = true);
    final messenger = ScaffoldMessenger.of(context);
    try {
      final title = _titleController.text.trim();
      final html = ContentConverter.documentToHtml(_quillController.document);
      final repo = ref.read(noteRepositoryProvider);

      final note = await repo.createNote(
        title: title.isEmpty ? 'Untitled' : title,
        folderId: widget.folderId,
      );
      await repo.updateNote(note.id, content: html);
      for (final tagId in _selectedTagIds) {
        await ref.read(tagRepositoryProvider).attachTag(note.id, tagId);
      }
      ref.invalidate(noteListProvider);
      if (mounted) Navigator.pop(context);
    } catch (e) {
      setState(() => _saving = false);
      messenger.showSnackBar(SnackBar(content: Text('Failed to save: $e')));
    }
  }

  Future<void> _pickTags() async {
    final tags = ref.read(tagListProvider).value ?? const <Tag>[];
    if (tags.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No tags yet — create some in Tags.')),
      );
      return;
    }
    final local = Set<String>.from(_selectedTagIds);
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSheet) => SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Add tags',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
              ...tags.map(
                (t) => CheckboxListTile(
                  value: local.contains(t.id),
                  onChanged: (v) => setSheet(() {
                    if (v == true) {
                      local.add(t.id);
                    } else {
                      local.remove(t.id);
                    }
                  }),
                  secondary: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: categoryColorFor(t.id),
                      shape: BoxShape.circle,
                    ),
                  ),
                  title: Text(t.name),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
    setState(() {
      _selectedTagIds
        ..clear()
        ..addAll(local);
    });
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final allTags = ref.watch(tagListProvider).value ?? const <Tag>[];
    final selectedTags =
        allTags.where((t) => _selectedTagIds.contains(t.id)).toList();

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: DraggableScrollableSheet(
        initialChildSize: 0.62,
        minChildSize: 0.45,
        maxChildSize: 0.95,
        expand: false,
        snap: true,
        snapSizes: const [0.62, 0.95],
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: const Color(0xFF111111),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              border: Border.all(color: scheme.outline),
            ),
            child: Column(
              children: [
                // Drag handle
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 6),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: scheme.outline,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                // Header
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
                  child: Row(
                    children: [
                      TextButton(
                        onPressed: _saving ? null : () => Navigator.pop(context),
                        style: TextButton.styleFrom(
                          foregroundColor: scheme.onSurfaceVariant,
                        ),
                        child: const Text('Cancel'),
                      ),
                      const Spacer(),
                      const Text(
                        'New note',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Spacer(),
                      FilledButton(
                        onPressed: _saving ? null : _save,
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 8,
                          ),
                          minimumSize: const Size(0, 36),
                        ),
                        child: _saving
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Text('Save'),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                // Body (scrollable, draggable)
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: _titleController,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Title',
                            border: InputBorder.none,
                            filled: false,
                            isDense: true,
                            hintStyle: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Tag row
                        Wrap(
                          spacing: 8,
                          runSpacing: 6,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            for (final t in selectedTags)
                              Chip(
                                label: Text(t.name),
                                avatar: CircleAvatar(
                                  radius: 5,
                                  backgroundColor: categoryColorFor(t.id),
                                ),
                                onDeleted: () => setState(
                                  () => _selectedTagIds.remove(t.id),
                                ),
                              ),
                            ActionChip(
                              avatar: const Icon(Icons.add, size: 16),
                              label: const Text('Add tag'),
                              onPressed: _pickTags,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        ConstrainedBox(
                          constraints: const BoxConstraints(minHeight: 220),
                          child: QuillEditor.basic(
                            controller: _quillController,
                            config: const QuillEditorConfig(
                              placeholder: 'Start writing...',
                              scrollable: false,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Bottom toolbar (essentials)
                Container(
                  decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: scheme.outline)),
                  ),
                  child: QuillSimpleToolbar(
                    controller: _quillController,
                    config: const QuillSimpleToolbarConfig(
                      multiRowsDisplay: false,
                      showFontFamily: false,
                      showFontSize: false,
                      showSubscript: false,
                      showSuperscript: false,
                      showInlineCode: false,
                      showColorButton: false,
                      showBackgroundColorButton: false,
                      showClearFormat: false,
                      showCodeBlock: false,
                      showSearchButton: false,
                      showIndent: false,
                      showStrikeThrough: false,
                      showAlignmentButtons: false,
                      showDividers: false,
                      showUndo: false,
                      showRedo: false,
                      showBoldButton: true,
                      showItalicButton: true,
                      showUnderLineButton: true,
                      showHeaderStyle: true,
                      showListNumbers: true,
                      showListBullets: true,
                      showListCheck: true,
                      showQuote: true,
                      showLink: true,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
