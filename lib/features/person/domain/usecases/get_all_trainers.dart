import 'package:dartz/dartz.dart';
import 'package:platinum/core/errors/failures.dart';
import 'package:platinum/features/person/data/models/trainer_model.dart';
import 'package:platinum/features/person/domain/repository/repository.dart';

class GetAllTrainersUsecase {
  final TrainerRepository repository;
  const GetAllTrainersUsecase(this.repository);

  Future<Either<Failure, List<TrainerModel>>> call() async {
    return await repository.getAllTrainers();
  }
}
