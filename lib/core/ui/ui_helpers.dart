import 'package:flutter/material.dart';

/// Category accent palette used for folder / note category dots, mirroring the
/// reference design (blue, purple, pink, orange, yellow, green, cyan, red).
const List<Color> kCategoryPalette = [
  Color(0xFF3B82F6),
  Color(0xFFA855F7),
  Color(0xFFEC4899),
  Color(0xFFF59E0B),
  Color(0xFFEAB308),
  Color(0xFF22C55E),
  Color(0xFF06B6D4),
  Color(0xFFEF4444),
];

/// Amber used for the "pinned" star.
const Color kStarColor = Color(0xFFFBBF24);

/// Deterministically maps a key (folder id/name) to a stable accent color so
/// the same folder always shows the same dot color without needing a stored
/// color field.
Color categoryColorFor(String? key) {
  if (key == null || key.isEmpty) return kCategoryPalette.first;
  var hash = 0;
  for (final unit in key.codeUnits) {
    hash = (hash * 31 + unit) & 0x7fffffff;
  }
  return kCategoryPalette[hash % kCategoryPalette.length];
}

/// Formats an ISO timestamp like the reference cards: "Today, 9:41 AM" for
/// today, otherwise "Apr 2, 2026".
String formatNoteDate(String? iso) {
  if (iso == null || iso.isEmpty) return '';
  final dt = DateTime.tryParse(iso)?.toLocal();
  if (dt == null) return '';
  const months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];
  final now = DateTime.now();
  final isToday = dt.year == now.year && dt.month == now.month && dt.day == now.day;
  if (isToday) {
    final hour12 = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final minute = dt.minute.toString().padLeft(2, '0');
    final ampm = dt.hour < 12 ? 'AM' : 'PM';
    return 'Today, $hour12:$minute $ampm';
  }
  return '${months[dt.month - 1]} ${dt.day}, ${dt.year}';
}
