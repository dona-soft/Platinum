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

  Map<String, dynamic> toMap(Sport sport) {
    return {
      'name': sport.name,
      'price': sport.price,
      'daysInWeek': sport.daysInWeek,
      'dailyPrice': sport.dailyPrice,
      'isActive': sport.isActive,
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, price, daysInWeek];
}
