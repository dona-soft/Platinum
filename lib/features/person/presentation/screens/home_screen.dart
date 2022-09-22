import 'package:flutter/material.dart';
import 'package:platinum/core/constants/strings.dart';
import 'package:platinum/core/services/notifications.dart';
import 'package:platinum/core/themes/main_theme.dart';
import 'package:platinum/features/person/presentation/screens/status_screen.dart';
import 'package:platinum/features/person/presentation/screens/profile_screen.dart';
import 'package:platinum/features/person/presentation/widgets/home_screen/bottom_list_item.dart';
import 'package:platinum/features/person/presentation/widgets/home_screen/med_list_item.dart';
import 'package:platinum/features/person/presentation/widgets/home_screen/week_days_row.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final notificationService = LocalNotificationService();

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
                                  onPressed: () {
                                    notificationService.showNotification(
                                      id: 1,
                                      title: 'Hello Mathafackaaaa',
                                      body:
                                          'this message is impolite but we do not give a shit about it :)',
                                    );
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
                          onPressed: () {
                            Navigator.pushNamed(context, '/home/training');
                          },
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
                          onPressed: () {
                            Navigator.pushNamed(context, '/home/payment');
                          },
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
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => CalenderScreen()));
                            },
                            icon: const Icon(
                              Icons.calendar_month_rounded,
                              color: Colors.amber,
                            ),
                            label: const Text('calender'),
                            scrWidth: MediaQuery.of(context).size.width),
                        MedListItem(
                          scrWidth: MediaQuery.of(context).size.width,
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => ProfileScreen()),
                          ),
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
                          const Expanded(
                            flex: 2,
                            child: WeekTrainingDays(),
                          ),
                          Expanded(
                            flex: 7,
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(),
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
                                          color: Colors.grey.shade600),
                                    ),
                                  );
                                }
                                return BottomListItem(
                                    icon: const Icon(
                                      Icons.local_offer,
                                      color: Colors.blue,
                                    ),
                                    title: '50% Discount',
                                    subTitle: 'for every two siblings',
                                    onPressed: () {});
                              },
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
}
