import 'package:equatable/equatable.dart';

class Sport extends Equatable {
  final int? id;
  final int apiKey;
  final String name;
  final int price, daysInWeek;
  final double dailyPrice;
  final int? isActive;

  const Sport({
    required this.id,
    required this.apiKey,
    required this.dailyPrice,
    required this.daysInWeek,
    required this.name,
    required this.price,
    this.isActive,
  });

  factory Sport.fromJson(Map<String, dynamic> json) {
    return Sport(
        id: json['serial'] ?? null,
        apiKey: json['id'],
        dailyPrice: double.parse(json['DailyPrice'].toString()),
        daysInWeek: json['daysInWeek'],
        name: json['name'],
        price: json['price']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': apiKey,
      'name': name,
      'price': price,
      'daysInWeek': daysInWeek,
      'DailyPrice': dailyPrice,
      'isActive': isActive,
    };
  }

  @override
  List<Object?> get props => [apiKey, name, price, daysInWeek];
}
