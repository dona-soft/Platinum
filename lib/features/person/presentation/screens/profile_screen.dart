import 'package:flutter/material.dart';
import 'package:platinum/core/themes/main_theme.dart';
import 'package:platinum/features/person/presentation/widgets/profile_screen/info_alert_window.dart';
import 'package:platinum/features/person/presentation/widgets/profile_screen/settings_item.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  void showAlertWindow() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Profile'),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Player Name',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: LightTheme.primaryColorLight),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Ph: 0987654321'),
                  ),
                  Text('Age: 25'),
                ],
              ),
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
                      showDialog(
                        context: context,
                        builder: (context) {
                          return MyDialog();
                        },
                      );
                    },
                    icon: Icon(
                      Icons.settings,
                    ),
                    label: Text(
                      'Change Info',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blueGrey),
                    ),
                  ),
                  SettingsItem(
                    onPressed: () {},
                    icon: Icon(Icons.alarm_add_rounded),
                    label: Text(
                      'Add reminder',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blueGrey),
                    ),
                  ),
                  SettingsItem(
                    onPressed: () {},
                    icon: Icon(Icons.shield_outlined),
                    label: Text('About'),
                  ),
                  SettingsItem(
                    icon: Icon(Icons.system_update_outlined),
                    label: Text('Check Update'),
                    onPressed: () {},
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
