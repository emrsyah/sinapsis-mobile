import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/shell/app_drawer.dart';
import '../../../core/ui/ui_helpers.dart';
import '../../../models/folder.dart';
import '../../../models/note.dart';
import '../../folders/providers/folder_provider.dart';
import '../providers/note_provider.dart';
import '../widgets/new_note_sheet.dart';
import '../widgets/note_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notesAsync = ref.watch(noteListProvider());
    final folders = ref.watch(folderListProvider).value ?? const <Folder>[];
    final folderById = {for (final f in folders) f.id: f};

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sinapsis'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search',
            onPressed: () => context.push('/search'),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      // Wider swipe-from-left zone to open the sidebar (kept modest so the
      // horizontal chip rows stay scrollable).
      drawerEdgeDragWidth: 80,
      body: notesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (notes) {
          final sorted = List.of(notes)
            ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
          final pinned = sorted.where((n) => n.isPinned).toList();
          final others = sorted.where((n) => !n.isPinned).toList();

          Widget cardFor(Note note) {
            final folder = note.folderId == null ? null : folderById[note.folderId];
            return NoteCard(
              note: note,
              categoryLabel: folder?.name,
              categoryColor: note.folderId == null
                  ? null
                  : categoryColorFor(note.folderId),
              onTap: () async {
                await context.push('/notes/${note.id}');
                ref.invalidate(noteListProvider());
              },
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(folderListProvider);
              ref.invalidate(noteListProvider);
              await ref.read(noteListProvider().future);
            },
            child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
            children: [
              Text(
                _getGreeting(),
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'You have ${notes.length} '
                '${notes.length == 1 ? 'note' : 'notes'} across '
                '${folders.length} ${folders.length == 1 ? 'folder' : 'folders'}.',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              if (folders.isNotEmpty) ...[
                const SizedBox(height: 16),
                _FolderChips(folders: folders, notes: notes),
              ],
              if (pinned.isNotEmpty) ...[
                const SizedBox(height: 20),
                const _SectionHeader(icon: Icons.star_rounded, label: 'Pinned'),
                const SizedBox(height: 10),
                ...pinned.map(cardFor),
              ],
              const SizedBox(height: 14),
              if (sorted.isEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 64),
                  child: Center(
                    child: Text(
                      'No notes yet. Tap + to create one.',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                )
              else
                ...others.map(cardFor),
            ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showNewNoteSheet(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final String label;
  const _SectionHeader({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: kStarColor),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}

class _FolderChips extends StatelessWidget {
  final List<Folder> folders;
  final List<Note> notes;
  const _FolderChips({required this.folders, required this.notes});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SizedBox(
      height: 34,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: folders.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final folder = folders[i];
          final count = notes.where((n) => n.folderId == folder.id).length;
          final color = categoryColorFor(folder.id);
          return InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () => context.push('/folder/${folder.id}'),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: scheme.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: scheme.outline),
              ),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    folder.name,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '$count',
                    style: TextStyle(fontSize: 13, color: scheme.onSurfaceVariant),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
