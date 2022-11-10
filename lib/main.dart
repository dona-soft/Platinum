import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:platinum/core/services/notifications.dart';
import 'package:platinum/core/themes/main_theme.dart';
import 'package:platinum/features/person/presentation/screens/about_screen.dart';
import 'package:platinum/features/person/presentation/screens/login_screen.dart';
import 'package:platinum/features/person/presentation/screens/home_screen.dart';
import 'package:platinum/features/person/presentation/screens/loading_screen.dart';
import 'package:platinum/features/person/presentation/screens/payments_screen.dart';
import 'package:platinum/features/person/presentation/screens/profile_screen.dart';
import 'package:platinum/features/person/presentation/screens/sports_and_trainers.dart';
import 'package:platinum/features/person/presentation/screens/status_screen.dart';
import 'package:platinum/features/person/presentation/screens/subsciptions_screen.dart';
import 'package:platinum/features/person/presentation/screens/training_screen.dart';
import 'injection_dependency.dart' as di;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print(message.data);
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

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.orange,
        primaryColor: LightTheme.primaryColorLight,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (_) => new LoadingScreen(sharedPreferences: di.sl()),
        '/login': (_) =>
            LoginScreen(networkInfo: di.sl(), sharedPreferences: di.sl()),
        '/home': (_) => HomeScreen(
            offersUsecase: di.sl(),
            playerInfoUsecase: di.sl(),
            networkInfo: di.sl()),
        '/home/training': (_) => TrainingScreen(
              sportsUsecase: di.sl(),
              programsUsecase: di.sl(),
              networkInfo: di.sl(),
            ),
        '/home/sport': (context) => SportsAndTrainersScr(
            sportsUsecase: di.sl(), trainersUsecase: di.sl()),
        '/home/calender': (_) => StatusScreen(statusUsecase: di.sl()),
        '/home/profile': (_) => ProfileScreen(playerInfoUsecase: di.sl(),sharedPreferences: di.sl()),
        '/home/profile/subs': (context) => SubscriptionsScreen(subsUsecase: di.sl()),
        '/home/profile/about': (context) => AboutScreen(),
        '/home/profile/payment': (_) =>
            PaymentScreen(getAllPaymentsUsecase: di.sl(), networkInfo: di.sl()),
      },
      title: 'Platinum',
    );
  }
}
