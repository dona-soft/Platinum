import 'package:flutter/material.dart';

typedef Func = void Function();

class MedListItem extends StatelessWidget {
  final Func onPressed;
  late final double radius;
  final double scrWidth;
  final Widget icon, label;

  MedListItem({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.label,
    required this.scrWidth,
  }) {
    radius = scrWidth * 0.03;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: scrWidth * 0.15,
      height: scrWidth * 0.15,
      child: Material(
        elevation: 3,
        borderRadius: BorderRadius.circular(radius),
        color: Colors.white,
        child: InkWell(
          borderRadius: BorderRadius.circular(radius),
          onTap: onPressed,
          child:
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              Container(
            alignment: Alignment.center,
            child: icon,
          ),
          // Container(
          //   child: label,
          //   margin: EdgeInsets.all(5),
          // ),
          // ],
          // ),
        ),
      ),
    );
  }
}
