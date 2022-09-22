import 'package:flutter/material.dart';
import 'package:platinum/core/themes/main_theme.dart';
import 'package:platinum/features/auth/login_screen.dart';
import 'package:platinum/features/person/presentation/screens/home_screen.dart';
import 'package:platinum/features/person/presentation/screens/loading_screen.dart';
import 'package:platinum/features/person/presentation/screens/payments_screen.dart';
import 'package:platinum/features/person/presentation/screens/training_screen.dart';

void main() {
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
      initialRoute: '/',
      routes: {
        '/': (_) => LoginScreen(),
        '/home': (_) => HomeScreen(),
        '/home/training': (context) =>
            TrainingScreen(trainingProgram: [1, 2, 3]),
        '/home/payment': (context) => PaymentScreen(),
        'loading': (context) => LoadingScreen(),
      },
      title: 'Platinum',
    );
  }
}
