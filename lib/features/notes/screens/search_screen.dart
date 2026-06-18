import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../tags/widgets/tag_chip.dart';
import '../providers/search_provider.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _controller = TextEditingController();
  Timer? _debounce;
  String _query = '';

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

  @override
  Widget build(BuildContext context) {
    final resultsAsync = ref.watch(searchNotesProvider(_query));

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          autofocus: true,
          onChanged: _onChanged,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            hintText: 'Search notes...',
            border: InputBorder.none,
            suffixIcon: _controller.text.isEmpty
                ? null
                : IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _controller.clear();
                      _debounce?.cancel();
                      setState(() => _query = '');
                    },
                  ),
          ),
        ),
      ),
      body: _query.trim().isEmpty
          ? const Center(child: Text('Type to search your notes'))
          : resultsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
              data: (notes) => notes.isEmpty
                  ? const Center(child: Text('No notes found'))
                  : ListView.separated(
                      itemCount: notes.length,
                      separatorBuilder: (_, _) => const Divider(height: 1),
                      itemBuilder: (_, i) {
                        final note = notes[i];
                        return ListTile(
                          title: Text(
                            note.title.isNotEmpty ? note.title : 'Untitled Note',
                          ),
                          subtitle: note.tags.isEmpty
                              ? null
                              : Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Wrap(
                                    spacing: 6,
                                    runSpacing: 4,
                                    children: note.tags
                                        .map((t) => TagChip(tag: t))
                                        .toList(),
                                  ),
                                ),
                          onTap: () => context.push('/notes/${note.id}'),
                        );
                      },
                    ),
            ),
    );
  }
}
