import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MindmapScreen extends ConsumerWidget {
  final String noteId;
  final String? generationId;
  const MindmapScreen({required this.noteId, this.generationId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mind Map')),
      body: const Center(child: Text('Mind map viewer — TODO')),
    );
  }
}
