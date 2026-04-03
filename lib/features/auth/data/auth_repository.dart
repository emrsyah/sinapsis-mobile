import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/api/api_client.dart';
import '../../../core/api/api_endpoints.dart';
import '../../../models/user.dart';

part 'auth_repository.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepository(ref.read(apiClientProvider));
}

class AuthRepository {
  final ApiClient _api;
  AuthRepository(this._api);

  Future<({String token, User user})> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final data =
        await _api.post(
              ApiEndpoints.register,
              body: {'name': name, 'email': email, 'password': password},
            )
            as Map<String, dynamic>;
    return (
      token: data['data']['token'] as String,
      user: User.fromJson(data['data']['user'] as Map<String, dynamic>),
    );
  }

  Future<({String token, User user})> login({
    required String email,
    required String password,
  }) async {
    final data =
        await _api.post(
              ApiEndpoints.login,
              body: {'email': email, 'password': password},
            )
            as Map<String, dynamic>;
    return (
      token: data['data']['token'] as String,
      user: User.fromJson(data['data']['user'] as Map<String, dynamic>),
    );
  }

  Future<void> logout() async {
    await _api.post(ApiEndpoints.logout, body: {});
  }

  Future<User> getMe() async {
    final data = await _api.get(ApiEndpoints.me) as Map<String, dynamic>;
    return User.fromJson(data['data'] as Map<String, dynamic>);
  }

  Future<void> updateLastOpened(String noteId) async {
    await _api.patch(ApiEndpoints.lastOpened, body: {'note_id': noteId});
  }
}
