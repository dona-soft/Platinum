import 'package:flutter/material.dart';

class BodyPart extends StatelessWidget {
  const BodyPart({
    Key? key,
    required this.image,
    required this.title,
    required this.status,
  }) : super(key: key);

  final Widget image;
  final String title, status;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            offset: Offset(0, 3),
            blurRadius: 3,
            spreadRadius: 0.001,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: image,
          ),
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Expanded(
            flex: 6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(status),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
