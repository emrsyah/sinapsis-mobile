import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/shell/app_drawer.dart';
import '../providers/tag_provider.dart';
import '../widgets/tag_chip.dart';

class TagManageScreen extends ConsumerWidget {
  const TagManageScreen({super.key});

  Future<void> _showCreateDialog(BuildContext context, WidgetRef ref) async {
    final nameController = TextEditingController();
    // A small preset palette; matches the teal-led Material theme.
    const presets = [
      '#1D9E75', '#E11D48', '#2563EB', '#D97706', '#7C3AED', '#0891B2',
    ];
    String? selectedColor = presets.first;

    await showDialog<void>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          title: const Text('New Tag'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                autofocus: true,
                decoration: const InputDecoration(hintText: 'Tag name'),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                children: presets.map((hex) {
                  final color = tagColor(ctx, hex);
                  final isSelected = selectedColor == hex;
                  return GestureDetector(
                    onTap: () => setState(() => selectedColor = hex),
                    child: CircleAvatar(
                      backgroundColor: color,
                      radius: 14,
                      child: isSelected
                          ? const Icon(Icons.check, size: 16, color: Colors.white)
                          : null,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () async {
                final name = nameController.text.trim();
                if (name.isEmpty) return;
                await ref
                    .read(tagListProvider.notifier)
                    .createTag(name, color: selectedColor);
                if (ctx.mounted) Navigator.pop(ctx);
              },
              child: const Text('Create'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tagsAsync = ref.watch(tagListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Tags')),
      drawer: const AppDrawer(),
      body: tagsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (tags) => tags.isEmpty
            ? const Center(child: Text('No tags yet'))
            : ListView.separated(
                itemCount: tags.length,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (_, i) {
                  final tag = tags[i];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: tagColor(context, tag.color),
                      radius: 10,
                    ),
                    title: Text(tag.name),
                    onTap: () => context.push('/tags/${tag.id}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () async {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text('Delete Tag?'),
                            content: Text(
                              'Remove "${tag.name}" from all notes?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(ctx, false),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(ctx, true),
                                child: const Text(
                                  'Delete',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        );
                        if (confirm == true) {
                          await ref
                              .read(tagListProvider.notifier)
                              .deleteTag(tag.id);
                        }
                      },
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }
}
