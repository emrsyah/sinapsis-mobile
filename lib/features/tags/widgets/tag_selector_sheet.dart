import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/tag.dart';
import '../providers/tag_provider.dart';
import 'tag_chip.dart';

/// Bottom sheet to attach/detach tags on a note.
///
/// [attachedTagIds] are the ids currently on the note. Tapping a tag toggles it.
class TagSelectorSheet extends ConsumerWidget {
  final String noteId;
  final Set<String> attachedTagIds;

  const TagSelectorSheet({
    super.key,
    required this.noteId,
    required this.attachedTagIds,
  });

  static Future<void> show(
    BuildContext context, {
    required String noteId,
    required List<Tag> attached,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => TagSelectorSheet(
        noteId: noteId,
        attachedTagIds: attached.map((t) => t.id).toSet(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tagsAsync = ref.watch(tagListProvider);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tags', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            tagsAsync.when(
              loading: () => const Padding(
                padding: EdgeInsets.all(24),
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (e, _) => Text('Error: $e'),
              data: (tags) {
                if (tags.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Text('No tags yet. Create one from the Tags screen.'),
                  );
                }
                return Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: tags.map((tag) {
                    final isAttached = attachedTagIds.contains(tag.id);
                    return FilterChip(
                      label: Text(tag.name),
                      avatar: CircleAvatar(
                        backgroundColor: tagColor(context, tag.color),
                        radius: 6,
                      ),
                      selected: isAttached,
                      onSelected: (selected) async {
                        final notifier = ref.read(tagListProvider.notifier);
                        if (selected) {
                          await notifier.attachTag(noteId, tag.id);
                        } else {
                          await notifier.detachTag(noteId, tag.id);
                        }
                        if (context.mounted) Navigator.pop(context);
                      },
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
