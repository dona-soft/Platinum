import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:platinum/core/constants/strings.dart';
import 'package:platinum/core/errors/exceptions.dart';
import 'package:platinum/core/samples/player_status.dart';
import 'package:platinum/core/themes/main_theme.dart';
import 'package:platinum/features/person/domain/usecases/get_player_metrics.dart';
import 'package:platinum/features/person/presentation/widgets/loading_error.dart';
import 'package:platinum/features/person/presentation/widgets/status_screen/body_part.dart';
import 'package:intl/intl.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({
    Key? key,
    required this.statusUsecase,
  }) : super(key: key);

  final GetPlayerStatusUsecase statusUsecase;

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  final controller = PageController();

  List<PlayerStatus> playerStatus = [];
  late PlayerStatus currentStats;

  final duration = const Duration(milliseconds: 500);

  String dateFormatter(DateTime dateTime) {
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    return dateFormat.format(dateTime);
  }

  Future<List<PlayerStatus>> loadStatus() async {
    print(body_parts.length);
    final either = await widget.statusUsecase();
    either.fold(
      (fail) {
        throw GlobalException(message: mapFailureToMessege(fail));
      },
      (list) {
        playerStatus = list;
      },
    );
    currentStats = playerStatus.first;
    print('currentStatus date = ${currentStats.CheckDate}');
    return playerStatus;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Player Stats'),
        backgroundColor: LightTheme.primaryColorLight,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<PlayerStatus>>(
          future: loadStatus(),
          builder: (context, snapshot) {
            if (snapshot.hasData)
              return Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () async {
                            await controller.previousPage(
                                duration: duration, curve: Curves.linear);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          dateFormatter(currentStats.CheckDate),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            await controller.nextPage(
                                duration: duration, curve: Curves.linear);
                          },
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('kg الوزن: ${currentStats.Weight}'),
                          SizedBox(width: 15),
                          Text('cm الطول: ${currentStats.Height}'),
                        ],
                      )),
                  Expanded(
                    flex: 15,
                    child: PageView(
                      controller: controller,
                      onPageChanged: (index) {
                        currentStats = playerStatus[index];
                      },
                      dragStartBehavior: DragStartBehavior.down,
                      children: [
                        for (var i in playerStatus)
                          ListView(
                            padding: EdgeInsets.all(8),
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BodyPart(
                                      image: Image.asset(
                                        body_parts[0],
                                        width: 150,
                                      ),
                                      title: 'الرقبة',
                                      status: '${i.Neck} cm'),
                                  BodyPart(
                                      image: Image.asset(
                                        body_parts[0],
                                        width: 150,
                                      ),
                                      title: 'أكتاف',
                                      status: '${i.Shoulders} cm'),
                                  BodyPart(
                                      image: Image.asset(
                                        body_parts[1],
                                        width: 150,
                                      ),
                                      title: 'صدر',
                                      status: '${i.Chest} cm'),
                                  BodyPart(
                                    image: Image.asset(
                                      body_parts[2],
                                      width: 150,
                                    ),
                                    title: 'الذراعين',
                                    status:
                                        'cm عضد ايسر ${i.L_Arm}\n'
                                        'cm عضد ايمن ${i.R_Arm}\n'
                                        'cm ساعد ايسر ${i.L_Humerus}\n'
                                        'cm ساعد ايمن ${i.R_Humerus}',
                                  ),
                                  BodyPart(
                                      image: Image.asset(
                                        body_parts[3],
                                        width: 150,
                                      ),
                                      title: 'الخصر',
                                      status: '${i.Waist} cm'),
                                  BodyPart(
                                      image: Image.asset(
                                        body_parts[4],
                                        width: 150,
                                      ),
                                      title: 'المعدة',
                                      status: '${i.Hips} cm'),
                                  BodyPart(
                                    image: Image.asset(
                                      body_parts[5],
                                      width: 150,
                                    ),
                                    title: 'الفخذين',
                                    status:
                                        'cm فخذ ايسر ${i.L_Thigh}\n'
                                        'cm فخذ ايمن ${i.R_Thigh}',
                                  ),
                                  BodyPart(
                                    image: Image.asset(
                                      body_parts[6],
                                      width: 150,
                                    ),
                                    title: 'الساقين',
                                    status:
                                        'cm ساق يسرى: ${i.L_Leg}\n'
                                        'cm ساق يمنى: ${i.R_Leg}'
                                        '',
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
              );
            else if (snapshot.hasError) {
              return LoadingErrorWidget(
                  message: (snapshot.error as GlobalException).message,
                  reload: () => setState(() {}));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
