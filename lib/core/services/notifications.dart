import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//   'high_importance_channel', // id
//   'High Importance Notifications', // title
//   'This channel is used for important notifications.', // description
//   importance: Importance.max,
// );

class LocalNotificationService {
  final _localNotification = FlutterLocalNotificationsPlugin();
  int _last_id = 0;

  LocalNotificationService() {
    init();
  }

  Future<void> init() async {
    await localNotificationInit();
    await registerNotification();
  }

  localNotificationInit() async {
    // await _localNotification
    //     .resolvePlatformSpecificImplementation<
    //         AndroidFlutterLocalNotificationsPlugin>()
    //     ?.createNotificationChannel(channel);

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@drawable/ic_notification');
    final iOS_Settings = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveNotification);

    final settings = InitializationSettings(
      android: androidSettings,
      iOS: iOS_Settings,
    );

    await _localNotification.initialize(settings,
        onSelectNotification: selectNotification);
  }

  Future<dynamic> onDidReceiveNotification(
      int id, String? title, String? body, String? payload) async {
    print('payload: $payload');
    return payload;
  }

  Future<NotificationDetails> notificationDetails() async {
    final androidDetails = AndroidNotificationDetails(
      'channel_ID',
      'channel_name',
      'description',
      importance: Importance.max,
    );
    final iosDetails = IOSNotificationDetails();
    return NotificationDetails(android: androidDetails, iOS: iosDetails);
  }

  void showNotification({
    required String? title,
    required String? body,
  }) async {
    var details = await notificationDetails();
    _localNotification.show(
      _last_id++,
      title,
      body,
      details,
      payload: 'simple payload',
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

  late final FirebaseMessaging _messaging;

  registerNotification() async {
    // 1. Initialize the Firebase app
    await Firebase.initializeApp();

    // 2. Instantiate Firebase Messaging
    _messaging = FirebaseMessaging.instance;

    // 3. On iOS, this helps to take the user permissions
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        // Parse the message received
        PushNotification notification = PushNotification(
          title: message.notification?.title,
          body: message.notification?.body,
        );

        showNotification(title: notification.title, body: notification.body);
        print('DEBUG: notify: ${notification.title} :: ${notification.body}');
      });
    } else {
      print('User declined or has not accepted permission');
    }
  }

  // For handling notification when the app is in terminated state
  checkForInitialMessage() async {
    await Firebase.initializeApp();
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      PushNotification notification = PushNotification(
        title: initialMessage.notification?.title,
        body: initialMessage.notification?.body,
      );

      showNotification(title: notification.title, body: notification.body);
    }
  }
}

class PushNotification {
  PushNotification({
    this.title,
    this.body,
  });
  String? title;
  String? body;
}
