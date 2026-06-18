import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../models/attachment.dart';
import '../providers/attachment_provider.dart';

class AttachmentsScreen extends ConsumerStatefulWidget {
  final String noteId;
  const AttachmentsScreen({required this.noteId, super.key});

  @override
  ConsumerState<AttachmentsScreen> createState() => _AttachmentsScreenState();
}

class _AttachmentsScreenState extends ConsumerState<AttachmentsScreen> {
  bool _uploading = false;

  Future<void> _pickAndUpload() async {
    final result = await FilePicker.platform.pickFiles();
    final path = result?.files.single.path;
    if (path == null) return;

    setState(() => _uploading = true);
    try {
      await ref
          .read(attachmentListProvider(widget.noteId).notifier)
          .upload(path, fileName: result!.files.single.name);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Upload failed: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _uploading = false);
    }
  }

  Future<void> _open(Attachment a) async {
    final uri = Uri.tryParse(a.fileUrl);
    if (uri == null) return;
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open file')),
        );
      }
    }
  }

  Future<void> _confirmDelete(Attachment a) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Attachment?'),
        content: Text('Remove "${a.fileName}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
    if (confirm == true) {
      await ref
          .read(attachmentListProvider(widget.noteId).notifier)
          .delete(a.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final attachmentsAsync =
        ref.watch(attachmentListProvider(widget.noteId));

    return Scaffold(
      appBar: AppBar(title: const Text('Attachments')),
      body: Column(
        children: [
          if (_uploading) const LinearProgressIndicator(),
          Expanded(
            child: attachmentsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
              data: (items) => items.isEmpty
                  ? const Center(child: Text('No attachments yet'))
                  : ListView.separated(
                      itemCount: items.length,
                      separatorBuilder: (_, _) => const Divider(height: 1),
                      itemBuilder: (_, i) {
                        final a = items[i];
                        return ListTile(
                          leading: Icon(_iconFor(a.fileType, a.fileName)),
                          title: Text(a.fileName),
                          subtitle: Text(_formatSize(a.fileSize)),
                          onTap: () => _open(a),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete_outline),
                            onPressed: () => _confirmDelete(a),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _uploading ? null : _pickAndUpload,
        icon: const Icon(Icons.upload_file),
        label: const Text('Upload'),
      ),
    );
  }
}

IconData _iconFor(String? type, String name) {
  final t = (type ?? '').toLowerCase();
  final ext = name.contains('.') ? name.split('.').last.toLowerCase() : '';
  if (t.startsWith('image') ||
      ['png', 'jpg', 'jpeg', 'gif', 'webp'].contains(ext)) {
    return Icons.image_outlined;
  }
  if (t.contains('pdf') || ext == 'pdf') return Icons.picture_as_pdf_outlined;
  if (['doc', 'docx', 'txt', 'md'].contains(ext)) {
    return Icons.description_outlined;
  }
  return Icons.insert_drive_file_outlined;
}

String _formatSize(int? bytes) {
  if (bytes == null) return '';
  if (bytes < 1024) return '$bytes B';
  if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
  return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
}
