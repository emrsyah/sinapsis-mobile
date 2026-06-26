/// Helpers for reading API response bodies.
///
/// The Laravel backend returns **bare** Spatie Data: a single resource as a
/// JSON object `{...}` and a collection as a JSON array `[...]`, with no
/// `{ "data": ... }` envelope. These helpers tolerate both the bare shape and
/// an optional envelope, so parsing keeps working regardless of wrapping.
library;

/// Extract a list from a response body that is either a bare JSON array or a
/// `{ "data": [...] }` envelope.
List<dynamic> dataList(dynamic body) {
  if (body is List) return body;
  if (body is Map && body['data'] is List) return body['data'] as List;
  throw FormatException(
    'Expected a list response but got ${body.runtimeType}',
  );
}

/// Extract a single object from a response body that is either a bare JSON
/// object or a `{ "data": {...} }` envelope.
Map<String, dynamic> dataMap(dynamic body) {
  if (body is Map<String, dynamic>) {
    final inner = body['data'];
    return inner is Map<String, dynamic> ? inner : body;
  }
  if (body is Map) return Map<String, dynamic>.from(body);
  throw FormatException(
    'Expected an object response but got ${body.runtimeType}',
  );
}
