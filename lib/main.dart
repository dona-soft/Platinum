import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:platinum/core/services/notifications.dart';
import 'package:platinum/core/themes/main_theme.dart';
import 'package:platinum/features/auth/login_screen.dart';
import 'package:platinum/features/person/presentation/screens/home_screen.dart';
import 'package:platinum/features/person/presentation/screens/loading_screen.dart';
import 'package:platinum/features/person/presentation/screens/payments_screen.dart';
import 'package:platinum/features/person/presentation/screens/profile_screen.dart';
import 'package:platinum/features/person/presentation/screens/status_screen.dart';
import 'package:platinum/features/person/presentation/screens/training_screen.dart';
import 'injection_dependency.dart' as di;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print(
      'DEBUG: Handling a background message: ${message.notification?.title} :: ${message.notification?.body}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();

  final notifyService = LocalNotificationService();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  // FirebaseMessaging.instance.getToken().then((value) => print(value));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.orange,
        primaryColor: LightTheme.primaryColorLight,
      ),
      initialRoute: '/login',
      routes: {
        '/loading': (_) => new LoadingScreen(),
        '/login': (_) => LoginScreen(
              networkInfo: di.sl(),
              
            ),
        '/home': (_) => HomeScreen(
              offersUsecase: di.sl(),
              trainersUsecase: di.sl(),
              networkInfo: di.sl(),
            ),
        '/home/training': (_) => TrainingScreen(
              programsUsecase: di.sl(),
              networkInfo: di.sl(),
            ),
        '/home/payment': (_) => PaymentScreen(
              getAllPaymentsUsecase: di.sl(),
              networkInfo: di.sl(),
            ),
        '/home/calender': (_) => CalenderScreen(),
        '/home/profile': (_) => ProfileScreen(),
      },
      title: 'Platinum',
    );
  }
}
