import 'package:flutter/material.dart';
import 'package:platinum/core/constants/strings.dart';
import 'package:platinum/core/samples/sport.dart';
import 'package:platinum/core/themes/main_theme.dart';
import 'package:platinum/features/person/data/models/trainer_model.dart';
import 'package:platinum/features/person/domain/usecases/get_all_sports.dart';
import 'package:platinum/features/person/domain/usecases/get_all_trainers.dart';
import 'package:platinum/features/person/presentation/widgets/loading_error.dart';
import 'package:platinum/features/person/presentation/widgets/sportsTrainers_screen/list_item.dart';

class SportsAndTrainersScr extends StatefulWidget {
  const SportsAndTrainersScr({
    Key? key,
    required this.sportsUsecase,
    required this.trainersUsecase,
  }) : super(key: key);

  final GetAllSportsUsecase sportsUsecase;
  final GetAllTrainersUsecase trainersUsecase;

  @override
  State<SportsAndTrainersScr> createState() => _SportsAndTrainersScrState();
}

class _SportsAndTrainersScrState extends State<SportsAndTrainersScr> {
  List<Sport> sportsList = [];
  List<TrainerModel> trainersList = [];

  String errMessage = '';
  bool isTrainerLoaded = false, isSportsLoaded = false;

  Future<bool> loadSports() async {
    final either = await widget.sportsUsecase();
    either.fold(
      (fail) {
        errMessage = mapFailureToMessege(fail);
        return false;
      },
      (list) {
        sportsList = list;
      },
    );
    return true;
  }

  Future<bool> loadTrainers() async {
    final either = await widget.trainersUsecase();
    either.fold(
      (fail) {
        errMessage = mapFailureToMessege(fail);
        return false;
      },
      (list) {
        trainersList = list;
      },
    );
    return true;
  }

  Future<bool> loadPage() async {
    isTrainerLoaded = await loadTrainers();
    isSportsLoaded = await loadSports();
    if (isTrainerLoaded && isSportsLoaded) {
      return true;
    } else {
      throw Exception();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: LightTheme.primaryColorLight,
        foregroundColor: Colors.white,
        title: Text('الرياضات والمدربين'),
      ),
      body: FutureBuilder<bool>(
        future: loadPage(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return RefreshIndicator(
              onRefresh: () async {
                setState(() {});
                await Future.delayed(Duration(seconds: 3));
              },
              child: ListView(
                children: [
                  // Trainer List
                  SizedBox(
                    height: 150,
                    child: trainersList.isNotEmpty
                        ? ListView(
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            children: [
                              for (var i in trainersList)
                                TrainerListItem(
                                  trainer: i,
                                ),
                            ],
                          )
                        : null,
                  ),
                  // Sports List
                  for (var i in sportsList) SportListItem(sport: i),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return LoadingErrorWidget(
              message: errMessage,
              reload: () => setState(() {}),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
