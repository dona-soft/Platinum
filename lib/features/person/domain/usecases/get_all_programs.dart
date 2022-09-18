import 'package:dartz/dartz.dart';
import 'package:platinum/core/errors/failures.dart';
import 'package:platinum/core/samples/training_program.dart';
import 'package:platinum/features/person/domain/repository/repository.dart';

class GetAllProgramsUsecase {
  final PlayerRepository repository;
  const GetAllProgramsUsecase(this.repository);

  Future<Either<Failure, List<TrainingProgram>>> call() async {
    return await repository.getAllPrograms();
  }
}
