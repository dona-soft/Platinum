import 'package:flutter/material.dart';

class MyDialog extends StatelessWidget {
  const MyDialog({Key? key}) : super(key: key);

  final String title = '';

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('Change Info'),
      children: [
        Center(
          child: Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width * 0.5,
            child: Text('osama abo sada'),
          ),
        ),
        Center(
          child: Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width * 0.5,
            child: Text('0952419654'),
          ),
        ),
        Center(
          child: Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width * 0.5,
            child: Text('23'),
          ),
        ),
      ],
    );
  }
}
