import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final String message;
  final IconData? icon;
  final VoidCallback? onAction;
  final String? actionLabel;

  const EmptyState({
    required this.message,
    this.icon,
    this.onAction,
    this.actionLabel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 48, color: Colors.grey[400]),
            const SizedBox(height: 16),
          ],
          Text(
            message,
            style: TextStyle(color: Colors.grey[600], fontSize: 15),
            textAlign: TextAlign.center,
          ),
          if (onAction != null && actionLabel != null) ...[
            const SizedBox(height: 16),
            FilledButton(onPressed: onAction, child: Text(actionLabel!)),
          ],
        ],
      ),
    );
  }
}
