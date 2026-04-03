import 'package:flutter/material.dart';

enum AppButtonVariant { filled, outlined, text }

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final bool isLoading;
  final IconData? icon;

  const AppButton({
    required this.label,
    this.onPressed,
    this.variant = AppButtonVariant.filled,
    this.isLoading = false,
    this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final child =
        isLoading
            ? const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
            : icon != null
            ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 18),
                const SizedBox(width: 6),
                Text(label),
              ],
            )
            : Text(label);

    return switch (variant) {
      AppButtonVariant.filled => FilledButton(
        onPressed: isLoading ? null : onPressed,
        child: child,
      ),
      AppButtonVariant.outlined => OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        child: child,
      ),
      AppButtonVariant.text => TextButton(
        onPressed: isLoading ? null : onPressed,
        child: child,
      ),
    };
  }
}
