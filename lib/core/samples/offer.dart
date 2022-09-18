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

  Map<String, dynamic> toMap(Offer offer) {
    return {
      'name': offer.name,
      'percent': offer.percent,
      'endDate': offer.endDate,
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, endDate];
}
