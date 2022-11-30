import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upgrader/upgrader.dart';

class LoadingScreen extends StatelessWidget {
  LoadingScreen({
    Key? key,
    required this.sharedPreferences,
  }) : super(key: key);
  final SharedPreferences sharedPreferences;

  final upgrader = Upgrader(
    canDismissDialog: false,
    showIgnore: false,
    showLater: false,
  );

  void isUserLoggedIn(BuildContext context) async {
    await Future.delayed(Duration(seconds: 3));
    if (await FirebaseAuth.instance.currentUser != null &&
        sharedPreferences.containsKey('apiToken')) {
      await Navigator.pushReplacementNamed(context, '/home');
    } else
      await Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    isUserLoggedIn(context);
    return UpgradeAlert(
      upgrader: upgrader,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 50,
                height: 50,
                child: Image.asset(
                  'icons/Logo_light.png',
                ),
              ),
              SizedBox(
                height: 50,
                width: 10,
              ),
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
