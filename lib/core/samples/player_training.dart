import 'package:equatable/equatable.dart';

class PlayerTraining extends Equatable {
  final String trainer, sport;
  final String? offer;
  final DateTime lastCheck, rollDate;
  final int price;
  final double? priceAfterOffer;

  const PlayerTraining({
    required this.lastCheck,
    required this.price,
    required this.priceAfterOffer,
    required this.rollDate,
    required this.offer,
    required this.sport,
    required this.trainer,
  });

  factory PlayerTraining.fromJson(Map<String, dynamic> json) {
    return PlayerTraining(
      rollDate: DateTime.parse(json['rollDate']),
      lastCheck: DateTime.parse(json['LastCheck']),
      price: json['Price'],
      priceAfterOffer: json['PriceAfterOffer'] != null
          ? double.parse(json['PriceAfterOffer'].toString())
          : null,
      offer: json['Offer'],
      sport: json['Sport'],
      trainer: json['trainer'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'LastCheck': lastCheck.toIso8601String(),
      'rollDate': rollDate.toIso8601String(),
      'Price': price,
      'trainer': trainer,
      'Sport': sport,
      'Offer': offer,
      'PriceAfterOffer': priceAfterOffer,
    };
  }

  @override
  List<Object?> get props => [rollDate, price];
}
