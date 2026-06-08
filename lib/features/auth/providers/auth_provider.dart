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
    try {
      return await ref.read(authRepositoryProvider).getMe();
    } catch (_) {
      await storage.clearAll();
      return null;
    }
  }

  Future<void> setAuthenticated(String token, User user) async {
    final storage = ref.read(localStorageProvider);
    await storage.saveToken(token);
    await storage.saveUserId(user.id);
    await storage.saveUserName(user.name);
    state = AsyncValue.data(user);
  }

  Future<void> logout() async {
    try {
      await ref.read(authRepositoryProvider).logout();
    } catch (_) {
      // Ignore network errors on logout
    }
    await ref.read(localStorageProvider).clearAll();
    state = const AsyncValue.data(null);
  }
}
