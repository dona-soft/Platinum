import 'package:dartz/dartz.dart';
import 'package:platinum/core/samples/offer.dart';
import 'package:platinum/core/samples/sport.dart';
import 'package:platinum/core/samples/training_program.dart';
import 'package:platinum/features/person/domain/entities/player/aux/player_payment.dart';
import 'package:platinum/features/person/domain/entities/player/player.dart';

abstract class PlayerRemoteSource {
  Future<List<TrainingProgram>> getAllPrograms();
  Future<List<PlayerPayment>> getAllPlayerPayments();
  Future<List<Sport>> getAllSports();
  Future<List<Offer>> getAllOffers();
  Future<Unit> sendPlayerInfo(Player player);
}

class PlayerRemoteSourceImpl extends PlayerRemoteSource {
  @override
  Future<List<Offer>> getAllOffers() {
    // TODO: implement getAllOffers
    throw UnimplementedError();
  }

  @override
  Future<List<PlayerPayment>> getAllPlayerPayments() {
    // TODO: implement getAllPlayerPayments
    throw UnimplementedError();
  }

  @override
  Future<List<TrainingProgram>> getAllPrograms() {
    // TODO: implement getAllPrograms
    throw UnimplementedError();
  }

  @override
  Future<List<Sport>> getAllSports() {
    // TODO: implement getAllSports
    throw UnimplementedError();
  }

  @override
  Future<Unit> sendPlayerInfo(Player player) {
    // TODO: implement sendPlayerInfo
    throw UnimplementedError();
  }
}
