import 'package:flutter/material.dart';
import 'package:platinum/core/connection/network_info.dart';
import 'package:platinum/core/errors/failures.dart';
import 'package:platinum/core/samples/training_program.dart';
import 'package:platinum/core/themes/main_theme.dart';
import 'package:platinum/features/person/domain/usecases/get_all_programs.dart';
import 'package:platinum/features/person/presentation/widgets/loading_error.dart';
import 'package:platinum/features/person/presentation/widgets/training_screen/counter_dialog.dart';
import 'package:platinum/features/person/presentation/widgets/training_screen/training_card.dart';
import 'package:platinum/features/person/presentation/widgets/training_screen/toggle_list_item.dart';

class TrainingScreen extends StatefulWidget {
  const TrainingScreen({
    Key? key,
    required this.programsUsecase,
    required this.networkInfo,
  }) : super(key: key);

  // final List<int> trainingProgram;

  final GetAllProgramsUsecase programsUsecase;
  final NetworkInfo networkInfo;

  @override
  State<TrainingScreen> createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  String? message;

  TrainingProgram? list;

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
                child: ToggleList(
                  children: [for (int i = 0; i < 10; i++) 'sport $i'],
                  onPressed: () {},
                  activeColor: Colors.blueGrey,
                  inactiveColor: Colors.grey.shade300,
                  isHorizontal: true,
                ),
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
                    child: FutureBuilder(
                      future: loadTrainings(),
                      builder: (context, asyncss) {
                        if (asyncss.hasData)
                          return ListView.separated(
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
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return CounterDialog();
                                      });
                                },
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 15,
                              );
                            },
                            itemCount: 5,
                          );
                        else if (asyncss.hasError)
                          return LoadingErrorWidget(
                            message: message ?? 'Error',
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

  Future<bool> loadTrainings() async {
    final either = await widget.programsUsecase();
    either.fold(
      (l) {
        //  Failure
        _mapFailureToMessege(l);
        throw Exception();
      },
      (r) {
        //  Success
        list = r;
      },
    );
    return true;
  }

  void _mapFailureToMessege(Failure fail) {
    switch (fail.runtimeType) {
      case ServerFailure:
        message = 'Server Failure!';
        return;
      case OfflineFailure:
        message = 'Offline Failure!';
        return;
      case EmptyCacheFailure:
        message = 'Empty Cache Failure!';
        return;
      default:
    }
  }
}
