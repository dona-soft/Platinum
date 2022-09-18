import 'package:equatable/equatable.dart';

class PlayerPayment extends Equatable {
  final int? id;
  final double paymentValue;
  final String payDate, description;

  const PlayerPayment({
    this.id,
    required this.paymentValue,
    required this.description,
    required this.payDate,
  });

  Map<String, dynamic> toMap(PlayerPayment payment) {
    return {
      'paymentValue': payment.paymentValue,
      'payDate': payment.payDate,
      'description': payment.description,
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
