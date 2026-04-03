import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;

@pragma('vm:entry-point')
Future<void> _firebaseBackgroundHandler(RemoteMessage message) async {
  // Handle background messages
}

class NotificationService {
  static final _local = FlutterLocalNotificationsPlugin();
  static const _channelId = 'sinapsis_channel';
  static const _channelName = 'Sinapsis';

  static Future<void> initialize() async {
    tz.initializeTimeZones();

    FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundHandler);

    await _local.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings(
          '@mipmap/ic_launcher',
        ),
        iOS: DarwinInitializationSettings(),
      ),
    );

    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Create notification channel for Android
    await _local
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(
          const AndroidNotificationChannel(
            _channelId,
            _channelName,
            importance: Importance.high,
          ),
        );

    // Foreground messages
    FirebaseMessaging.onMessage.listen(_showLocalNotification);
  }

  static Future<void> _showLocalNotification(RemoteMessage message) async {
    final notification = message.notification;
    if (notification == null) return;

    await _local.show(
      id: notification.title.hashCode ^ notification.body.hashCode,
      title: notification.title,
      body: notification.body,
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          _channelName,
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      payload: message.data['note_id'],
    );
  }

  static Future<String?> getToken() async {
    return FirebaseMessaging.instance.getToken();
  }
}
