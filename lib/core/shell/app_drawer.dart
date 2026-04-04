import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/providers/auth_provider.dart';
import '../../features/folders/providers/folder_provider.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final user = authState.value;
    final foldersAsync = ref.watch(folderListProvider);
    final currentLocation = GoRouterState.of(context).matchedLocation;

    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user?.name ?? 'Loading...'),
            accountEmail: Text(user?.email ?? ''),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Text(
                user?.name.isNotEmpty == true ? user!.name[0].toUpperCase() : '?',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  fontSize: 24,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
            ),
            margin: EdgeInsets.zero,
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  leading: const Icon(Icons.home_outlined),
                  title: const Text('Home'),
                  selected: currentLocation == '/home' || currentLocation == '/',
                  onTap: () {
                    context.go('/');
                    Navigator.pop(context); // Close drawer
                  },
                ),
                Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent, // Remove line on expansion tile
                  ),
                  child: ExpansionTile(
                    leading: const Icon(Icons.folder_outlined),
                    title: const Text('Notes'),
                    initiallyExpanded: currentLocation.startsWith('/folder'),
                    children: [
                      foldersAsync.when(
                        loading: () => const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(child: CircularProgressIndicator()),
                        ),
                        error: (e, _) => Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text('Error: $e', style: const TextStyle(color: Colors.red)),
                        ),
                        data: (folders) {
                          if (folders.isEmpty) {
                            return const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text('No folders yet', style: TextStyle(color: Colors.grey)),
                            );
                          }
                          return Column(
                            children: folders.map((f) {
                              final isSelected = currentLocation == '/folder/${f.id}';
                              return ListTile(
                                leading: const Icon(Icons.snippet_folder_outlined, size: 20),
                                title: Text(f.name),
                                contentPadding: const EdgeInsets.only(left: 48, right: 16),
                                selected: isSelected,
                                onTap: () {
                                  context.go('/folder/${f.id}');
                                  Navigator.pop(context); // Close drawer
                                },
                              );
                            }).toList(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.delete_outline),
                  title: const Text('Trash'),
                  selected: currentLocation == '/trash',
                  onTap: () {
                    context.go('/trash');
                    Navigator.pop(context); // Close drawer
                  },
                ),
              ],
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              ref.read(authProvider.notifier).logout();
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
