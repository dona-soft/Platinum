import 'package:equatable/equatable.dart';
import 'package:platinum/core/samples/payment.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

class PaymentsInitial extends PaymentState{}

class LoadingPaymentState extends PaymentState {}

class LoadedPaymentState extends PaymentState {
  final List<Payment> payments;

  const LoadedPaymentState(this.payments);

  @override
  List<Object> get props => [payments];
}

class ErrorPaymentsState extends PaymentState {
  final String messege;

  ErrorPaymentsState(this.messege);

  @override
  List<Object> get props => [messege];
}
