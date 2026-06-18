import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constant.dart';
import '../../../models/note.dart';
import '../providers/sharing_provider.dart';

/// Bottom sheet to publish/unpublish a note and copy its public link.
class ShareSheet extends ConsumerStatefulWidget {
  final Note note;
  const ShareSheet({super.key, required this.note});

  static Future<void> show(BuildContext context, Note note) {
    return showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (_) => ShareSheet(note: note),
    );
  }

  @override
  ConsumerState<ShareSheet> createState() => _ShareSheetState();
}

class _ShareSheetState extends ConsumerState<ShareSheet> {
  late bool _isPublished = widget.note.isPublished;
  late String? _shareToken = widget.note.shareToken;
  bool _busy = false;

  String? get _shareUrl => _shareToken == null
      ? null
      : '${AppConstants.webBaseUrl}/shared/$_shareToken';

  Future<void> _toggle(bool value) async {
    setState(() => _busy = true);
    try {
      final controller = ref.read(sharingControllerProvider.notifier);
      if (value) {
        final updated = await controller.publish(widget.note.id);
        setState(() {
          _isPublished = true;
          _shareToken = updated.shareToken;
        });
      } else {
        await controller.unpublish(widget.note.id);
        setState(() {
          _isPublished = false;
          _shareToken = null;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _copyLink() async {
    final url = _shareUrl;
    if (url == null) return;
    await Clipboard.setData(ClipboardData(text: url));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Link copied')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Share', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Publish to web'),
              subtitle: Text(
                _isPublished
                    ? 'Anyone with the link can view this note'
                    : 'Note is private',
              ),
              value: _isPublished,
              onChanged: _busy ? null : _toggle,
            ),
            if (_busy) const LinearProgressIndicator(),
            if (_isPublished && _shareUrl != null) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outlineVariant,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _shareUrl!,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.copy, size: 20),
                      tooltip: 'Copy link',
                      onPressed: _copyLink,
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
