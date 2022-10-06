import 'package:equatable/equatable.dart';

class Offer extends Equatable {
  final int? id;
  final String name;
  final double percent;
  final DateTime endDate;

  const Offer({
    required this.id,
    required this.name,
    required this.endDate,
    required this.percent,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json['id'],
      name: json['name'],
      endDate: json['endDate'],
      percent: json['percent'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'percent': percent,
      'endDate': endDate,
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, endDate];
}
