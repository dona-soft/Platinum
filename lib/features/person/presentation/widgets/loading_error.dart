import 'package:flutter/material.dart';
import 'package:platinum/core/constants/strings.dart';

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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Icon(
        //   Icons.warning_amber_rounded,
        //   size: 50,
        //   color: Colors.orange,
        // ),
        Text(
          WTF,
          style: TextStyle(fontSize: 30, color: Colors.grey.shade700),
        ),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          textDirection: TextDirection.rtl,
          children: [
            Text(
              message,
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey.shade700,
              ),
            ),
            Material(
              color: Colors.transparent,
              child: IconButton(
                splashRadius: 20,
                onPressed: reload,
                icon: Icon(
                  Icons.cached_rounded,
                  size: 20,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
