import 'package:dartz/dartz.dart';
import 'package:platinum/core/errors/failures.dart';
import 'package:platinum/core/samples/training_program.dart';
import 'package:platinum/features/person/domain/repository/repository.dart';

class GetAllTrainingsUsecase {
  final PlayerRepository repository;
  GetAllTrainingsUsecase(this.repository);
  Future<Either<Failure, List<Training>>> call() async {
    return await repository.getAllTrainings();
  }
}
