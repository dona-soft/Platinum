import 'package:dartz/dartz.dart';
import 'package:platinum/core/errors/failures.dart';
import 'package:platinum/core/samples/offer.dart';
import 'package:platinum/core/samples/sport.dart';
import 'package:platinum/core/samples/training_program.dart';
import 'package:platinum/features/person/data/models/player_model.dart';
import 'package:platinum/features/person/domain/entities/player/aux/player_payment.dart';
import 'package:platinum/features/person/domain/entities/trainer/trainer.dart';

abstract class PlayerRepository {
  Future<Either<Failure, List<Training>>> getAllTrainings();
  Future<Either<Failure, TrainingProgram>> getCurrentProgram();
  Future<Either<Failure, List<Sport>>> getAllSports();
  Future<Either<Failure, List<PlayerPayment>>> getAllPayments();
  Future<Either<Failure, PlayerModel>> getPlayerInfo();
  Future<Either<Failure, List<Offer>>> getAvailableOffers();
  Future<Either<Failure, Unit>> savePlayerInfo(PlayerModel player);
  Future<Either<Failure, Unit>> updatePlayer(PlayerModel player);
}

abstract class TrainerRepository {
  Future<Either<Failure, List<Trainer>>> getAllTrainers();
}
