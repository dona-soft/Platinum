import 'package:equatable/equatable.dart';
import 'package:platinum/core/samples/training_program.dart';

class PlayerProgram extends Equatable {
  final int? id;
  final String name;
  final TrainingProgram? trainingProgram;
  const PlayerProgram({
    required this.id,
    required this.name,
    this.trainingProgram,
  });

  @override
  List<Object?> get props => [id, name];
}
