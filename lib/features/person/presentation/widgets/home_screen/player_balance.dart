import 'package:flutter/material.dart';

class BalanceWidget extends StatelessWidget {
  const BalanceWidget({
    Key? key,
    required this.balance,
    required this.subtitle,
  }) : super(key: key);

  final String balance, subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          subtitle,
          textDirection: TextDirection.rtl,
          style: TextStyle(color: Colors.white),
        ),
        Text(
          ' ل.س ' + balance,
          textDirection: TextDirection.rtl,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
