import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../models/user.dart';
import '../../../core/auth/google_sign_in_service.dart';
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

  /// Runs the native Google sign-in flow, exchanges the ID token for a Sanctum
  /// token, then loads the profile and marks the session authenticated.
  Future<void> signInWithGoogle() async {
    final repo = ref.read(authRepositoryProvider);
    final storage = ref.read(localStorageProvider);

    final idToken = await GoogleSignInService.instance.signInAndGetIdToken();
    final token = await repo.exchangeGoogleIdToken(idToken);

    // Persist the token first so the getMe() request is authenticated.
    await storage.saveToken(token);
    final user = await repo.getMe();
    await setAuthenticated(token, user);
  }

  Future<void> logout() async {
    try {
      await ref.read(authRepositoryProvider).logout();
    } catch (_) {
      // Ignore network errors on logout
    }
    await GoogleSignInService.instance.signOut();
    await ref.read(localStorageProvider).clearAll();
    state = const AsyncValue.data(null);
  }
}
