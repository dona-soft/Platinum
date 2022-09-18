import 'package:flutter/material.dart';
import 'package:platinum/core/themes/main_theme.dart';
import 'package:platinum/features/person/presentation/widgets/payments_screen/payment_item.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text('Platinum'),
        backgroundColor: LightTheme.primaryColorLight,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 15,
        itemBuilder: (context, index) {
          if (index < 10) {
            return PaymentItem();
          } else
            return Container();
        },
      ),
    );
  }
}
