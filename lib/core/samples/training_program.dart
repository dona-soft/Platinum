import 'package:equatable/equatable.dart';

class TrainingProgram extends Equatable {
  final int? id;
  final String trainingCatagory;
  final List<Training> listOfTrains;

  const TrainingProgram({
    required this.id,
    required this.listOfTrains,
    required this.trainingCatagory,
  });

  factory TrainingProgram.fromMap(Map<String, dynamic> json) {
    return TrainingProgram(
        id: json['id'] ?? null,
        listOfTrains: json['listOfTrains'],
        trainingCatagory: json['trainingCatagory']);
  }

  Map<String, dynamic> toMap(TrainingProgram tp) {
    return {
      if(tp.id != null) 'id':tp.id,
      'trainingCatagory': tp.trainingCatagory,
      'listOfTrains': tp.listOfTrains,
    };
  }

  @override
  List<Object?> get props => [id, trainingCatagory];
}

class Training extends Equatable {
  final String name, muscle;
  final int counter, rounds;

  const Training({
    required this.counter,
    required this.rounds,
    required this.muscle,
    required this.name,
  });
  

  @override
  List<Object?> get props => [name, muscle, counter, rounds];
}
