import 'package:dartz/dartz.dart';
import 'package:platinum/core/errors/exceptions.dart';
import 'package:platinum/core/samples/offer.dart';
import 'package:platinum/core/samples/sport.dart';
import 'package:platinum/core/samples/training_program.dart';
import 'package:platinum/features/person/domain/entities/player/aux/player_payment.dart';
import 'package:platinum/features/person/domain/entities/player/player.dart';

abstract class PlayerRemoteSource {
  Future<List<Training>> getAllTrainings();
  Future<TrainingProgram> getCurrentProgram();
  Future<List<PlayerPayment>> getAllPlayerPayments();
  Future<List<Sport>> getAllSports();
  Future<List<Offer>> getAllOffers();
  Future<Unit> sendPlayerInfo(Player player);
}

class PlayerRemoteSourceImpl extends PlayerRemoteSource {


  @override
  Future<TrainingProgram> getCurrentProgram() {
    // TODO: implement getCurrentProgram
    throw UnimplementedError();
  }

  @override
  Future<List<Offer>> getAllOffers() async {
    // TODO: implement getAllOffers
    // throw ServerException();
    return [];
  }

  @override
  Future<List<PlayerPayment>> getAllPlayerPayments() async {
    // TODO: implement getAllPlayerPayments
    // throw ServerException();
    return [];
  }

  @override
  Future<List<Training>> getAllTrainings() async {
    // TODO: implement getAllPrograms
    // throw ServerException();
    return [];
  }

  @override
  Future<List<Sport>> getAllSports() async {
    // TODO: implement getAllSports
    throw ServerException();
  }

  @override
  Future<Unit> sendPlayerInfo(Player player) async {
    // TODO: implement sendPlayerInfo
    throw ServerException();
  }
}
