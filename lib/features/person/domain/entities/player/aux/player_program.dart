import 'package:equatable/equatable.dart';
import 'package:platinum/core/samples/training_program.dart';

class PlayerProgram extends Equatable {
  final int? id;
  final String name;
  final TrainingProgram trainingProgram;
  const PlayerProgram({
    required this.id,
    required this.name,
    required this.trainingProgram,
  });

  factory PlayerProgram.fromJson(Map<String, dynamic> json) {
    var temp = TrainingProgram.fromJson(json['trainingProgram']);

    return PlayerProgram(
      id: json['id'],
      name: json['name'],
      trainingProgram: temp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id ?? null,
      'name': name,
      'trainingProgram': trainingProgram.toMap(),
    };
  }

  @override
  List<Object?> get props => [id, name];
}
