import 'package:flutter/material.dart';
import 'package:platinum/core/connection/network_info.dart';
import 'package:platinum/core/constants/strings.dart';
import 'package:platinum/core/samples/sport.dart';
import 'package:platinum/core/samples/training_program.dart';
import 'package:platinum/core/themes/main_theme.dart';
import 'package:platinum/features/person/domain/usecases/get_all_programs.dart';
import 'package:platinum/features/person/domain/usecases/get_all_sports.dart';
import 'package:platinum/features/person/presentation/widgets/loading_error.dart';
import 'package:platinum/features/person/presentation/widgets/no_data_banner.dart';
import 'package:platinum/features/person/presentation/widgets/training_screen/counter_dialog.dart';
import 'package:platinum/features/person/presentation/widgets/training_screen/training_card.dart';
import 'package:platinum/features/person/presentation/widgets/training_screen/toggle_list_item.dart';

class TrainingScreen extends StatefulWidget {
  const TrainingScreen({
    Key? key,
    required this.programsUsecase,
    required this.sportsUsecase,
    required this.networkInfo,
  }) : super(key: key);

  // final List<int> trainingProgram;

  final GetAllProgramsUsecase programsUsecase;
  final GetAllSportsUsecase sportsUsecase;
  final NetworkInfo networkInfo;

  @override
  State<TrainingScreen> createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  String? sportsErrMessage, triningErrMessage;
  List<Sport> listOfSport = [];
  List<TrainingProgram>? trainingProgram;

  Future<List<Sport>> loadSports() async {
    final either = await widget.sportsUsecase();
    either.fold((fail) {
      // failure
      sportsErrMessage = mapFailureToMessege(fail);
      throw Exception();
    }, (list) {
      // success
      listOfSport = list;
    });
    return listOfSport;
  }

  Future<TrainingProgram> loadTrainings() async {
    final either = await widget.programsUsecase();
    either.fold(
      (l) {
        //  Failure
        triningErrMessage = mapFailureToMessege(l);
        throw Exception();
      },
      (r) {
        //  Success
        trainingProgram = r;
      },
    );
    return trainingProgram!.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        foregroundColor: Colors.white,
        backgroundColor: LightTheme.primaryColorLight,
        title: Text(
          'Daily Training',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
        ),
      ),
      body: SafeArea(
        child: Container(
          color: LightTheme.primaryColorLight,
          child: Column(
            children: [
              Container(
                height: 70,
                child: FutureBuilder<List<Sport>>(
                    future: loadSports(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ToggleList(
                          children: [
                            for (var i in snapshot.data as List<Sport>) i.name,
                          ],
                          onPressed: () {},
                          activeColor: Colors.blueGrey,
                          inactiveColor: Colors.grey.shade300,
                          isHorizontal: true,
                        );
                      } else if (snapshot.hasError) {
                        return Text('حدث خطأفي تحميل الرياضات');
                      } else {
                        return Container();
                      }
                    }),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: RefreshIndicator(
                    onRefresh: () async => setState(() {}),
                    child: FutureBuilder<TrainingProgram>(
                      future: loadTrainings(),
                      builder: (context, asyncss) {
                        if (asyncss.hasData) {
                          return ListView.separated(
                            itemCount: asyncss.data!.listOfTrains.length,
                            physics: BouncingScrollPhysics(),
                            padding: const EdgeInsets.symmetric(
                                vertical: 25, horizontal: 25),
                            itemBuilder: (context, index) {
                              return GridViewCard(
                                color: Colors.grey.shade700,
                                borderRadius: 5,
                                splashColor: Colors.grey.shade300,
                                label: const Text(
                                  'Training',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                onPressed: () {
                                  // showDialog(
                                  //     context: context,
                                  //     builder: (context) {
                                  //       return CounterDialog();
                                  //     });
                                },
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 15,
                              );
                            },
                          );
                        } else if (asyncss.hasError)
                          return LoadingErrorWidget(
                            message: sportsErrMessage ?? 'Error',
                            reload: () => setState(() {}),
                          );
                        else
                          return Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
