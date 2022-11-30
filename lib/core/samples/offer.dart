import 'package:equatable/equatable.dart';

class Offer extends Equatable {
  final int? id;
  final int apiKey;
  final String name;
  final double percent;
  final int fullPay;
  final DateTime endDate;

  const Offer({
    required this.id,
    required this.apiKey,
    required this.name,
    required this.endDate,
    required this.percent,
    required this.fullPay,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json['serial'] ?? null,
      apiKey: json['id'],
      name: json['name'],
      endDate: DateTime.parse(json['endDate']),
      percent: double.parse('${json['percent']}'),
      fullPay: json['FullPay'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': apiKey,
      'name': name,
      'percent': percent,
      'endDate': endDate.toIso8601String(),
      'FullPay': fullPay,
    };
  }

  @override
  List<Object?> get props => [apiKey, name, endDate];
}
