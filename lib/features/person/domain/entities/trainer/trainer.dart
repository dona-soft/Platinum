import 'package:platinum/features/person/domain/entities/person/person.dart';

class Trainer extends Person {
  final int apiKey;

  const Trainer({
    required int? id,
    required this.apiKey,
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
