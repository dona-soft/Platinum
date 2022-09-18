import 'package:dartz/dartz.dart';
import 'package:platinum/core/errors/failures.dart';
import 'package:platinum/features/person/domain/entities/trainer/trainer.dart';
import 'package:platinum/features/person/domain/repository/repository.dart';

class GetAllTrainersUsecase {
  final TrainerRepository repository;
  const GetAllTrainersUsecase(this.repository);

  Future<Either<Failure, List<Trainer>>> call() async {
    return await repository.getAllTrainers();
  }
}
