import 'package:equatable/equatable.dart';

class PlayerTraining extends Equatable {
  final DateTime lastCheck, rollDate;
  final int price;
  final double priceAfterOffer;

  const PlayerTraining({
    required this.lastCheck,
    required this.price,
    required this.priceAfterOffer,
    required this.rollDate,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [rollDate, price];
}
