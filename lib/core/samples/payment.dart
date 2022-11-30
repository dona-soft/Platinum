import 'package:equatable/equatable.dart';

class Payment extends Equatable {
  final int? id, serial;
  final double value;
  final String? description;
  final DateTime dateTime;

  const Payment({
    required this.id,
    required this.serial,
    required this.value,
    required this.description,
    required this.dateTime,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      serial: json['serial'],
      id: json['id'],
      value: double.parse(json['PaymentValue'].toString()),
      description: json['des'],
      dateTime: DateTime.parse(json['PayDate']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'PaymentValue': value,
      'des': description,
      'PayDate': dateTime.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [id, value, dateTime];
}
