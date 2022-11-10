import 'package:dartz/dartz.dart';
import 'package:platinum/core/errors/failures.dart';
import 'package:platinum/core/samples/offer.dart';
import 'package:platinum/core/samples/payment.dart';
import 'package:platinum/core/samples/player_status.dart';
import 'package:platinum/core/samples/player_training.dart';
import 'package:platinum/core/samples/sport.dart';
import 'package:platinum/core/samples/training_program.dart';
import 'package:platinum/features/person/data/models/player_model.dart';
import 'package:platinum/features/person/data/models/trainer_model.dart';

abstract class PlayerRepository {
  Future<Either<Failure, List<Training>>> getAllTrainings();
  Future<Either<Failure, List<TrainingProgram>>> getCurrentProgram();
  Future<Either<Failure, List<Sport>>> getAllSports();
  Future<Either<Failure, List<Payment>>> getAllPayments();
  Future<Either<Failure, PlayerModel>> getPlayerInfo();
  Future<Either<Failure, List<Offer>>> getAvailableOffers();
  Future<Either<Failure, List<PlayerStatus>>> getPlayerMetrics();
  Future<Either<Failure, List<PlayerTraining>>> getPlayerSubs();
}

abstract class TrainerRepository {
  Future<Either<Failure, List<TrainerModel>>> getAllTrainers();
}
