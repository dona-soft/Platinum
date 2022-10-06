import 'package:equatable/equatable.dart';

class Payment extends Equatable {
  final int? id;
  final double value;
  final String? description;
  final DateTime dateTime;

  const Payment({
    required this.id,
    required this.value,
    required this.description,
    required this.dateTime,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'],
      value: json['value'],
      description: json['description'],
      dateTime: json['dateTime'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'value': value,
      'description': description,
      'dateTime': dateTime,
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, value, dateTime];
}
