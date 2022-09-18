import 'package:platinum/core/connection/network_info.dart';
import 'package:platinum/core/errors/exceptions.dart';
import 'package:platinum/features/person/data/models/trainer_model.dart';
import 'package:platinum/features/person/data/sources/trainer_local_source.dart';
import 'package:platinum/features/person/data/sources/trainer_remote_source.dart';
import 'package:platinum/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:platinum/features/person/domain/repository/repository.dart';

class TrainerRepositoryImpl implements TrainerRepository {
  final TrainerRemoteSource remoteSource;
  final TrainerLocalSource localSource;
  final NetworkInfo networkInfo;

  TrainerRepositoryImpl({
    required this.localSource,
    required this.remoteSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<TrainerModel>>> getAllTrainers() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteRes = await remoteSource.getAllTrainers();
        await localSource.saveTrainers(remoteRes);
        return Right(remoteRes);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localRes = await localSource.getAllTrainers();
        return Right(localRes);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }
}
