import 'package:flutter/material.dart';
import 'package:platinum/features/workouts/presentation/screens/home_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Platinum',
      initialRoute: '/',
      routes: {
        '/homepage': (context) => const HomePage(),
      },
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void checkIfLoggedIn() async {
    await Future.delayed(const Duration(seconds: 2));
    Navigator.pushReplacementNamed(context, '/homepage');
  }

  @override
  Widget build(BuildContext context) {
    checkIfLoggedIn();
    return Scaffold(
      body: Center(
        child: Column(
          children: const [
            Icon(Icons.adb),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
