import 'package:platinum/features/person/domain/entities/person/person.dart';

class Player extends Person {
  double weight, height;
  String subscribeDate, subscribeEndDate;
  bool isTakenContainer, isSubscribed;

  Player({
    int? id,
    required String fullName,
    required String phoneNum,
    required bool genderMale,
    required this.weight,
    required this.height,
    required this.subscribeDate,
    required this.isSubscribed,
    required this.isTakenContainer,
    required this.subscribeEndDate,
  }) : super(
          id: id,
          fullName: fullName,
          phoneNum: phoneNum,
          genderMale: genderMale,
        );
}
