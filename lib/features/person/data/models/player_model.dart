import 'package:platinum/features/person/domain/entities/player/player.dart';

class PlayerModel extends Player {
  PlayerModel({
    required String fullName,
    required String phoneNum,
    required String subscribeDate,
    required double balance,
    required bool genderMale,
    required bool isSubscribed,
    required bool isTakenContainer,
    required String subscribeEndDate,
  }) : super(
          fullName: fullName,
          phoneNum: phoneNum,
          genderMale: genderMale,
          balance: balance,
          subscribeDate: subscribeDate,
          isSub: isSubscribed,
          isTakenContainer: isTakenContainer,
          subEndDate: subscribeEndDate,
        );

  factory PlayerModel.fromJson(Map<String, dynamic> json) {
    return PlayerModel(
      fullName: json['FullName'],
      phoneNum: json['Phone'],
      balance: double.parse(json['Balance'].toString()),
      subscribeDate: json['SubscribeDate'],
      genderMale: json['GenderMale'] == 1 ? true : false,
      isSubscribed: json['isSubscribed'] == 1 ? true : false,
      isTakenContainer: json['isTakenContainer'] == 1 ? true : false,
      subscribeEndDate: json['SubscribeEndDate'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'FullName': fullName,
      'Phone': phoneNum,
      'GenderMale': genderMale,
      'Balance': balance,
      'SubscribeDate': subscribeDate,
      'isSubscribed': isSub,
      'isTakenContainer': isTakenContainer,
      'SubscribeEndDate': subEndDate,
    };
  }
}
