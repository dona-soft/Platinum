import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:platinum/core/constants/strings.dart';
import 'package:platinum/core/errors/exceptions.dart';
import 'package:platinum/features/person/data/models/trainer_model.dart';

abstract class TrainerRemoteSource {
  Future<List<TrainerModel>> getAllTrainers();
}

class TrainerRemoteSourceImpl extends TrainerRemoteSource {
  @override
  Future<List<TrainerModel>> getAllTrainers() async {
    List<TrainerModel> list = [];
    final response = await http.get(
      Uri.parse(HTTP_TRAINERS),
      headers: {
        'Accept': 'application/vnd.api+json',
      },
    );
    if (response.statusCode == 200) {
      print(response.body);
      List<dynamic> temp = jsonDecode(response.body)['data'];
      temp.forEach((map) {
        final temp = Map<String, dynamic>.from(map);
        list.add(TrainerModel.fromJson(temp));
      });
      return list;
    } else {
      throw ServerException();
    }
  }
}
