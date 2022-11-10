import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:platinum/core/constants/strings.dart';

class NoDataBanner extends StatelessWidget {
  const NoDataBanner({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
          ),
        ),
        Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                DONT_KNOW,
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
              SizedBox(height: 40),
              Text(title),
            ],
          ),
        ),
      ],
    );
  }
}
