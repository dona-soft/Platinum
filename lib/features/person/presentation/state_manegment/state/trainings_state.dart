import 'package:equatable/equatable.dart';
import 'package:platinum/features/person/domain/entities/trainer/trainer.dart';

abstract class TrainersState extends Equatable {
  const TrainersState();

  @override
  List<Object> get props => [];
}

class TrainersInitial extends TrainersState {}

class LoadingTrainersState extends TrainersState {}

class LoadedTrainersState extends TrainersState {
  final List<Trainer> trainers;

  const LoadedTrainersState(this.trainers);

  @override
  List<Object> get props => [trainers];
}

class ErrorTrainersState extends TrainersState {
  final String messege;

  const ErrorTrainersState(this.messege);

  @override
  List<Object> get props => [messege];
}
