import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/constant.dart';

part 'ai_client.g.dart';

@riverpod
AiClient aiClient(Ref ref) => AiClient();

/// Calls the Next.js AI route handlers (`/api/ai/<type>`) which hold the
/// OpenRouter key server-side and return structured study-tool content.
class AiClient {
  late final Dio _dio;

  AiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.aiBaseUrl,
        headers: {'Content-Type': 'application/json'},
        connectTimeout: const Duration(seconds: 15),
        // Generation can be slow; allow plenty of headroom.
        receiveTimeout: const Duration(seconds: 90),
      ),
    );
  }

  /// `type` is one of flashcard | quiz | mindmap.
  /// Returns the raw content map (shape depends on type).
  Future<Map<String, dynamic>> generate(
    String type, {
    required String content,
    Map<String, dynamic>? options,
  }) async {
    final res = await _dio.post(
      '/api/ai/$type',
      data: {'content': content, if (options != null) 'options': options},
    );
    return res.data as Map<String, dynamic>;
  }
}
