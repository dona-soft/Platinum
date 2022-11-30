import 'package:platinum/core/connection/network_info.dart';
import 'package:platinum/core/errors/exceptions.dart';
import 'package:platinum/core/samples/payment.dart';
import 'package:platinum/core/samples/player_status.dart';
import 'package:platinum/core/samples/player_training.dart';
import 'package:platinum/features/person/data/models/player_model.dart';
import 'package:platinum/features/person/data/sources/player_local_source.dart';
import 'package:platinum/features/person/data/sources/player_remote_source.dart';
import 'package:platinum/core/samples/training_program.dart';
import 'package:platinum/core/samples/sport.dart';
import 'package:platinum/core/samples/offer.dart';
import 'package:platinum/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:platinum/features/person/domain/repository/repository.dart';

class PlayerRepositoryImpl implements PlayerRepository {
  final PlayerLocalSource localSource;
  final PlayerRemoteSource remoteSource;
  final NetworkInfo networkInfo;

  PlayerRepositoryImpl({
    required this.localSource,
    required this.remoteSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<TrainingProgram>>> getCurrentProgram() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteRes = await remoteSource.getCurrentProgram();
        await localSource.saveCurrentProgram(remoteRes);
        return Right(remoteRes);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localRes = await localSource.getCurrentProgram();
        return Right(localRes);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<Training>>> getAllTrainings() async {
    // return Left(OfflineFailure());
    if (await networkInfo.isConnected) {
      try {
        final remoteResult = await remoteSource.getAllTrainings();
        localSource.saveAllTrainings(remoteResult);
        return Right(remoteResult);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localResult = await localSource.getAllTrainings();
        return Right(localResult);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<Sport>>> getAllSports() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteRes = await remoteSource.getAllSports();
        localSource.saveSports(remoteRes);
        return Right(remoteRes);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localRes = await localSource.getAllSports();
        return Right(localRes);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<Offer>>> getAvailableOffers() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteRes = await remoteSource.getAllOffers();
        await localSource.saveOffers(remoteRes);
        return Right(remoteRes);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localRes = await localSource.getAllOffers();
        return Right(localRes);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<Payment>>> getAllPayments() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteRes = await remoteSource.getAllPlayerPayments();
        await localSource.savePlayerPayments(remoteRes);
        return Right(remoteRes);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localRes = await localSource.getAllPlayerPayments();
        return Right(localRes);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, PlayerModel>> getPlayerInfo() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteRes = await remoteSource.getPlayerInfo();
        await localSource.savePlayerInfo(remoteRes);
        return Right(remoteRes);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localRes = await localSource.getPlayerInfo();
        return Right(localRes);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<PlayerStatus>>> getPlayerMetrics() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteRes = await remoteSource.getPlayerMetrics();
        await localSource.savePlayerMetrics(remoteRes);
        return Right(remoteRes);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localRes = await localSource.getPlayerMetrics();
        return Right(localRes);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<PlayerTraining>>> getPlayerSubs() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteRes = await remoteSource.getPlayerSubs();
        await localSource.savePlayerSubs(remoteRes);
        return Right(remoteRes);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localRes = await localSource.getPlayerSubs();
        return Right(localRes);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }
}
