import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizScreen extends ConsumerWidget {
  final String noteId;
  final String? generationId;
  const QuizScreen({required this.noteId, this.generationId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz')),
      body: const Center(child: Text('Quiz viewer — TODO')),
    );
  }
}
