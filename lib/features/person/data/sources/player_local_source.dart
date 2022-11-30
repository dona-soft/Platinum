import 'package:dartz/dartz.dart';
import 'package:platinum/core/constants/strings.dart';
import 'package:platinum/core/errors/exceptions.dart';
import 'package:platinum/core/samples/offer.dart';
import 'package:platinum/core/samples/payment.dart';
import 'package:platinum/core/samples/player_status.dart';
import 'package:platinum/core/samples/player_training.dart';
import 'package:platinum/core/samples/sport.dart';
import 'package:platinum/core/samples/training_program.dart';
import 'package:platinum/features/person/data/models/player_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class PlayerLocalSource {
  Future<List<Training>> getAllTrainings();
  Future<List<TrainingProgram>> getCurrentProgram();
  Future<List<Payment>> getAllPlayerPayments();
  Future<List<Sport>> getAllSports();
  Future<List<Offer>> getAllOffers();
  Future<PlayerModel> getPlayerInfo();
  Future<List<PlayerStatus>> getPlayerMetrics();
  Future<List<PlayerTraining>> getPlayerSubs();

  Future<Unit> saveOffers(List<Offer> offers);
  Future<Unit> saveAllTrainings(List<Training> trainings);
  Future<Unit> saveCurrentProgram(List<TrainingProgram> tr);
  Future<Unit> saveSports(List<Sport> sports);
  Future<Unit> savePlayerPayments(List<Payment> payments);
  Future<Unit> savePlayerInfo(PlayerModel player);
  Future<Unit> savePlayerMetrics(List<PlayerStatus> playerStatus);
  Future<Unit> savePlayerSubs(List<PlayerTraining> subsList);
}

class PlayerLocalSourceImpl implements PlayerLocalSource {
  final Database playerDatabase;

  const PlayerLocalSourceImpl({required this.playerDatabase});

  // PlayerLocalSourceImpl({required this.playerDatabase}) {
  //   deleteDatabase(playerDatabase.path);
  // }

  @override
  Future<List<TrainingProgram>> getCurrentProgram() async {
    List<TrainingProgram> trainingProgram = [];
    List<Training> trList = [];
    final localProgList = await playerDatabase.query(PROGRAMS_TABLE);
    final List<Training> localtrainsList = await getAllTrainings();

    if (localProgList.isNotEmpty) {
      localProgList.forEach((trProg) {
        localtrainsList.forEach((training) {
          if (trProg['id'] == training.programId) {
            trList.add(training);
          }
        });

        trProg.addAll({'listOfTrains': trList});
        trainingProgram.add(
          TrainingProgram.fromJson(trProg),
        );
      });
    } else {
      throw EmptyCacheException();
    }
    if (trainingProgram.isEmpty) {
      throw EmptyCacheException();
    }
    return trainingProgram;
  }

  /// finished
  @override
  Future<List<Offer>> getAllOffers() async {
    List<Offer> localOffers = [];

    List<Map<String, dynamic>> temp = await playerDatabase.query(OFFERS_TABLE);
    if (temp.isNotEmpty) {
      final now = DateTime.now();
      for (var i in temp) {
        if (now.compareTo(DateTime.parse(i['endDate'])) > 0) // now > EndDate
          localOffers.add(Offer.fromJson(i));
      }
      return localOffers;
    } else {
      throw EmptyCacheException();
    }
  }

  // finished
  @override
  Future<List<Payment>> getAllPlayerPayments() async {
    List<Payment> localPayments = [];
    List<Map<String, dynamic>> temp =
        await playerDatabase.query(PAYMENTS_TABLE);

    if (temp.isNotEmpty) {
      for (var i in temp) {
        localPayments.add(Payment.fromJson(i));
      }
      return localPayments;
    } else
      throw EmptyCacheException();
  }

  /// finished
  @override
  Future<List<Sport>> getAllSports() async {
    List<Sport> localSports = [];
    List<Map<String, dynamic>> temp = await playerDatabase.query(SPORTS_TABLE);
    if (temp.isNotEmpty) {
      for (var i in temp) {
        localSports.add(Sport.fromJson(i));
      }
      print("Debug => localSports Length: ${localSports.length}");
      return localSports;
    } else
      throw EmptyCacheException();
  }

  @override
  Future<List<Training>> getAllTrainings() async {
    List<Training> localProgram = [];
    final List<Map<String, dynamic>> temp =
        await playerDatabase.query(TRAININGS_TABLE);
    if (temp.isNotEmpty) {
      for (var i in temp) {
        localProgram.add(Training.fromJson(i));
      }
      return localProgram;
    } else
      throw EmptyCacheException();
  }

