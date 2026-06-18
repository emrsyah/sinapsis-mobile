import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  AppConstants._();

  static String get apiBaseUrl =>
      dotenv.env['API_BASE_URL'] ?? 'https://api.sinapsis.app';

  /// Next.js base URL that hosts the AI generation route handlers
  /// (`/api/ai/flashcard|quiz|mindmap`). Separate from [apiBaseUrl] (Laravel).
  /// Note: on an Android emulator use `http://10.0.2.2:3000` to reach the host's
  /// localhost; a physical device needs the host machine's LAN IP.
  static String get aiBaseUrl =>
      dotenv.env['AI_BASE_URL'] ?? 'http://localhost:3000';

  static String get reverbWsUrl =>
      dotenv.env['REVERB_WS_URL'] ?? 'wss://api.sinapsis.app';

  static String get reverbKey =>
      dotenv.env['REVERB_KEY'] ?? '';

  static String get uploadthingApiKey =>
      dotenv.env['UPLOADTHING_API_KEY'] ?? '';

  /// Web OAuth client ID, passed to Google Sign-In as `serverClientId` so the
  /// issued ID token is audience-bound to the backend.
  static String get googleServerClientId =>
      dotenv.env['GOOGLE_SERVER_CLIENT_ID'] ?? '';

  /// iOS OAuth client ID, passed as `clientId` on iOS builds (empty elsewhere).
  static String get googleIosClientId =>
      dotenv.env['GOOGLE_IOS_CLIENT_ID'] ?? '';
}
