import 'dart:convert';

import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_delta_from_html/flutter_quill_delta_from_html.dart';
import 'package:vsc_quill_delta_to_html/vsc_quill_delta_to_html.dart';

/// Outcome of trying to load stored note content into a Quill [Document].
enum ContentParseStatus {
  /// Parsed successfully (HTML or Delta).
  ok,

  /// There was nothing to parse (null/blank) — a legitimately empty note.
  empty,

  /// Content existed but could not be parsed. The caller MUST NOT serialize
  /// the resulting (empty) document back over the original, or it destroys the
  /// note. Treat the note as read-only / un-editable on this client instead.
  failed,
}

/// A parsed document plus how the parse went, so callers can tell a genuinely
/// empty note apart from one we failed to understand.
class ParsedContent {
  const ParsedContent(this.document, this.status);

  final Document document;
  final ContentParseStatus status;

  bool get failed => status == ContentParseStatus.failed;
}

/// Bridges the two note-content formats that share the `note.content` column:
///
/// - The web app (Tiptap) stores **HTML** — this is the canonical format.
/// - This mobile app edits with flutter_quill, whose native format is
///   **Quill Delta JSON**.
///
/// Strategy: HTML is the source of truth. On read we sniff the format and
/// convert HTML -> Delta for the editor/viewer; on save we always emit HTML so
/// the column stays uniformly HTML over time (legacy Delta notes keep working
/// because the read path still sniffs them).
class ContentConverter {
  ContentConverter._();

  /// True when [content] looks like a Quill Delta JSON payload (op list `[`
  /// or wrapped `{ "ops": [...] }`) rather than HTML.
  static bool _looksLikeDelta(String content) {
    final t = content.trimLeft();
    return t.startsWith('[') || t.startsWith('{');
  }

  /// Parse stored content, reporting the outcome so editors can refuse to
  /// overwrite content they couldn't read.
  static ParsedContent parse(String? content) {
    final raw = content?.trim() ?? '';
    if (raw.isEmpty) {
      return ParsedContent(Document(), ContentParseStatus.empty);
    }

    try {
      if (_looksLikeDelta(raw)) {
        final decoded = jsonDecode(raw);
        final ops = decoded is List ? decoded : (decoded['ops'] as List);
        return ParsedContent(Document.fromJson(ops), ContentParseStatus.ok);
      }
      // Web-authored HTML -> Delta.
      final delta = HtmlToDelta().convert(raw);
      return ParsedContent(Document.fromDelta(delta), ContentParseStatus.ok);
    } catch (_) {
      // Parsing failed — hand back an empty doc but flag it so the caller does
      // NOT round-trip this empty doc over the original content.
      return ParsedContent(Document(), ContentParseStatus.failed);
    }
  }

  /// Build a Quill [Document] from whatever is stored in the column.
  ///
  /// Convenience for read-only viewers where an empty render on failure is an
  /// acceptable (non-destructive) outcome. Editors should use [parse] instead
  /// so they can detect [ContentParseStatus.failed] and protect the content.
  static Document documentFromStored(String? content) => parse(content).document;

  /// Serialize the edited [doc] back to HTML for storage (web's format).
  ///
  /// Uses inline styles (`forEmail`) rather than Quill's class-based output so
  /// the markup renders correctly in the web app, which is not a Quill viewer.
  static String documentToHtml(Document doc) {
    final converter = QuillDeltaToHtmlConverter(
      doc.toDelta().toJson().cast<Map<String, dynamic>>(),
      ConverterOptions.forEmail(),
    );
    return converter.convert();
  }
}
