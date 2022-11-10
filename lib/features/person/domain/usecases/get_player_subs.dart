import 'package:dartz/dartz.dart';
import 'package:platinum/core/errors/failures.dart';
import 'package:platinum/core/samples/player_training.dart';
import 'package:platinum/features/person/domain/repository/repository.dart';

class GetPlayerSubsUsecase {
  final PlayerRepository repository;

  const GetPlayerSubsUsecase(this.repository);

  Future<Either<Failure, List<PlayerTraining>>> call() async {
    return await repository.getPlayerSubs();
  }
}
