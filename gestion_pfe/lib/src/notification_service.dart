import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static Future initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationsSettings = const InitializationSettings(
      android: AndroidInitializationSettings('mipmap/ic_launcher'),
    );

    await flutterLocalNotificationsPlugin.initialize(initializationsSettings);
  }

  Future showBigTextNotification(
      {var id = 0,
      required String title,
      required String body,
      var payload,
      required FlutterLocalNotificationsPlugin fln}) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails(
      'you_can_name_it_whatever1',
      'channel_name',
      playSound: true,
      // sound: RawResourceAndroidNotificationSound('notification'),
      importance: Importance.max,
      priority: Priority.high,
    ); // AndroidNotificationDetails

    var not = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    ); // NotificationDetails

    await fln.show(0, title, body, not);
  }
}
