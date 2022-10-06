import 'package:equatable/equatable.dart';

class Sport extends Equatable {
  final int? id;
  final String name;
  final int price, daysInWeek;
  final double dailyPrice;
  final bool? isActive;

  const Sport({
    required this.id,
    required this.dailyPrice,
    required this.daysInWeek,
    required this.name,
    required this.price,
    this.isActive,
  });

  factory Sport.fromJson(Map<String, dynamic> json) {
    return Sport(
        id: json['id'],
        dailyPrice: json['dailyPrice'],
        daysInWeek: json['daysInWeek'],
        name: json['name'],
        price: json['price']);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'daysInWeek': daysInWeek,
      'dailyPrice': dailyPrice,
      'isActive': isActive,
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, price, daysInWeek];
}
