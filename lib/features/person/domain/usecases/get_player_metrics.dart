import 'package:dartz/dartz.dart';
import 'package:platinum/core/errors/failures.dart';
import 'package:platinum/core/samples/player_status.dart';
import 'package:platinum/features/person/domain/repository/repository.dart';

class GetPlayerStatusUsecase {
  final PlayerRepository repository;

  const GetPlayerStatusUsecase(this.repository);
  Future<Either<Failure, List<PlayerStatus>>> call() async {
    return await repository.getPlayerMetrics();
  }
}
