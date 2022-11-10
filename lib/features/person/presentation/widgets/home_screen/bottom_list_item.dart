import 'package:flutter/material.dart';
import 'package:platinum/core/samples/offer.dart';
import 'package:intl/intl.dart';

class BottomListItem extends StatelessWidget {
  const BottomListItem({
    Key? key,
    required this.icon,
    required this.offer,
    required this.onPressed,
  }) : super(key: key);
  final Widget icon;
  final Offer offer;

  final VoidCallback onPressed;
  final radius = 10.0;

  String dateFormatter(DateTime dateTime) {
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    return dateFormat.format(dateTime);
  }

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
                          offer.fullPay == 0
                              ? '%${offer.percent} حسم'
                              : '${offer.name}',
                          style: const TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          dateFormatter(offer.endDate) + ' :تاريخ الانتهاء',
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
