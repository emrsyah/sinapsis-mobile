import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FlashcardScreen extends ConsumerWidget {
  final String noteId;
  final String? generationId;
  const FlashcardScreen({required this.noteId, this.generationId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flashcards')),
      body: const Center(child: Text('Flashcard viewer — TODO')),
    );
  }
}
