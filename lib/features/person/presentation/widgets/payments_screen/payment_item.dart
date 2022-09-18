import 'package:flutter/material.dart';

class PaymentItem extends StatelessWidget {
  const PaymentItem({Key? key}) : super(key: key);

  final radius = 10.0;
  final margin = 10.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: margin, left: margin, right: margin),
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: Colors.grey,
          width: 0.5,
        ),
      ),
      child: Material(
        elevation: 3,
        borderRadius: BorderRadius.circular(radius - 1),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              'Payments for -> month / year',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.blueGrey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
