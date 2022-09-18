import 'package:dartz/dartz.dart';
import 'package:platinum/core/constants/strings.dart';
import 'package:platinum/core/errors/exceptions.dart';
import 'package:platinum/features/person/data/models/trainer_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class TrainerLocalSource {
  Future<List<TrainerModel>> getAllTrainers();
  Future<Unit> saveTrainers(List<TrainerModel> trainers);
}

class TrainerLocalSourceImpl extends TrainerLocalSource {
  TrainerLocalSourceImpl({required this.database});

  final Database database;

  @override
  Future<List<TrainerModel>> getAllTrainers() async {
    List<TrainerModel> localTrainers = [];
    List<Map<String, dynamic>> temp = await database.query(TRAINERS_TABLE);
    if (temp.isNotEmpty) {
      for (var i in temp) {
        localTrainers.add(
          TrainerModel(
            id: i['id'],
            fullName: i['fullName'],
            phoneNum: i['phoneNum'],
            genderMale: i['genderMale'],
          ),
        );
      }
      return localTrainers;
    } else
      throw EmptyCacheException();
  }

  @override
  Future<Unit> saveTrainers(List<TrainerModel> trainers) async {
    if (database.isOpen) {
      for (var i in trainers) {
        await database.insert(TRAINERS_TABLE, i.toMap(i));
      }
      return unit;
    } else
      throw DataBaseException();
  }
}
