import 'package:platinum/features/person/domain/entities/trainer/trainer.dart';

class TrainerModel extends Trainer {
  TrainerModel({
    required int? id,
    required int apiKey,
    required String fullName,
    required String phoneNum,
    required bool genderMale,
  }) : super(
          id: id,
          apiKey: apiKey,
          fullName: fullName,
          phoneNum: phoneNum,
          genderMale: genderMale,
        );
  factory TrainerModel.fromJson(Map<String, dynamic> json) {
    print(json);
    return TrainerModel(
      id: json['key'] ?? null,
      apiKey: json['id'],
      fullName: json['FullName'],
      phoneNum: json['Phone'],
      genderMale: json['GenderMale'] == 1? true:false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': apiKey,
      'FullName': fullName,
      'Phone': phoneNum,
      'GenderMale': genderMale? 1:0,
    };
  }
}
