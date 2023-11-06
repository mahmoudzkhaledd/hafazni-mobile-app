import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotifiactionServices {
  static NotifiactionServices instance = NotifiactionServices();
  final FlutterLocalNotificationsPlugin plugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const settings = InitializationSettings(
      android: AndroidInitializationSettings('mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    await plugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (details) {
        if (kDebugMode) {
          print('============================================');
          print(details.payload);
          print('============================================');
        }
      },
    );
  }

  void sendNotification(String title, String body) async {
    const details = AndroidNotificationDetails(
      'high_importance_channel',
      'channelName',
      playSound: true,
      importance: Importance.max,
      priority: Priority.high,
    );

    await plugin.show(
      0,
      title,
      body,
      const NotificationDetails(
        android: details,
        iOS: DarwinNotificationDetails(),
      ),
    );
  }
}
