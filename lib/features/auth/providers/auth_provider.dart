import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../models/user.dart';
import '../../../core/storage/local_storage.dart';
import '../data/auth_repository.dart';

part 'auth_provider.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  Future<User?> build() async {
    final storage = ref.read(localStorageProvider);
    final token = await storage.getToken();
    if (token == null) return null;
    return ref.read(authRepositoryProvider).getMe();
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final result = await ref
          .read(authRepositoryProvider)
          .login(email: email, password: password);
      final storage = ref.read(localStorageProvider);
      await storage.saveToken(result.token);
      await storage.saveUserId(result.user.id);
      return result.user;
    });
  }

  Future<void> register(String name, String email, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final result = await ref
          .read(authRepositoryProvider)
          .register(name: name, email: email, password: password);
      final storage = ref.read(localStorageProvider);
      await storage.saveToken(result.token);
      await storage.saveUserId(result.user.id);
      return result.user;
    });
  }

  Future<void> logout() async {
    await ref.read(authRepositoryProvider).logout();
    await ref.read(localStorageProvider).clearAll();
    state = const AsyncValue.data(null);
  }
}
