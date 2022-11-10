import 'package:flutter/material.dart';
import 'package:platinum/core/connection/network_info.dart';
import 'package:platinum/core/constants/strings.dart';
import 'package:platinum/core/samples/payment.dart';
import 'package:platinum/core/themes/main_theme.dart';
import 'package:platinum/features/person/domain/usecases/get_all_payments.dart';
import 'package:platinum/features/person/presentation/widgets/loading_error.dart';
import 'package:platinum/features/person/presentation/widgets/payments_screen/payment_item.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({
    Key? key,
    required this.getAllPaymentsUsecase,
    required this.networkInfo,
  }) : super(key: key);

  final GetAllPaymentsUsecase getAllPaymentsUsecase;
  final NetworkInfo networkInfo;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late List<Payment>? listPlyPyt;

  String errMessage = '';

  Future<List<Payment>> loadPayments() async {
    final either = await widget.getAllPaymentsUsecase();
    either.fold(
      (fail) {
        //  Failure
        mapFailureToMessege(fail);
        throw Exception();
      },
      (list) {
        //  Success
        listPlyPyt = list;
      },
    );
    return listPlyPyt as List<Payment>;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: Text('Platinum'),
          backgroundColor: LightTheme.primaryColorLight,
          foregroundColor: Colors.white,
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            setState(() {});
            await Future.delayed(Duration(seconds: 3));
          },
          child: FutureBuilder<List<Payment>>(
            future: loadPayments(),
            builder: (context, asyncss) {
              if (asyncss.hasData)
                return ListView.builder(
                  itemCount: asyncss.data!.length,
                  itemBuilder: (context, index) {
                    return PaymentItem(
                      payment: asyncss.data![index],
                    );
                  },
                );
              else if (asyncss.hasError)
                return LoadingErrorWidget(
                    message: errMessage,
                    reload: () {
                      setState(() {});
                    });
              else
                return Center(child: CircularProgressIndicator());
            },
          ),
        ));
  }
}
