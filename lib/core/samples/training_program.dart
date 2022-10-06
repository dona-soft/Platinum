import 'package:equatable/equatable.dart';

class TrainingProgram extends Equatable {
  final int? id;
  final String trainingCatagory;
  final List<Training> listOfTrains;
  final List<int> trainsApiIds;

  const TrainingProgram({
    required this.id,
    required this.trainingCatagory,
    required this.listOfTrains,
    required this.trainsApiIds,
  });

  factory TrainingProgram.fromJson(Map<String, dynamic> json) {
    List<Training> templistOfTrains = [];
    for (Map<String, dynamic> i in json['listOfTrains']) {
      templistOfTrains.add(Training.fromJson(i));
    }
    return TrainingProgram(
      id: json['id'] ?? null,
      listOfTrains: templistOfTrains,
      trainingCatagory: json['trainingCatagory'],
      trainsApiIds: json['trainsApiIds'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> tempListOfTrains = {};
    for (Training i in listOfTrains) {
      tempListOfTrains.addAll(i.toMap());
    }
    return {
      'id': id ?? null,
      'trainingCatagory': trainingCatagory,
      'trainsApiIds': trainsApiIds,
    };
  }

  @override
  List<Object?> get props => [id, trainingCatagory, trainsApiIds];
}

class Training extends Equatable {
  final String name, muscle, catagory;
  final int counter, rounds, apiKey;
  final bool isTimer;

  const Training({
    required this.catagory,
    required this.counter,
    required this.rounds,
    required this.muscle,
    required this.name,
    required this.isTimer,
    required this.apiKey,
  });

  factory Training.fromJson(Map<String, dynamic> json) {
    return Training(
      counter: json['counter'],
      rounds: json['rounds'],
      muscle: json['muscle'],
      name: json['name'],
      isTimer: json['isTimer'],
      catagory: json['catagory'],
      apiKey: json['apiKey'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'muscle': muscle,
      'counter': counter,
      'rounds': rounds,
      'isTimer': isTimer,
      'catagory': catagory,
      'apiKey': apiKey,
    };
  }

  @override
  List<Object?> get props => [name, muscle, counter, rounds];
}
