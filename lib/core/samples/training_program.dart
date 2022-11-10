import 'package:equatable/equatable.dart';

class TrainingProgram extends Equatable {
  final int? id;
  final int apiKey, sport_id;
  final String programName;
  final List<Training> listOfTrains;
  // final List<int> trainsApiIds;

  const TrainingProgram({
    required this.id,
    required this.programName,
    required this.apiKey,
    required this.sport_id,
    required this.listOfTrains,
    // required this.trainsApiIds,
  });

  factory TrainingProgram.fromJson(Map<String, dynamic> json) {
    // List<Training> templistOfTrains = [];
    // for (Map<String, dynamic> i in json['listOfTrains']) {
    //   templistOfTrains.add(Training.fromJson(i));
    // }
    return TrainingProgram(
      id: json['serial'] ?? null,
      programName: json['program'],
      apiKey: json['id'],
      sport_id: json['sport_id'],
      listOfTrains: json['listOfTrains'],
      // trainsApiIds: json['trainsApiIds'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'serial': id ?? null,
      'id': apiKey,
      'program': programName,
      'sport_id': sport_id,
    };
  }

  @override
  List<Object?> get props => [apiKey];
}

class Training extends Equatable {
  final String name, catagory;
  final int count, rounds, programId;

  const Training({
    required this.catagory,
    required this.rounds,
    required this.count,
    required this.name,
    required this.programId,
  });

  factory Training.fromJson(Map<String, dynamic> json) {
    return Training(
      programId: json['program_id'],
      count: json['count'],
      rounds: json['rounds'],
      name: json['training'],
      catagory: json['category'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'program_id': programId,
      'training': name,
      'count': count,
      'rounds': rounds,
      'category': catagory,
    };
  }

  @override
  List<Object?> get props => [name, count, rounds, programId];
}
