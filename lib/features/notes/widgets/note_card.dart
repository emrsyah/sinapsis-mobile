import 'package:flutter/material.dart';

import '../../../core/editor/note_text.dart';
import '../../../core/ui/ui_helpers.dart';
import '../../../models/note.dart';

/// A note preview card matching the reference design: a category dot + label,
/// bold title, a short body preview, and a date footer with a clock icon, plus
/// a pin star when the note is pinned. Pure presentation — layout/data come
/// from the caller.
class NoteCard extends StatelessWidget {
  final Note note;

  /// Optional category shown as a colored dot + label (e.g. the folder name).
  final String? categoryLabel;
  final Color? categoryColor;
  final VoidCallback onTap;

  const NoteCard({
    super.key,
    required this.note,
    required this.onTap,
    this.categoryLabel,
    this.categoryColor,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final muted = scheme.onSurfaceVariant;
    final preview = noteContentToPlainText(note.content);
    final label = categoryLabel;
    final color = categoryColor ?? categoryColorFor(note.folderId ?? note.id);
    final date = formatNoteDate(note.updatedAt);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (label != null && label.isNotEmpty) ...[
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: muted,
                        ),
                      ),
                    ),
                  ],
                  const Spacer(),
                  if (note.isPinned)
                    const Icon(Icons.star_rounded, size: 18, color: kStarColor),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                note.title.isNotEmpty ? note.title : 'Untitled Note',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  height: 1.25,
                ),
              ),
              if (preview.isNotEmpty) ...[
                const SizedBox(height: 6),
                Text(
                  preview,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13, height: 1.35, color: muted),
                ),
              ],
              if (date.isNotEmpty) ...[
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.schedule, size: 13, color: muted),
                    const SizedBox(width: 5),
                    Text(
                      date,
                      style: TextStyle(fontSize: 12, color: muted),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
