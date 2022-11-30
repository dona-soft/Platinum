import 'package:flutter/material.dart';

class MyDialog extends StatelessWidget {
  const MyDialog({
    Key? key,
    required this.title,
    required this.actions,
    this.content,
  }) : super(key: key);

  final String title;
  final Widget? content;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: content,
      actions: actions,
    );
  }
}
