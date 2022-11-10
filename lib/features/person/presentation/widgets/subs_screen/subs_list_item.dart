import 'package:flutter/material.dart';
import 'package:platinum/core/samples/player_training.dart';
import 'package:intl/intl.dart' as intl;

class SubsListItem extends StatelessWidget {
  const SubsListItem({
    Key? key,
    required this.playerTraining,
  }) : super(key: key);

  final PlayerTraining playerTraining;

  String formatDate(DateTime dateTime) {
    final format = intl.DateFormat('yyyy-MM-dd');
    return format.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Card(
        elevation: 3,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                textDirection: TextDirection.rtl,
                children: [
                  Text(
                    playerTraining.sport,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFC14E00),
                    ),
                  ),
                  Text(
                    'ل.س ${playerTraining.price} ',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                playerTraining.trainer + ' المدرب',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                'تاريخ التسجيل: ${formatDate(playerTraining.rollDate)}',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                'تاريخ الانتهاء: ${formatDate(playerTraining.lastCheck)}',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              if (playerTraining.offer != null)
                Text(
                  '${playerTraining.offer} العرض',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              if (playerTraining.priceAfterOffer != null)
                Text(
                  'السعر بعد العرض: ${playerTraining.priceAfterOffer}',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
