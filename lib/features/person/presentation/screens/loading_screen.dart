import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.accessible_forward_rounded),
        title: Text('Platinum'),
      ),
      body: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
