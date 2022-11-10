import 'package:dartz/dartz.dart';
import 'package:platinum/core/errors/failures.dart';
import 'package:platinum/features/person/data/models/player_model.dart';
import 'package:platinum/features/person/domain/repository/repository.dart';

class GetPlayerInfoUsecase {
  final PlayerRepository repository;
  const GetPlayerInfoUsecase(this.repository);

  Future<Either<Failure, PlayerModel>> call() async {
    return await repository.getPlayerInfo();
  }
}
