import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/providers/auth_provider.dart';
import '../../features/folders/providers/folder_provider.dart';
import '../../features/notes/providers/note_provider.dart';
import '../../features/tags/providers/tag_provider.dart';
import '../../models/note.dart';
import '../ui/ui_helpers.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final user = ref.watch(authProvider).value;
    final folders = ref.watch(folderListProvider).value ?? const [];
    final tags = ref.watch(tagListProvider).value ?? const [];
    final notes = ref.watch(noteListProvider()).value ?? const <Note>[];
    final current = GoRouterState.of(context).matchedLocation;

    void go(String path) {
      context.go(path);
      Navigator.pop(context);
    }

    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Logo header ──────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 12, 8),
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: scheme.primary,
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: Icon(
                      Icons.auto_stories_rounded,
                      size: 18,
                      color: scheme.onPrimary,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Sinapsis',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  const Spacer(),
                  if (user != null)
                    CircleAvatar(
                      radius: 14,
                      backgroundColor: scheme.primary.withValues(alpha: 0.18),
                      child: Text(
                        user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
                        style: TextStyle(
                          color: scheme.primary,
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                children: [
                  _NavTile(
                    icon: Icons.home_outlined,
                    label: 'Home',
                    selected: current == '/' || current == '/home',
                    onTap: () => go('/'),
                  ),
                  _NavTile(
                    icon: Icons.search,
                    label: 'Search',
                    selected: current == '/search',
                    onTap: () => go('/search'),
                  ),
                  if (folders.isNotEmpty) ...[
                    const _SectionLabel('NOTES'),
                    ...folders.map((f) {
                      final count =
                          notes.where((n) => n.folderId == f.id).length;
                      return _DotTile(
                        color: categoryColorFor(f.id),
                        label: f.name,
                        count: count,
                        selected: current == '/folder/${f.id}',
                        onTap: () => go('/folder/${f.id}'),
                      );
                    }),
                  ],
                  const _SectionLabel('TAGS'),
                  if (tags.isEmpty)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
                      child: Text(
                        'No tags yet',
                        style: TextStyle(
                          fontSize: 13,
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    )
                  else
                    ...tags.map((t) {
                      final count = notes
                          .where((n) => n.tags.any((nt) => nt.id == t.id))
                          .length;
                      return _DotTile(
                        color: t.color == null || t.color!.isEmpty
                            ? categoryColorFor(t.id)
                            : _hexColor(t.color!) ?? categoryColorFor(t.id),
                        label: t.name,
                        count: count,
                        selected: current == '/tags/${t.id}',
                        onTap: () => go('/tags/${t.id}'),
                      );
                    }),
                  _NavTile(
                    icon: Icons.label_outline,
                    label: 'Manage tags',
                    selected: current == '/tags',
                    onTap: () => go('/tags'),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            _NavTile(
              icon: Icons.delete_outline,
              label: 'Trash',
              selected: current == '/trash',
              onTap: () => go('/trash'),
            ),
            _NavTile(
              icon: Icons.logout,
              label: 'Logout',
              selected: false,
              onTap: () => ref.read(authProvider.notifier).logout(),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

Color? _hexColor(String hex) {
  var value = hex.replaceFirst('#', '').trim();
  if (value.length == 6) value = 'FF$value';
  final parsed = int.tryParse(value, radix: 16);
  return parsed == null ? null : Color(parsed);
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

class _NavTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _NavTile({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ListTile(
      dense: true,
      visualDensity: const VisualDensity(vertical: -1),
      leading: Icon(icon, size: 20),
      title: Text(label, style: const TextStyle(fontSize: 14)),
      selected: selected,
      selectedColor: scheme.primary,
      selectedTileColor: scheme.primary.withValues(alpha: 0.12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onTap: onTap,
    );
  }
}

class _DotTile extends StatelessWidget {
  final Color color;
  final String label;
  final int count;
  final bool selected;
  final VoidCallback onTap;
  const _DotTile({
    required this.color,
    required this.label,
    required this.count,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ListTile(
      dense: true,
      visualDensity: const VisualDensity(vertical: -2),
      leading: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
      horizontalTitleGap: 12,
      title: Text(label, style: const TextStyle(fontSize: 14)),
      trailing: Text(
        '$count',
        style: TextStyle(fontSize: 13, color: scheme.onSurfaceVariant),
      ),
      selected: selected,
      selectedColor: scheme.onSurface,
      selectedTileColor: scheme.surfaceContainerHigh,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onTap: onTap,
    );
  }
}
