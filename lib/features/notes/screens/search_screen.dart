import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/editor/note_text.dart';
import '../../../core/shell/app_drawer.dart';
import '../../../core/ui/ui_helpers.dart';
import '../../../models/folder.dart';
import '../../../models/note.dart';
import '../../folders/providers/folder_provider.dart';
import '../providers/note_provider.dart';
import '../providers/search_provider.dart';

enum _SearchFilter { all, title, body, folders, tags }

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _controller = TextEditingController();
  Timer? _debounce;
  String _query = '';
  _SearchFilter _filter = _SearchFilter.all;

  void _onChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 350), () {
      if (mounted) setState(() => _query = value);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  List<Note> _applyFilter(
    List<Note> notes,
    Map<String, Folder> folderById,
  ) {
    final q = _query.trim().toLowerCase();
    if (q.isEmpty || _filter == _SearchFilter.all) return notes;
    return notes.where((n) {
      switch (_filter) {
        case _SearchFilter.title:
          return n.title.toLowerCase().contains(q);
        case _SearchFilter.body:
          return noteContentToPlainText(n.content).toLowerCase().contains(q);
        case _SearchFilter.folders:
          final name = folderById[n.folderId]?.name.toLowerCase() ?? '';
          return name.contains(q);
        case _SearchFilter.tags:
          return n.tags.any((t) => t.name.toLowerCase().contains(q));
        case _SearchFilter.all:
          return true;
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final hasQuery = _query.trim().isNotEmpty;
    final folders = ref.watch(folderListProvider).value ?? const <Folder>[];
    final folderById = {for (final f in folders) f.id: f};

    return Scaffold(
      drawer: const AppDrawer(),
      drawerEdgeDragWidth: 80,
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 8,
        leading: Builder(
          builder: (ctx) => IconButton(
            icon: const Icon(Icons.menu),
            tooltip: 'Menu',
            onPressed: () => Scaffold.of(ctx).openDrawer(),
          ),
        ),
        title: const Text(
          'Search',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Search field ────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
            child: TextField(
              controller: _controller,
              autofocus: true,
              onChanged: _onChanged,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: 'Search notes, folders, tags...',
                prefixIcon: const Icon(Icons.search, size: 20),
                suffixIcon: _controller.text.isEmpty
                    ? Icon(Icons.mic_none, size: 20, color: scheme.onSurfaceVariant)
                    : IconButton(
                        icon: const Icon(Icons.close, size: 20),
                        onPressed: () {
                          _controller.clear();
                          _debounce?.cancel();
                          setState(() => _query = '');
                        },
                      ),
              ),
            ),
          ),
          // ── Filter chips ────────────────────────────────────────
          SizedBox(
            height: 36,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                for (final f in _SearchFilter.values)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: _FilterPill(
                      label: switch (f) {
                        _SearchFilter.all => 'All',
                        _SearchFilter.title => 'Title',
                        _SearchFilter.body => 'Body',
                        _SearchFilter.folders => 'Folders',
                        _SearchFilter.tags => 'Tags',
                      },
                      selected: _filter == f,
                      onTap: () => setState(() => _filter = f),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: hasQuery
                ? _buildResults(folderById)
                : _buildRecent(folderById),
          ),
        ],
      ),
    );
  }

  Widget _buildResults(Map<String, Folder> folderById) {
    final resultsAsync = ref.watch(searchNotesProvider(_query));
    return resultsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (notes) {
        final filtered = _applyFilter(notes, folderById);
        if (filtered.isEmpty) {
          return Center(
            child: Text(
              'No notes found',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          );
        }
        return _resultList(filtered, folderById);
      },
    );
  }

  Widget _buildRecent(Map<String, Folder> folderById) {
    final notes = ref.watch(noteListProvider()).value ?? const <Note>[];
    final recent = List.of(notes)
      ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    final top = recent.take(12).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
          child: Row(
            children: [
              Icon(
                Icons.history,
                size: 16,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 6),
              Text(
                'Recent notes',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        Expanded(child: _resultList(top, folderById)),
      ],
    );
  }

  Widget _resultList(List<Note> notes, Map<String, Folder> folderById) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 96),
      itemCount: notes.length,
      separatorBuilder: (_, _) => Divider(
        height: 24,
        color: Theme.of(context).colorScheme.outlineVariant,
      ),
      itemBuilder: (_, i) =>
          _ResultRow(note: notes[i], folderById: folderById),
    );
  }
}

class _FilterPill extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _FilterPill({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? scheme.onSurface : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? scheme.onSurface : scheme.outline,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: selected ? scheme.surface : scheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}

class _ResultRow extends StatelessWidget {
  final Note note;
  final Map<String, Folder> folderById;
  const _ResultRow({required this.note, required this.folderById});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final preview = noteContentToPlainText(note.content);
    final folderName = folderById[note.folderId]?.name;
    final date = formatNoteDate(note.updatedAt);
    final meta = [
      if (folderName != null && folderName.isNotEmpty) folderName,
      if (date.isNotEmpty) date,
    ].join('  ·  ');

    return InkWell(
      onTap: () => context.push('/notes/${note.id}'),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title.isNotEmpty ? note.title : 'Untitled Note',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
            if (preview.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                preview,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.3,
                  color: scheme.onSurface.withValues(alpha: 0.78),
                ),
              ),
            ],
            if (meta.isNotEmpty) ...[
              const SizedBox(height: 6),
              Text(
                meta,
                style: TextStyle(fontSize: 11, color: scheme.onSurfaceVariant),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
