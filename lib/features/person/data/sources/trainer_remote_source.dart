import 'package:platinum/features/person/data/models/trainer_model.dart';

abstract class TrainerRemoteSource {
  Future<List<TrainerModel>> getAllTrainers();
}

class TrainerRemoteSourceImpl extends TrainerRemoteSource {
  @override
  Future<List<TrainerModel>> getAllTrainers() {
    // TODO: implement getAllTrainers
    throw UnimplementedError();
  }
}
