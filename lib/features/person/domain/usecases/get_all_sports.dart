import 'package:dartz/dartz.dart';
import 'package:platinum/core/errors/failures.dart';
import 'package:platinum/core/samples/sport.dart';
import 'package:platinum/features/person/domain/repository/repository.dart';

class GetAllSportsUsecase {
  final PlayerRepository repository;
  GetAllSportsUsecase(this.repository);

  Future<Either<Failure, List<Sport>>> call() async {
    return await repository.getAllSports();
  }
}
