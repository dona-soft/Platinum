import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:platinum/core/connection/network_info.dart';
import 'package:platinum/core/constants/strings.dart';
import 'package:platinum/core/samples/offer.dart';
import 'package:platinum/core/themes/main_theme.dart';
import 'package:platinum/features/person/domain/entities/player/player.dart';
import 'package:platinum/features/person/domain/usecases/get_availabe_offers.dart';
import 'package:platinum/features/person/domain/usecases/get_player_info.dart';
import 'package:platinum/features/person/presentation/widgets/home_screen/bottom_list_item.dart';
import 'package:platinum/features/person/presentation/widgets/home_screen/med_list_item.dart';
import 'package:platinum/features/person/presentation/widgets/home_screen/player_balance.dart';
import 'package:platinum/features/person/presentation/widgets/home_screen/week_days_row.dart';
import 'package:platinum/features/person/presentation/widgets/loading_error.dart';
import 'package:platinum/features/person/presentation/widgets/no_data_banner.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    Key? key,
    required this.offersUsecase,
    required this.networkInfo,
    required this.playerInfoUsecase,
  }) : super(key: key);

  final GetAvailableOffersUsecase offersUsecase;
  final GetPlayerInfoUsecase playerInfoUsecase;
  final NetworkInfo networkInfo;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Offer> listOfOffers = [];
  String? offersErrorMessege;

  bool isLoading = true;

  late Player player;

  Future<List<Offer>> loadOffers() async {
    print('started loadOffers Method!!!');
    final eitherOffersOrFailure = await widget.offersUsecase();

    eitherOffersOrFailure.fold(
      (fail) {
        //fail
        offersErrorMessege = mapFailureToMessege(fail);
        throw Exception();
      },
      (list) {
        //success
        listOfOffers = list;
      },
    );

    return listOfOffers;
  }

  Future<Player> loadPlayerInfo() async {
    final eitherTrainersOrFailure = await widget.playerInfoUsecase();

    eitherTrainersOrFailure.fold((l) {
      //fail
      mapFailureToMessege(l);
      throw Exception();
    }, (r) {
      //success
      player = r;
    });
    return player;
  }

  @override
  void initState() {
    super.initState();
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
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text(
                                              'تسجيل الخروج؟',
                                              textDirection: TextDirection.rtl,
                                            ),
                                            content: Text(
                                              'هل انت متأكد من عملية تسجيل الخروج, قد تتعرض بياناتك للتلف او الضياع هل تريد الاستمرار؟',
                                              textDirection: TextDirection.rtl,
                                            ),
                                            actions: [
                                              OutlinedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text('تراجع'),
                                              ),
                                              ElevatedButton(
                                                onPressed: () async {
                                                  await FirebaseAuth.instance
                                                      .signOut();

                                                  Navigator
                                                      .pushReplacementNamed(
                                                          context, '/login');
                                                },
                                                child: Text('نعم'),
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  icon: Icon(
                                    Icons.logout,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Row(
                              children: [
                                FutureBuilder<Player>(
                                    future: loadPlayerInfo(),
                                    builder: (context, snapShot) {
                                      if (snapShot.hasData)
                                        return BalanceWidget(
                                          balance:
                                              snapShot.data!.balance.toString(),
                                          subtitle: 'الرصيد الحالي',
                                        );
                                      else if (snapShot.hasError) {
                                        return BalanceWidget(
                                            balance: '0 ل.س',
                                            subtitle:
                                                "تأكد من الاتصال بالانترنت");
                                      } else {
                                        return BalanceWidget(
                                            balance: '0 ل.س',
                                            subtitle: 'الرصيد الحالي');
                                      }
                                    }),
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
                          onPressed: () => navigateTo(context, '/home/sport'),
                          icon: const Icon(
                            Icons.content_paste_go_rounded,
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
                                  setState(() {});
                                  await Future.delayed(Duration(seconds: 3));
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                      '!لا يوجد اتصال بالانترنت',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    backgroundColor: Colors.red,
                                  ));
                                }
                              },
                              child: FutureBuilder<List<Offer>>(
                                future: loadOffers(),
                                builder: (context, asyncss) {
                                  if (asyncss.hasData) {
                                    if (asyncss.data!.isEmpty) {
                                      return NoDataBanner(
                                          title: '...لا يوجد عروض حاليا');
                                    }
                                    return ListView.builder(
                                      physics: ClampingScrollPhysics(),
                                      itemCount: asyncss.data!.length - 1,
                                      itemBuilder: (context, index) {
                                        if (index == 0) {
                                          return Container(
                                            alignment: Alignment.centerRight,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 3),
                                            child: Text(
                                              ':العروض المتوفرة',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey.shade600),
                                            ),
                                          );
                                        }

                                        return BottomListItem(
                                            icon: const Icon(
                                              Icons.local_offer,
                                              color: Colors.blue,
                                            ),
                                            offer: asyncss.data![index - 1],
                                            onPressed: () {});
                                      },
                                    );
                                  } else if (asyncss.hasError) {
                                    return LoadingErrorWidget(
                                      message: offersErrorMessege == null
                                          ? '!حدث خطأ'
                                          : offersErrorMessege as String,
                                      reload: () {
                                        setState(() {});
                                      },
                                    );
                                  } else
                                    return Center(
                                        child: CircularProgressIndicator());
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
}
