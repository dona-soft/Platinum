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
  Future<List<TrainingProgram>> getAllPrograms();
  Future<List<PlayerPayment>> getAllPlayerPayments();
  Future<List<Sport>> getAllSports();
  Future<List<Offer>> getAllOffers();
  Future<PlayerModel> getPlayerInfo();
  Future<Unit> savePlayerInfo(PlayerModel player);
  Future<Unit> saveOffers(List<Offer> offers);
  Future<Unit> savePrograms(List<TrainingProgram> tr);
  Future<Unit> saveSports(List<Sport> sports);
  Future<Unit> savePlayerPayments(List<PlayerPayment> payments);
}

class PlayerLocalSourceImpl implements PlayerLocalSource {
  final Database playerDatabase;

  const PlayerLocalSourceImpl({required this.playerDatabase});

  @override
  Future<List<Offer>> getAllOffers() async {
    List<Offer> localOffers = [];
    List<Map<String, dynamic>> temp = await playerDatabase.query(OFFERS_TABLE);
    if (temp.isNotEmpty) {
      for (var i in temp) {
        localOffers.add(
          Offer(
            id: i['id'],
            name: i['name'],
            endDate: i['endDate'],
            percent: i['percent'],
          ),
        );
      }
      return localOffers;
    } else
      throw EmptyCacheException();
  }

  @override
  Future<List<PlayerPayment>> getAllPlayerPayments() async {
    List<PlayerPayment> localPayments = [];
    List<Map<String, dynamic>> temp =
        await playerDatabase.query(PAYMENTS_TABLE);
    if (temp.isNotEmpty) {
      for (var i in temp) {
        localPayments.add(
          PlayerPayment(
            paymentValue: i['paymentValue'],
            description: i['discount'],
            payDate: i['payDate'],
          ),
        );
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
        localSports.add(Sport(
            id: i['id'],
            dailyPrice: i['dailyPrice'],
            daysInWeek: i['daysInWeek'],
            name: i['name'],
            price: i['price']));
      }
      return localSports;
    } else
      throw EmptyCacheException();
  }

  @override
  Future<List<TrainingProgram>> getAllPrograms() async {
    List<TrainingProgram> localProgram = [];
    List<Map<String, dynamic>> temp =
        await playerDatabase.query(PROGRAMS_TABLE);
    if (temp.isNotEmpty) {
      for (var i in temp) {
        localProgram.add(
          TrainingProgram(
            id: i['id'],
            listOfTrains: i['listOfTrains'],
            trainingCatagory: i['trainingCategory'],
          ),
        );
      }
      return localProgram;
    } else
      throw EmptyCacheException();
  }

  @override
  Future<Unit> saveOffers(List<Offer> offers) async {
    if (playerDatabase.isOpen) {
      for (var i in offers) {
        await playerDatabase.insert(OFFERS_TABLE, i.toMap(i));
      }
      return unit;
    } else {
      throw DataBaseException();
    }
  }

  @override
  Future<Unit> savePrograms(List<TrainingProgram> tr) async {
    if (playerDatabase.isOpen) {
      for (var i in tr) {
        await playerDatabase.insert(PROGRAMS_TABLE, i.toMap(i));
      }
      return unit;
    } else
      throw DataBaseException();
  }

  @override
  Future<Unit> savePlayerPayments(List<PlayerPayment> payments) async {
    if (playerDatabase.isOpen) {
      for (var i in payments) {
        await playerDatabase.insert(PAYMENTS_TABLE, i.toMap(i));
      }
      return unit;
    } else
      throw DataBaseException();
  }

  @override
  Future<Unit> saveSports(List<Sport> sports) async {
    if (playerDatabase.isOpen) {
      for (var i in sports) {
        await playerDatabase.insert(PROGRAMS_TABLE, i.toMap(i));
      }
      return unit;
    } else
      throw DataBaseException();
  }

  @override
  Future<PlayerModel> getPlayerInfo() async {
    PlayerModel player;
    List<Map<String, dynamic>> temp = await playerDatabase.query(PLAYER_TABLE);
    if (temp.isNotEmpty) {

      player = PlayerModel(
        fullName: temp[0]['fullName'],
        phoneNum: temp[0]['phoneNum'],
        genderMale: temp[0]['genderMale'],
        weight: temp[0]['weight'],
        height: temp[0]['height'],
        subscribeDate: temp[0]['subscribeDate'],
        isSubscribed: temp[0]['isSubscribed'],
        isTakenContainer: temp[0]['isTakenContainer'],
        subscribeEndDate: temp[0]['subscribeEndDate'],
      );
      return player;
    } else
      throw DataBaseException();
  }

  @override
  Future<Unit> savePlayerInfo(PlayerModel player) async {
    if (playerDatabase.isOpen) {
      await playerDatabase.insert(PROGRAMS_TABLE, player.toMap(player));

      return unit;
    } else
      throw DataBaseException();
  }
}
