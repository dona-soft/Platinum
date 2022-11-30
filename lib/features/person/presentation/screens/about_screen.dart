import 'package:flutter/material.dart';
import 'package:platinum/core/constants/strings.dart';
import 'package:platinum/core/themes/main_theme.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('حول'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('icons/Logo_light.png'),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            'Platinum Gym App',
                            style: TextStyle(
                              color: LightTheme.primaryColorLight,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            'CREATED BY DONASOFT',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              child: Material(
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            'More about DONASOFT >>',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: Image.asset('icons/DonaSoft.png'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 1,
            color: Colors.grey,
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Text(
                ABOUT_MAIN,
                textDirection: TextDirection.rtl,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: Text(
                ABOUT_COMPANY,
                textDirection: TextDirection.rtl,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
