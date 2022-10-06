import 'package:platinum/features/person/domain/entities/trainer/trainer.dart';

class TrainerModel extends Trainer {
  TrainerModel({
    required int? id,
    required String fullName,
    required String phoneNum,
    required bool genderMale,
  }) : super(
          id: id,
          fullName: fullName,
          phoneNum: phoneNum,
          genderMale: genderMale,
        );
  factory TrainerModel.fromJson(Map<String, dynamic> json) {
    return TrainerModel(
      id: json['id'],
      fullName: json['fullName'],
      phoneNum: json['phoneNum'],
      genderMale: json['genderMale'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'phoneNum': phoneNum,
      'genderMale': genderMale,
    };
  }
}
