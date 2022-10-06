import 'package:flutter/material.dart';
import 'package:platinum/core/connection/network_info.dart';
import 'package:platinum/core/errors/failures.dart';
import 'package:platinum/core/themes/main_theme.dart';
import 'package:platinum/features/person/domain/entities/player/aux/player_payment.dart';
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
  late List<PlayerPayment>? listPlyPyt;

  String? errMessage;

  Future<bool> loadPayments() async {
    final either = await widget.getAllPaymentsUsecase();
    either.fold(
      (fail) {
        //  Failure
        _mapFailureToMessege(fail);
        throw Exception();
      },
      (list) {
        //  Success
        listPlyPyt = list;
      },
    );
    return true;
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
            await Future.delayed(Duration(seconds: 3));
            setState(() {});
          },
          child: FutureBuilder(
            future: loadPayments(),
            builder: (context, asyncss) {
              if (asyncss.hasData)
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: 15,
                  itemBuilder: (context, index) {
                    if (index < 10) {
                      return PaymentItem();
                    } else
                      return Container();
                  },
                );
              else if (asyncss.hasError)
                return LoadingErrorWidget(
                    message: errMessage ?? 'Error',
                    reload: () {
                      setState(() {});
                    });
              else
                return Center(child: CircularProgressIndicator());
            },
          ),
        ));
  }

  void _mapFailureToMessege(Failure fail) {
    switch (fail.runtimeType) {
      case ServerFailure:
        errMessage = 'Server Failure!';
        return;
      case OfflineFailure:
        errMessage = 'Offline Failure!';
        return;
      case EmptyCacheFailure:
        errMessage = 'Empty Cache Failure!';
        return;
      default:
    }
  }
}
