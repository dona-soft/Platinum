import 'package:flutter/material.dart';
import 'package:platinum/core/samples/payment.dart';
import 'package:intl/intl.dart' as intl;

class PaymentItem extends StatelessWidget {
  const PaymentItem({
    Key? key,
    required this.payment,
  }) : super(key: key);

  final Payment payment;

  final radius = 10.0;
  final margin = 10.0;

  String dateFormatter(DateTime dateTime) {
    final format = intl.DateFormat('yyyy-MM-dd');
    return format.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: margin, left: margin, right: margin),
      decoration: BoxDecoration(
        color: Colors.white,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                dateFormatter(payment.dateTime) + ' :تاريخ الدفعة',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.blueGrey,
                ),
              ),
              Text(
                'قيمة الدفعة: ' + payment.value.toString(),
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.blueGrey,
                ),
              ),
              Text(
                'الوصف: ' + payment.description.toString(),
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.blueGrey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
