import 'package:equatable/equatable.dart';

class PlayerTraining extends Equatable {
  DateTime lastCheck, rollDate;
  int price;
  double priceAfterOffer;
  int monthCount;

  PlayerTraining({
    required this.lastCheck,
    required this.monthCount,
    required this.price,
    required this.priceAfterOffer,
    required this.rollDate,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [rollDate, price, monthCount];
}
