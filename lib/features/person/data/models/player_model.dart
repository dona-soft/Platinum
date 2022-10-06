import 'package:platinum/features/person/domain/entities/player/player.dart';

class PlayerModel extends Player {
  PlayerModel({
    required String fullName,
    required String phoneNum,
    required bool genderMale,
    required double weight,
    required double height,
    required String subscribeDate,
    required bool isSubscribed,
    required bool isTakenContainer,
    required String subscribeEndDate,
    required double balance,
  }) : super(
          fullName: fullName,
          phoneNum: phoneNum,
          genderMale: genderMale,
          weight: weight,
          height: height,
          balance: balance,
          subscribeDate: subscribeDate,
          isSubscribed: isSubscribed,
          isTakenContainer: isTakenContainer,
          subscribeEndDate: subscribeEndDate,
        );

  factory PlayerModel.fromJson(Map<String, dynamic> json) {
    return PlayerModel(
      fullName: json['fullName'],
      phoneNum: json['phoneNum'],
      genderMale: json['genderMale'],
      weight: json['weight'],
      height: json['height'],
      balance: json['balance'],
      subscribeDate: json['subscribeDate'],
      isSubscribed: json['isSubscribed'],
      isTakenContainer: json['isTakenContainer'],
      subscribeEndDate: json['subscribeEndDate'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'phoneNum': phoneNum,
      'genderMale': genderMale,
      'weight': weight,
      'height': height,
      'balance': balance,
      'subscribeDate': subscribeDate,
      'isSubscribed': isSubscribed,
      'isTakenContainer': isTakenContainer,
      'subscribeEndDate': subscribeEndDate,
    };
  }
}
