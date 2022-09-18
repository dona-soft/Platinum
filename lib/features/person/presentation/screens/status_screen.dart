import 'package:flutter/material.dart';
import 'package:platinum/core/constants/strings.dart';
import 'package:platinum/core/themes/main_theme.dart';
import 'package:platinum/features/person/presentation/widgets/status_screen/nutrition_system_list.dart';

class CalenderScreen extends StatelessWidget {
  const CalenderScreen({Key? key}) : super(key: key);

  ///
  ///TODO: define getter for training history and lay them in bottom ListView...
  ///

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Player Stats'),
        backgroundColor: LightTheme.primaryColorLight,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: EdgeInsets.all(15),
        children: [
          Center(
            child: Image.asset('icons/group_60.png'),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 1; i < 6; i++)
                  ListTile(
                    leading: Text(
                      '$i',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    title: Text(
                      bodyParts[i],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
                  ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          NutritionList(),
        ],
      ),
    );
  }
}
