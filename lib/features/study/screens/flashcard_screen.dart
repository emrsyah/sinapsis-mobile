import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/study_tool_generation.dart';
import '../widgets/study_tool_view.dart';

class FlashcardScreen extends ConsumerWidget {
  final String noteId;
  final String? generationId;
  const FlashcardScreen({required this.noteId, this.generationId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StudyToolView(
      noteId: noteId,
      type: StudyToolType.flashcard,
      title: 'Flashcards',
      contentBuilder: (generation) {
        final content = generation.content;
        if (content is! FlashcardStudyContent) {
          return const Center(child: Text('Invalid flashcard content'));
        }
        final cards = content.data.cards;
        if (cards.isEmpty) {
          return const Center(child: Text('No flashcards generated'));
        }
        return _FlashcardCarousel(cards: cards);
      },
    );
  }
}

class _FlashcardCarousel extends StatefulWidget {
  final List<FlashCard> cards;
  const _FlashcardCarousel({required this.cards});

  @override
  State<_FlashcardCarousel> createState() => _FlashcardCarouselState();
}

class _FlashcardCarouselState extends State<_FlashcardCarousel> {
  final _controller = PageController();
  int _index = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            'Card ${_index + 1} of ${widget.cards.length}',
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        Expanded(
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.cards.length,
            onPageChanged: (i) => setState(() => _index = i),
            itemBuilder: (_, i) => _FlipCard(card: widget.cards[i]),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(12),
          child: Text('Tap card to flip · swipe to navigate'),
        ),
      ],
    );
  }
}

class _FlipCard extends StatefulWidget {
  final FlashCard card;
  const _FlipCard({required this.card});

  @override
  State<_FlipCard> createState() => _FlipCardState();
}

class _FlipCardState extends State<_FlipCard> {
  bool _showAnswer = false;

  @override
  void didUpdateWidget(_FlipCard old) {
    super.didUpdateWidget(old);
    if (old.card != widget.card) _showAnswer = false;
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GestureDetector(
        onTap: () => setState(() => _showAnswer = !_showAnswer),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: Card(
            key: ValueKey(_showAnswer),
            color: _showAnswer ? scheme.secondaryContainer : scheme.surfaceContainerHighest,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _showAnswer ? 'ANSWER' : 'QUESTION',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _showAnswer ? widget.card.answer : widget.card.question,
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
