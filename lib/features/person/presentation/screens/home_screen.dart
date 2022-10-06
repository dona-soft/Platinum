import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:platinum/core/connection/network_info.dart';
import 'package:platinum/core/constants/strings.dart';
import 'package:platinum/core/errors/failures.dart';
import 'package:platinum/core/samples/offer.dart';
import 'package:platinum/core/services/notifications.dart';
import 'package:platinum/core/themes/main_theme.dart';
import 'package:platinum/features/person/domain/entities/trainer/trainer.dart';
import 'package:platinum/features/person/domain/usecases/get_all_trainers.dart';
import 'package:platinum/features/person/domain/usecases/get_availabe_offers.dart';
import 'package:platinum/features/person/presentation/widgets/home_screen/bottom_list_item.dart';
import 'package:platinum/features/person/presentation/widgets/home_screen/med_list_item.dart';
import 'package:platinum/features/person/presentation/widgets/home_screen/week_days_row.dart';
import 'package:http/http.dart' as http;
import 'package:platinum/features/person/presentation/widgets/loading_error.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    Key? key,
    required this.offersUsecase,
    required this.trainersUsecase,
    required this.networkInfo,
  }) : super(key: key);

  final GetAvailableOffersUsecase offersUsecase;
  final GetAllTrainersUsecase trainersUsecase;
  final NetworkInfo networkInfo;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 

  late List<Offer>? listOfOffers;
  String? offersErrorMessege;

  bool isLoading = true;

  List<Trainer> listOfTrainers = [];

  Future<List<Offer>?> loadOffers() async {
    print('started loadOffers Method!!!');
    final eitherOffersOrFailure = await widget.offersUsecase();

    final res = eitherOffersOrFailure.fold(
      (fail) {
        //fail
        listOfOffers = null;
        _mapFailureToMessege(fail);
        throw Exception();
      },
      (list) {
        //success
        listOfOffers = list;
        return 'offersErrorMessege';
      },
    );

    return listOfOffers;
  }

  Future<void> loadTrainers() async {
    final eitherTrainersOrFailure = await widget.trainersUsecase();
    eitherTrainersOrFailure.fold((l) {
      //fail
      return null;
    }, (r) {
      //success
      listOfTrainers = r;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  LightTheme.primaryColorLight,
                  Colors.orange.shade700,
                ],
                begin: Alignment.centerRight,
                end: Alignment.topLeft,
              ),
            ),
          ),
          SafeArea(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Flex(
                direction: Axis.vertical,
                children: [
                  Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 15, left: 20),
                              alignment: Alignment.lerp(
                                  Alignment.topLeft, Alignment.topCenter, 0.2),
                              child: const Text(
                                'Platinum',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 21,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(8.0),
                              child: Material(
                                color: Colors.transparent,
                                child: IconButton(
                                  color: Colors.white,
                                  splashRadius: 25,
                                  onPressed: () async {
                                    await callApi();
                                  },
                                  icon: Icon(
                                    Icons.notifications_rounded,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  r'$20000',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Month\'s payment',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MedListItem(
                          scrWidth: MediaQuery.of(context).size.width,
                          onPressed: () =>
                              navigateTo(context, '/home/training'),
                          icon: const Icon(
                            Icons.fitness_center_rounded,
                            color: Colors.red,
                            size: 30,
                          ),
                          label: const Text(
                            'Training',
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        MedListItem(
                          scrWidth: MediaQuery.of(context).size.width,
                          onPressed: () => navigateTo(context, '/home/payment'),
                          icon: const Icon(
                            Icons.payments_outlined,
                            color: Colors.green,
                            size: 30,
                          ),
                          label: const Text(
                            'Payments',
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        MedListItem(
                            onPressed: () =>
                                navigateTo(context, '/home/calender'),
                            icon: const Icon(
                              Icons.calendar_month_rounded,
                              color: Colors.amber,
                            ),
                            label: const Text('calender'),
                            scrWidth: MediaQuery.of(context).size.width),
                        MedListItem(
                          scrWidth: MediaQuery.of(context).size.width,
                          onPressed: () => navigateTo(context, '/home/profile'),
                          icon: const Icon(
                            Icons.person_pin_circle_rounded,
                            color: Colors.blue,
                            size: 30,
                          ),
                          label: const Text(
                            'Profile',
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 14,
                    child: Container(
                      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 2,
                            child: WeekTrainingDays(
                              today: DateTime.now().weekday,
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: RefreshIndicator(
                              onRefresh: () async {
                                if (await widget.networkInfo.isConnected) {
                                  await Future.delayed(Duration(seconds: 3));
                                  setState(() {});
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                      'No Internet Connection!!',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    backgroundColor: Colors.red,
                                  ));
                                }
                              },
                              child: FutureBuilder(
                                future: loadOffers(),
                                builder: (context, asyncss) {
                                  if (asyncss.hasData)
                                    return Container(
                                      child: ListView.builder(
                                        physics: ClampingScrollPhysics(),
                                        itemCount: 10,
                                        itemBuilder: (context, index) {
                                          if (index == 0) {
                                            return Container(
                                              alignment: Alignment.centerLeft,
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 3),
                                              child: Text(
                                                offersBanner,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        Colors.grey.shade600),
                                              ),
                                            );
                                          }
                                          return BottomListItem(
                                              icon: const Icon(
                                                Icons.local_offer,
                                                color: Colors.blue,
                                              ),
                                              title: '50% Discount',
                                              subTitle:
                                                  'for every two siblings',
                                              onPressed: () {});
                                        },
                                      ),
                                    );
                                  else if (asyncss.hasError)
                                    return LoadingErrorWidget(
                                      message: offersErrorMessege ?? 'Error',
                                      reload: () {
                                        setState(() {});
                                      },
                                    );
                                  else
                                    return CircularProgressIndicator();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void navigateTo(BuildContext context, String destination) {
    Navigator.pushNamed(context, destination);
  }

  void _mapFailureToMessege(Failure fail) {
    switch (fail.runtimeType) {
      case ServerFailure:
        offersErrorMessege = 'Server Failure!';
        return;
      case OfflineFailure:
        offersErrorMessege = 'Offline Failure!';
        return;
      case EmptyCacheFailure:
        offersErrorMessege = 'Empty Cache Failure!';
        return;
      default:
    }
  }

  Future<void> callApi() async {
    try {
      final response = await http.post(
        Uri.parse(HTTP_PLAYER_LOGIN),
        body: jsonEncode({
          'phone': '0934321512',
          'password': '123456789',
        }),
        headers: {
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/json',
        },
      );
      print(response.body);
      final token = jsonDecode(response.body)['data']['token'];
      print(token);

      final response2 = await http.get(
        Uri.parse(HTTP_PLAYER_URL),
        headers: {
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json',
          'Authorization': 'Bearer $token',
        },
      );
      print(response2.body);
    } catch (e) {
      print('DEBUG: $e');
    }
  }
}
