import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {
  final _localNotification = FlutterLocalNotificationsPlugin();

  LocalNotificationService() {
    init();
  }

  Future<void> init() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    final iOS_Settings = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveNotification);

    final settings = InitializationSettings(
      android: androidSettings,
      iOS: iOS_Settings,
    );

    await _localNotification.initialize(settings,
        onSelectNotification: selectNotification);
    print("init finished!!");
  }

  Future<dynamic> onDidReceiveNotification(
      int id, String? title, String? body, String? payload) async {
    print(payload);
    return payload;
  }

  Future<NotificationDetails> notificationDetails() async {
    final androidDetails =
        AndroidNotificationDetails('channel_ID', 'channel_name', 'description');
    final iosDetails = IOSNotificationDetails();
    return NotificationDetails(android: androidDetails, iOS: iosDetails);
  }

  void showNotification({
    required int id,
    required String? title,
    required String? body,
  }) async {
    var details = await notificationDetails();
    _localNotification.show(
      id,
      title,
      body,
      details,
      payload: 'asdasdasd',
    );
  }

  Future<void> showSceduledNotify({
    required int id,
    required String? title,
    required String? body,
    required int seconds,
  }) async {
    final details = await notificationDetails();
    await _localNotification.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(
          DateTime.now().add(Duration(seconds: seconds)), tz.local),
      details,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }

  Future selectNotification(String? payload) async {
    print('payload selectNotification: $payload');
  }
}
