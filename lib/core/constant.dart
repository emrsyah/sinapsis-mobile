import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  AppConstants._();

  static String get apiBaseUrl =>
      dotenv.env['API_BASE_URL'] ?? 'https://api.sinapsis.app';

  static String get reverbWsUrl =>
      dotenv.env['REVERB_WS_URL'] ?? 'wss://api.sinapsis.app';

  static String get reverbKey =>
      dotenv.env['REVERB_KEY'] ?? '';

  static String get uploadthingApiKey =>
      dotenv.env['UPLOADTHING_API_KEY'] ?? '';
}
