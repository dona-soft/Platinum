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

  factory PlayerPayment.fromJson(Map<String, dynamic> json) {
    return PlayerPayment(
      paymentValue: json['paymentValue'],
      description: json['description'],
      payDate: json['payDate'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'paymentValue': paymentValue,
      'payDate':payDate,
      'description': description,
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, paymentValue, payDate];
}
