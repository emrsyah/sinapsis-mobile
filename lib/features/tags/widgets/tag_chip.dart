import 'package:flutter/material.dart';
import '../../../models/tag.dart';

/// Parses a hex color string like "#1D9E75" / "1D9E75" into a [Color].
/// Falls back to the theme's primary color when [hex] is null or malformed.
Color tagColor(BuildContext context, String? hex) {
  final fallback = Theme.of(context).colorScheme.primary;
  if (hex == null || hex.isEmpty) return fallback;
  var value = hex.replaceFirst('#', '').trim();
  if (value.length == 6) value = 'FF$value';
  final parsed = int.tryParse(value, radix: 16);
  return parsed == null ? fallback : Color(parsed);
}

/// A small colored chip representing a [Tag].
///
/// When [onDeleted] is provided a delete affordance is shown.
class TagChip extends StatelessWidget {
  final Tag tag;
  final VoidCallback? onTap;
  final VoidCallback? onDeleted;

  const TagChip({super.key, required this.tag, this.onTap, this.onDeleted});

  @override
  Widget build(BuildContext context) {
    final color = tagColor(context, tag.color);
    final chip = Chip(
      label: Text(tag.name),
      avatar: CircleAvatar(backgroundColor: color, radius: 6),
      onDeleted: onDeleted,
      visualDensity: VisualDensity.compact,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );

    if (onTap == null) return chip;
    return InkWell(borderRadius: BorderRadius.circular(20), onTap: onTap, child: chip);
  }
}
