import 'package:platinum/core/connection/network_info.dart';
import 'package:platinum/core/errors/exceptions.dart';
import 'package:platinum/features/person/data/models/player_model.dart';
import 'package:platinum/features/person/data/sources/player_local_source.dart';
import 'package:platinum/features/person/data/sources/player_remote_source.dart';
import 'package:platinum/features/person/domain/entities/player/aux/player_payment.dart';
import 'package:platinum/features/person/domain/entities/player/player.dart';
import 'package:platinum/core/samples/training_program.dart';
import 'package:platinum/core/samples/sport.dart';
import 'package:platinum/core/samples/offer.dart';
import 'package:platinum/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:platinum/features/person/domain/repository/repository.dart';

typedef ResultFunc = Future<List<Object>> Function();
typedef CacheFunc = Future<Unit> Function(List<Object> list);

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
  Future<Either<Failure, List<TrainingProgram>>> getAllPrograms() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteResult = await remoteSource.getAllPrograms();
        localSource.savePrograms(remoteResult);
        return Right(remoteResult);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localResult = await localSource.getAllPrograms();
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

    // final res = resfun(
    //     () => remoteSource.getAllOffers(),
    //     (list) => localSource.saveOffers(list as List<Offer>),
    //     () => localSource.getAllOffers());
    // return res;
  }

  @override
  Future<Either<Failure, List<PlayerPayment>>> getAllPayments() async {
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
    try {
      final localRes = await localSource.getPlayerInfo();
      return Right(localRes);
    } on EmptyCacheException {
      return Left(EmptyCacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> savePlayerInfo(PlayerModel player) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteSource.sendPlayerInfo(player);
        await localSource.savePlayerInfo(player);
        return Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        await localSource.savePlayerInfo(player);
        return Right(unit);
      } on DataBaseException {
        return Left(DataBaseFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePlayer(Player player) async {
    // TODO: seems almost identical to savePlayerInfo???
    throw UnimplementedError();
  }

  ///
  ///
  /// #ATTENTION: This method needs more research to guarantee no malfunctions in
  ///   real life scenarios!!!
  ///
  
  Future<Either<Failure, List<Object>>> resfun(
    ResultFunc remoteget,
    CacheFunc localsave,
    ResultFunc localget,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteRes = await remoteget();
        await localsave(remoteRes);
        return Right(remoteRes);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localRes = await localget();
        return Right(localRes);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }
}
