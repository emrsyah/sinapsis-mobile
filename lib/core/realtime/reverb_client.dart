import 'dart:async';
import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../constant.dart';
import '../storage/local_storage.dart';

part 'reverb_client.g.dart';

@riverpod
ReverbClient reverbClient(Ref ref) {
  final client = ReverbClient(ref.read(localStorageProvider));
  ref.onDispose(client.disconnect);
  return client;
}

class ReverbClient {
  final LocalStorage _storage;
  WebSocketChannel? _channel;

  final _controller = StreamController<Map<String, dynamic>>.broadcast();
  Stream<Map<String, dynamic>> get events => _controller.stream;

  ReverbClient(this._storage);

  Future<void> connect(String userId) async {
    final token = await _storage.getToken();
    if (token == null) return;

    final uri = Uri.parse(
      '${AppConstants.reverbWsUrl}/app/${AppConstants.reverbKey}'
      '?protocol=7&client=dart&version=1.0',
    );

    _channel = WebSocketChannel.connect(uri);

    // Subscribe to user's private channel
    _channel!.sink.add(
      jsonEncode({
        'event': 'pusher:subscribe',
        'data': {'channel': 'private-user.$userId'},
      }),
    );

    _channel!.stream.listen(
      (raw) {
        try {
          final data = jsonDecode(raw as String) as Map<String, dynamic>;
          _controller.add(data);
        } catch (_) {}
      },
      onError: (_) {},
      onDone: () {},
    );
  }

  void disconnect() {
    _channel?.sink.close();
    _channel = null;
    _controller.close();
  }

  /// Listen for a specific event name.
  Stream<Map<String, dynamic>> on(String eventName) {
    return events.where((e) => e['event'] == eventName);
  }
}
