import 'package:dartz/dartz.dart';
import 'package:platinum/core/constants/strings.dart';
import 'package:platinum/core/errors/exceptions.dart';
import 'package:platinum/core/samples/offer.dart';
import 'package:platinum/core/samples/sport.dart';
import 'package:platinum/core/samples/training_program.dart';
import 'package:platinum/features/person/data/models/player_model.dart';
import 'package:platinum/features/person/domain/entities/player/aux/player_payment.dart';
import 'package:sqflite/sqflite.dart';

abstract class PlayerLocalSource {
  Future<List<Training>> getAllTrainings();
  Future<TrainingProgram> getCurrentProgram();
  Future<List<PlayerPayment>> getAllPlayerPayments();
  Future<List<Sport>> getAllSports();
  Future<List<Offer>> getAllOffers();
  Future<PlayerModel> getPlayerInfo();
  Future<Unit> savePlayerInfo(PlayerModel player);
  Future<Unit> saveOffers(List<Offer> offers);
  Future<Unit> saveAllTrainings(List<Training> trainings);
  Future<Unit> saveCurrentProgram(TrainingProgram tr);
  Future<Unit> saveSports(List<Sport> sports);
  Future<Unit> savePlayerPayments(List<PlayerPayment> payments);
}

class PlayerLocalSourceImpl implements PlayerLocalSource {
  final Database playerDatabase;

  const PlayerLocalSourceImpl({required this.playerDatabase});

  @override
  Future<TrainingProgram> getCurrentProgram() async {
    TrainingProgram trainingProgram;
    List<Training> temp = [];
    List<int> trainingIds = [];
    final result = await playerDatabase.query(PROGRAMS_TABLE);
    final trains = await playerDatabase.query(TRAININGS_TABLE);
    if (result.isNotEmpty) {
      String a = result.first['trainsApiIds'].toString();
      a.substring(1, a.length - 1).split(', ').forEach((element) {
        trainingIds.add(int.parse(element));
      });
      if (temp.isNotEmpty) {
        for (var i in trainingIds) {
          trains.forEach(
            (element) {
              if (i == element['apiKey']) {
                temp.add(Training.fromJson(element));
              }
            },
          );
        }
        trainingProgram = TrainingProgram(
          id: result.first['id'] as int,
          trainingCatagory: result.first['trainingCatagory'] as String,
          listOfTrains: temp,
          trainsApiIds: trainingIds,
        );
      } else {
        throw EmptyCacheException();
      }
    } else {
      throw EmptyCacheException();
    }
    return trainingProgram;
  }

  @override
  Future<List<Offer>> getAllOffers() async {
    List<Offer> localOffers = [];

    List<Map<String, dynamic>> temp = await playerDatabase.query(OFFERS_TABLE);
    if (temp.isNotEmpty) {
      for (var i in temp) {
        localOffers.add(Offer.fromJson(i));
      }
      return localOffers;
    } else {
      throw EmptyCacheException();
    }
  }

  @override
  Future<List<PlayerPayment>> getAllPlayerPayments() async {
    List<PlayerPayment> localPayments = [];
    List<Map<String, dynamic>> temp =
        await playerDatabase.query(PAYMENTS_TABLE);
    if (temp.isNotEmpty) {
      for (var i in temp) {
        localPayments.add(PlayerPayment.fromJson(i));
      }
      return localPayments;
    } else
      throw EmptyCacheException();
  }

  @override
  Future<List<Sport>> getAllSports() async {
    List<Sport> localSports = [];
    List<Map<String, dynamic>> temp = await playerDatabase.query(SPORTS_TABLE);
    if (temp.isNotEmpty) {
      for (var i in temp) {
        localSports.add(Sport.fromJson(i));
      }
      return localSports;
    } else
      throw EmptyCacheException();
  }

  @override
  Future<List<Training>> getAllTrainings() async {
    List<Training> localProgram = [];
    List<Map<String, dynamic>> temp =
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
    if (playerDatabase.isOpen) {
      for (var i in offers) {
        await playerDatabase.insert(OFFERS_TABLE, i.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
      return unit;
    } else {
      throw DataBaseException();
    }
  }

  @override
  Future<Unit> saveCurrentProgram(TrainingProgram tr) async {
    if (playerDatabase.isOpen) {
      await playerDatabase.update(
        TRAININGS_TABLE,
        tr.toMap(),
        where: '${tr.id} = ?',
        whereArgs: [tr.id],
      );

      return unit;
    } else
      throw DataBaseException();
  }

  @override
  Future<Unit> savePlayerPayments(List<PlayerPayment> payments) async {
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
    if (playerDatabase.isOpen) {
      for (var i in sports) {
        await playerDatabase.insert(TRAININGS_TABLE, i.toMap());
      }
      return unit;
    } else
      throw DataBaseException();
  }

  @override
  Future<PlayerModel> getPlayerInfo() async {
    PlayerModel player;
    List<Map<String, dynamic>> temp =
        await playerDatabase.query(PLAYER_STATS_TABLE);
    if (temp.isNotEmpty) {
      player = PlayerModel.fromJson(temp[0]);
      return player;
    } else
      throw DataBaseException();
  }

  @override
  Future<Unit> savePlayerInfo(PlayerModel player) async {
    if (playerDatabase.isOpen) {
      await playerDatabase.insert(TRAININGS_TABLE, player.toMap());
      return unit;
    } else
      throw DataBaseException();
  }
}
