import 'package:platinum/features/person/domain/entities/person/person.dart';

class Player extends Person {
  final double  balance;
  final String subscribeDate, subEndDate;
  final bool isSub, isTakenContainer;

  Player(
      {int? id,
      required String fullName,
      required String phoneNum,
      required bool genderMale,
      required this.balance,
      required this.subscribeDate,
      required this.isSub,
      required this.isTakenContainer,
      required this.subEndDate})
      : super(
          id: id,
          fullName: fullName,
          phoneNum: phoneNum,
          genderMale: genderMale,
        );
}
