import 'package:google_sign_in/google_sign_in.dart';

import '../constant.dart';

/// Thin wrapper around the google_sign_in v7 singleton. v7 requires
/// `initialize()` to be awaited exactly once before any sign-in call, so this
/// service guards that and exposes a simple "sign in and give me the ID token"
/// method for the backend exchange.
class GoogleSignInService {
  GoogleSignInService._();

  static final GoogleSignInService instance = GoogleSignInService._();

  bool _initialized = false;

  Future<void> _ensureInitialized() async {
    if (_initialized) return;

    final iosClientId = AppConstants.googleIosClientId;
    await GoogleSignIn.instance.initialize(
      serverClientId: AppConstants.googleServerClientId,
      clientId: iosClientId.isEmpty ? null : iosClientId,
    );
    _initialized = true;
  }

  /// Triggers the native account picker and returns a Google ID token to be
  /// verified server-side. Throws on cancellation or any platform failure.
  Future<String> signInAndGetIdToken() async {
    await _ensureInitialized();

    if (!GoogleSignIn.instance.supportsAuthenticate()) {
      throw Exception('Google Sign-In is not supported on this platform.');
    }

    final account = await GoogleSignIn.instance.authenticate();
    final idToken = account.authentication.idToken;

    if (idToken == null || idToken.isEmpty) {
      throw Exception('Google did not return an ID token.');
    }

    return idToken;
  }

  Future<void> signOut() async {
    if (!_initialized) return;
    try {
      await GoogleSignIn.instance.disconnect();
    } catch (_) {
      // Best-effort; ignore sign-out failures.
    }
  }
}
