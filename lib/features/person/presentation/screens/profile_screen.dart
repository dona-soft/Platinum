import 'package:flutter/material.dart';
import 'package:platinum/core/constants/strings.dart';
import 'package:platinum/core/themes/main_theme.dart';
import 'package:platinum/features/person/data/models/player_model.dart';
import 'package:platinum/features/person/domain/entities/player/player.dart';
import 'package:platinum/features/person/domain/usecases/get_player_info.dart';
import 'package:platinum/features/person/presentation/widgets/profile_screen/settings_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upgrader/upgrader.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    Key? key,
    required this.playerInfoUsecase,
    required this.sharedPreferences,
  }) : super(key: key);

  final GetPlayerInfoUsecase playerInfoUsecase;
  final SharedPreferences sharedPreferences;

  Future<Player> loadCurrentPlayer() async {
    Player? player;
    String? phone = await sharedPreferences.getString('phone');
    if (phone != null) {
      phone = phone.substring(4);
      phone = '0' + phone;
      print(phone);
    }
    final either = await playerInfoUsecase();
    either.fold(
      (l) {
        throw Exception();
      },
      (r) {
        var a = r.toMap();
        a.remove('Phone');
        a.addAll({'Phone': phone});
        player = PlayerModel.fromJson(a);
      },
    );
    return player as Player;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('الحساب الشخصي'),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: FutureBuilder<Player>(
                  future: loadCurrentPlayer(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData)
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            snapshot.data!.fullName,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: LightTheme.primaryColorLight),
                          ),
                          Text(
                            'الهاتف:' + ' ${snapshot.data!.phoneNum}',
                            textDirection: TextDirection.rtl,
                          ),
                        ],
                      );
                    else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 15),
                physics: BouncingScrollPhysics(),
                children: [
                  SettingsItem(
                    onPressed: () {
                      Navigator.pushNamed(context, '/home/profile/payment');
                    },
                    icon: Icon(
                      Icons.payments_rounded,
                      color: Colors.green,
                    ),
                    label: Text(
                      'المدفوعات',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                  SettingsItem(
                    onPressed: () {
                      Navigator.pushNamed(context, '/home/profile/subs');
                    },
                    icon: Icon(
                      Icons.subject_sharp,
                      color: Colors.red,
                    ),
                    label: Text(
                      'الاشتراكات السابقة',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blueGrey),
                    ),
                  ),
                  // SettingsItem(
                  //   onPressed: () {
                      
                  //   },
                  //   icon: Icon(
                  //     Icons.system_update,
                  //     color: Colors.orange,
                  //   ),
                  //   label: Text(
                  //     'التحقق من التحديثات',
                  //     textDirection: TextDirection.rtl,
                  //     style: TextStyle(
                  //       fontWeight: FontWeight.bold,
                  //       color: Colors.blueGrey,
                  //     ),
                  //   ),
                  // ),
                  SettingsItem(
                    icon: Icon(
                      Icons.shield_moon_sharp,
                      color: Colors.blueGrey,
                    ),
                    label: Text(
                      'حول',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, R_ABOUT);
                    },
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