  @override
  Future<Unit> saveAllTrainings(List<Training> trainings) async {
    if (playerDatabase.isOpen) {
      for (var i in trainings) {
        await playerDatabase.insert(TRAININGS_TABLE, i.toMap());
      }
      return unit;
    } else
      throw DataBaseException();
  }

  @override
  Future<Unit> saveOffers(List<Offer> offers) async {
    await playerDatabase.delete(OFFERS_TABLE);

    if (playerDatabase.isOpen) {
      for (var i in offers) {
        await playerDatabase.insert(OFFERS_TABLE, i.toMap());
      }
      return unit;
    } else {
      throw DataBaseException();
    }
  }

  /// this method needs refractoring and re-coding because it's
  /// useless right now...
  @override
  Future<Unit> saveCurrentProgram(List<TrainingProgram> tr) async {
    
    Map<String, dynamic> program = {};
    if (playerDatabase.isOpen) {
      await playerDatabase.delete(PROGRAMS_TABLE);
      await playerDatabase.delete(TRAININGS_TABLE);

      tr.forEach((element) async {
        program = element.toMap();
        final listT = element.listOfTrains;
        await playerDatabase.insert(PROGRAMS_TABLE, program);
        listT.forEach((element) async {
          await playerDatabase.insert(TRAININGS_TABLE, element.toMap());
        });
      });

      return unit;
    } else
      throw DataBaseException();
  }

  @override
  Future<Unit> savePlayerPayments(List<Payment> payments) async {
    await playerDatabase.delete(PAYMENTS_TABLE);
    if (playerDatabase.isOpen) {
      for (var i in payments) {
        await playerDatabase.insert(PAYMENTS_TABLE, i.toMap());
      }
      return unit;
    } else
      throw DataBaseException();
  }

  @override
  Future<Unit> saveSports(List<Sport> sports) async {
    await playerDatabase.delete(SPORTS_TABLE);

    if (playerDatabase.isOpen) {
      for (var i in sports) {
        await playerDatabase.insert(SPORTS_TABLE, i.toMap());
      }
    }
    return unit;
  }

  @override
  Future<PlayerModel> getPlayerInfo() async {
    PlayerModel player;
    final temp = await playerDatabase.query(PLAYER_STATS_TABLE);
    if (temp.isNotEmpty) {
      player = PlayerModel.fromJson(temp.first);
      return player;
    } else
      throw EmptyCacheException();
  }

  @override
  Future<Unit> savePlayerInfo(PlayerModel player) async {
    await playerDatabase.delete(PLAYER_STATS_TABLE);
    if (playerDatabase.isOpen) {
      await playerDatabase.insert(PLAYER_STATS_TABLE, player.toMap());
      return unit;
    } else
      throw DataBaseException();
  }

  @override
  Future<List<PlayerStatus>> getPlayerMetrics() async {
    List<PlayerStatus> list = [];
    final localRes = await playerDatabase.query(METRICS_TABLE);
    if (localRes.isNotEmpty) {
      localRes.forEach((element) {
        final a = Map<String, dynamic>.from(element);
        list.add(PlayerStatus.fromJson(a));
      });
      list.forEach((element) {
        print(element.toMap());
      });
      return list;
    } else {
      throw EmptyCacheException();
    }
  }

  @override
  Future<Unit> savePlayerMetrics(List<PlayerStatus> playerStatus) async {
    // await playerDatabase.delete(PLAYER_STATS_TABLE);
    if (playerDatabase.isOpen) {
      for (var i in playerStatus) {
        await playerDatabase.insert(METRICS_TABLE, i.toMap());
      }
      return unit;
    } else {
      throw DataBaseException();
    }
  }

  @override
  Future<List<PlayerTraining>> getPlayerSubs() async {
    List<PlayerTraining> list = [];
    if (playerDatabase.isOpen) {
      final localRes = await playerDatabase.query(TRAINING_RESOURCE_TABLE);
      localRes.forEach((element) {
        list.add(PlayerTraining.fromJson(element));
      });
      if (localRes.isEmpty) throw EmptyCacheException();
    } else {
      throw DataBaseException();
    }
    return list;
  }

  @override
  Future<Unit> savePlayerSubs(List<PlayerTraining> subsList) async {
    await playerDatabase.delete(TRAINING_RESOURCE_TABLE);
    for (var i in subsList) {
      await playerDatabase.insert(TRAINING_RESOURCE_TABLE, i.toMap());
    }

    return unit;
  }
}
