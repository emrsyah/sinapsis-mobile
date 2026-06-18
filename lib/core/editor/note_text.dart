import 'dart:convert';
import 'package:flutter_quill/flutter_quill.dart';

/// Extracts clean plain text from a note's stored `content`, which may be
/// Quill Delta JSON (mobile-authored) or HTML (web-authored). Used to feed
/// the AI generation endpoints with readable text rather than raw markup.
String noteContentToPlainText(String? content) {
  if (content == null || content.trim().isEmpty) return '';
  final trimmed = content.trim();

  // Quill Delta JSON starts with '[' (op list) or '{' (wrapped).
  if (trimmed.startsWith('[') || trimmed.startsWith('{')) {
    try {
      final decoded = jsonDecode(trimmed);
      final doc = Document.fromJson(
        decoded is List ? decoded : (decoded['ops'] as List),
      );
      return doc.toPlainText().trim();
    } catch (_) {
      // fall through to tag-strip
    }
  }

  // Treat as HTML: strip tags and collapse whitespace.
  return trimmed
      .replaceAll(RegExp(r'<[^>]+>'), ' ')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();
}
