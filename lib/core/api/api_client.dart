import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../constant.dart';
import '../storage/local_storage.dart';

part 'api_client.g.dart';

@riverpod
ApiClient apiClient(Ref ref) {
  return ApiClient(ref.read(localStorageProvider));
}

class ApiClient {
  final LocalStorage _storage;
  late final Dio _dio;

  ApiClient(this._storage) {
    _dio = Dio(
      BaseOptions(
        baseUrl: '${AppConstants.apiBaseUrl}/api/v1',
        headers: {'Accept': 'application/json'},
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _storage.getToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            await _storage.clearAll();
          }
          handler.next(error);
        },
      ),
    );
  }

  Future<dynamic> get(String path, {Map<String, dynamic>? params}) async {
    final res = await _dio.get(path, queryParameters: params);
    return res.data;
  }

  Future<dynamic> post(
    String path, {
    required Map<String, dynamic> body,
  }) async {
    final res = await _dio.post(path, data: body);
    return res.data;
  }

  Future<dynamic> patch(
    String path, {
    required Map<String, dynamic> body,
  }) async {
    final res = await _dio.patch(path, data: body);
    return res.data;
  }

  Future<void> delete(String path) async {
    await _dio.delete(path);
  }
}
