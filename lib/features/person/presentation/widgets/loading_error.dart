import 'package:flutter/material.dart';

typedef CallBack = void Function();

class LoadingErrorWidget extends StatelessWidget {
  const LoadingErrorWidget({
    Key? key,
    required this.message,
    required this.reload,
  }) : super(key: key);

  final String message;
  final CallBack reload;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error_outline_rounded,
          size: 50,
          color: Colors.red,
        ),
        SizedBox(height: 10),
        Text(
          message,
          style: TextStyle(
            fontSize: 20,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: 10),
        IconButton(
          onPressed: reload,
          icon: Icon(
            Icons.replay_circle_filled_outlined,
            size: 30,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}
