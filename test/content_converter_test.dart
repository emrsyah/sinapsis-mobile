import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:sinapsis_mobile/core/editor/content_converter.dart';

void main() {
  test('web HTML -> Document preserves text and structure', () {
    const html =
        '<h1>Title</h1>'
        '<p>Some <strong>bold</strong> and <em>italic</em> text.</p>'
        '<p><span style="background-color: #FFFF00">highlighted</span></p>'
        '<ul><li>one</li><li>two</li></ul>';

    final doc = ContentConverter.documentFromStored(html);
    final plain = doc.toPlainText();

    expect(plain, contains('Title'));
    expect(plain, contains('bold'));
    expect(plain, contains('highlighted'));
    expect(plain, contains('one'));
    expect(plain, contains('two'));
  });

  test('legacy Quill Delta JSON still loads', () {
    final deltaJson = jsonEncode([
      {'insert': 'legacy delta note\n'},
    ]);

    final doc = ContentConverter.documentFromStored(deltaJson);
    expect(doc.toPlainText().trim(), 'legacy delta note');
  });

  test('round-trip HTML -> Document -> HTML keeps the text and tags', () {
    const html = '<p>Hello <strong>world</strong></p>';
    final doc = ContentConverter.documentFromStored(html);
    final out = ContentConverter.documentToHtml(doc);

    expect(out, contains('Hello'));
    expect(out, contains('world'));
    // bold survives the round-trip (vsc emits <strong> for bold)
    expect(out.toLowerCase(), contains('<strong>'));
  });

  test('empty / null content yields an empty document, never throws', () {
    expect(ContentConverter.documentFromStored(null).toPlainText().trim(), '');
    expect(ContentConverter.documentFromStored('').toPlainText().trim(), '');
  });
}
