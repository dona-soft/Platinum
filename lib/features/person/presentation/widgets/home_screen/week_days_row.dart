import 'package:flutter/material.dart';
import 'package:platinum/core/constants/strings.dart';
import 'package:platinum/core/themes/main_theme.dart';

class WeekTrainingDays extends StatelessWidget {
  const WeekTrainingDays({Key? key, required this.today}) : super(key: key);

  final List<String> weekdays = week;
  final int today;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(150),
            blurRadius: 1,
            spreadRadius: 0.5,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(
            flex: 1,
            child: Text(
              trainingBanner,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.blueGrey),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (int i = 0; i < 7; i++)
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: i == shiftDays()
                          ? LightTheme.primaryColorLight
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 0.5,
                            spreadRadius: 0.1,
                            color: Colors.grey,
                            offset: Offset(0, 1)),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        week[i],
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: i == shiftDays()
                                ? Colors.white
                                : Colors.grey.shade600),
                      ),
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }

  int shiftDays() {
    return (today + 1) % 7;
  }
}
//  day of week(Str):         mo  tu  we  th  fr  sa  su
//  day of week(Int):         01  02  03  04  05  06  07
//  day + 1:                  02  03  04  05  06  07  08
//  day we want(Str): sa  su  mo  tu  we  th  fr  sa  su
//  day we want(Int): 00  01  02  03  04  05  06  00  01
//  1 <= day(Int)     <= 7
//  0 <= day(Int) - 1 <= 6
//  2 <= day(Int) + 1 <= 9