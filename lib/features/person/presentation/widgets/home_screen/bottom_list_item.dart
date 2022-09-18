import 'package:flutter/material.dart';

class BottomListItem extends StatelessWidget {
  const BottomListItem({
    Key? key,
    required this.icon,
    required this.title,
    this.subTitle,
    required this.onPressed,
  }) : super(key: key);
  final Widget icon;
  final String title;
  final String? subTitle;

  final VoidCallback onPressed;
  final radius = 10.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width * 0.7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: Colors.white,
      ),
      height: 70,
      child: Material(
        borderRadius: BorderRadius.circular(radius),
        child: InkWell(
          borderRadius: BorderRadius.circular(radius),
          onTap: onPressed,
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  height: double.infinity,
                  width: 70,
                  child: Center(
                    child: icon,
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (subTitle != null)
                          Text(
                            subTitle as String,
                            style: const TextStyle(
                              color: Colors.blueGrey,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
