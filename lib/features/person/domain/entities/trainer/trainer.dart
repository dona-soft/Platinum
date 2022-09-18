import 'package:platinum/features/person/domain/entities/person/person.dart';

class Trainer extends Person {

  const Trainer({
    required int? id,
    required String fullName,
    required String phoneNum,
    required bool genderMale,
  }) : super(
          fullName: fullName,
          id: id,
          phoneNum: phoneNum,
          genderMale: genderMale,
        );
}
