import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:platinum/core/constants/strings.dart';
import 'package:platinum/core/errors/exceptions.dart';
import 'package:platinum/core/samples/offer.dart';
import 'package:platinum/core/samples/payment.dart';
import 'package:platinum/core/samples/player_status.dart';
import 'package:platinum/core/samples/player_training.dart';
import 'package:platinum/core/samples/sport.dart';
import 'package:platinum/core/samples/training_program.dart';
import 'package:platinum/features/person/data/models/player_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PlayerRemoteSource {
  Future<List<Training>> getAllTrainings();
  Future<List<TrainingProgram>> getCurrentProgram();
  Future<List<Payment>> getAllPlayerPayments();
  Future<List<Sport>> getAllSports();
  Future<List<Offer>> getAllOffers();
  Future<PlayerModel> getPlayerInfo();
  Future<List<PlayerStatus>> getPlayerMetrics();
  Future<List<PlayerTraining>> getPlayerSubs();
}

class PlayerRemoteSourceImpl extends PlayerRemoteSource {
  final SharedPreferences sharedPrefs;
  String token = '';

  PlayerRemoteSourceImpl({
    required this.sharedPrefs,
  }) {
    token = sharedPrefs.getString('apiToken') as String;
  }

  /// data: [
  ///   id:
  ///   program:
  ///   sport_id:
  ///   trainings:[
  ///     program_id:
  ///     catagory_id:  NOT NEEDED!!!
  ///     catagory:
  ///     training:
  ///     rounds:
  ///     count:
  ///   ]
  /// ]

  @override
  Future<List<TrainingProgram>> getCurrentProgram() async {
    List<TrainingProgram> returnList = [];
    Map<String, dynamic> trainingProgram = {};
    List<Training> listOfTrainings = [];

    final response = await callApi(HTTP_PLAYER_PROGRAM);
    print('Debug: trainingProgram status = ${response.body}');

    if (response.statusCode == 200) {
      final programs = jsonDecode(response.body)['data'];

      trainingProgram.clear();
      listOfTrainings.clear();
      final trProgTemp = Map<String, dynamic>.from(programs);
      final List<dynamic> trainings = trProgTemp['trainings'];
      trainings.forEach((element) {
        final train = Map<String, dynamic>.from(element);
        listOfTrainings.add(Training.fromJson(train));
      });
      trProgTemp.remove('trainings');
      trProgTemp.addAll({'listOfTrains': listOfTrainings});
      returnList.add(TrainingProgram.fromJson(trProgTemp));
    } else {
      throw ServerException();
    }
    print('Debug: ${returnList.length}');
    return returnList;
  }

  @override
  Future<List<Offer>> getAllOffers() async {
    final response = await callApi(HTTP_PLAYER_OFFERS);
    print('response code = ${response.statusCode}');

    List<dynamic> data = jsonDecode(response.body)['data'];
    List<Offer> offers = [];
    var now = DateTime.now();
    data.forEach((map) {
      var a = Map<String, dynamic>.from(map);
      if (now.compareTo(DateTime.parse(a['endDate'])) > 0)
        offers.add(Offer.fromJson(a));
    });
    // throw ServerException();
    return offers;
  }

  @override
  Future<List<Payment>> getAllPlayerPayments() async {
    List<Payment> paymentList = [];
    final response = await callApi(HTTP_PLAYER_PAYMENTS);
    List<dynamic> temp = jsonDecode(response.body)['data'];
    temp.forEach(
      (element) {
        final a = Map<String, dynamic>.from(element);
        paymentList.add(Payment.fromJson(a));
      },
    );
    print(temp);
    print('Debug: payments remote = ${response.body}');
    return paymentList;
  }

  @override
  Future<List<Training>> getAllTrainings() async {
    final response = await callApi(HTTP_PLAYER_TRAININGS);
    print('DEBUG: Trainings body: ${response.body}');

    return [];
  }

  @override
  Future<List<Sport>> getAllSports() async {
    List<Sport> list = [];
    final response = await callApi(HTTP_PLAYER_SPORTS);
    print('Sports: ${response.statusCode}');
    print('Sports: ${response.body}');

    if (response.statusCode == 200) {
      List<dynamic> json = jsonDecode(response.body)['data'];
      json.forEach((map) {
        final temp = Map<String, dynamic>.from(map);
        list.add(Sport.fromJson(temp));
      });
    } else {
      throw ServerException();
    }
    return list;
  }

  @override
  Future<PlayerModel> getPlayerInfo() async {
    PlayerModel playerModel;
    final response = await callApi(HTTP_PLAYER_URL);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body)['data'];
      print(json);
      json = Map<String, dynamic>.from(json);
      playerModel = PlayerModel.fromJson(json);
    } else {
      throw ServerException();
    }
    return playerModel;
  }

  @override
  Future<List<PlayerStatus>> getPlayerMetrics() async {
    List<PlayerStatus> list = [];
    final response = await callApi(HTTP_PLAYER_METRICS);
    print(response.statusCode);
    if (response.statusCode == 200) {
      List<dynamic> temp = jsonDecode(response.body)['data'];
      temp.forEach((element) {
        final a = Map<String, dynamic>.from(element);
        list.add(PlayerStatus.fromJson(a));
      });
      print(list);
      return list;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<PlayerTraining>> getPlayerSubs() async {
    List<PlayerTraining> returnList = [];
    final response = await callApi(HTTP_PLAYER_TRAININGS);
    print('Debug: playerTraining = ${response.body}');
    if (response.statusCode == 200) {
      final List<dynamic> tempList = jsonDecode(response.body)['data'];
      tempList.forEach((element) {
        final subscr = Map<String, dynamic>.from(element);
        returnList.add(PlayerTraining.fromJson(subscr));
      });
    } else {
      throw ServerException();
    }
    return returnList;
  }

  Future<http.Response> callApi(
    String url,
  ) async {
    print('Debug: Api Token = $token');
    return await http.get(Uri.parse(url), headers: {
      'Accept': 'application/vnd.api+json',
      'content-type': 'application/vnd.api+json',
      'Authorization': 'Bearer $token',
    });
  }
}
