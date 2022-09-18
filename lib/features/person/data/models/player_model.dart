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
  }) : super(
          fullName: fullName,
          phoneNum: phoneNum,
          genderMale: genderMale,
          weight: weight,
          height: height,
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
      subscribeDate: json['subscribeDate'],
      isSubscribed: json['isSubscribed'],
      isTakenContainer: json['isTakenContainer'],
      subscribeEndDate: json['subscribeEndDate'],
    );
  }
  
  Map<String, dynamic> toMap(PlayerModel playerModel) {
    return {
      'fullName': playerModel.fullName,
      'phoneNum': playerModel.phoneNum,
      'genderMale': playerModel.genderMale,
      'weight': playerModel.weight,
      'height': playerModel.height,
      'subscribeDate': playerModel.subscribeDate,
      'isSubscribed': playerModel.isSubscribed,
      'isTakenContainer': playerModel.isTakenContainer,
      'subscribeEndDate': playerModel.subscribeEndDate,
    };
  }
}
