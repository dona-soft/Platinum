import 'package:flutter/material.dart';
import 'package:platinum/core/samples/sport.dart';
import 'package:platinum/features/person/data/models/trainer_model.dart';

///
///
///
///
///
///
///
/// this is the trainers listview item
///   \----/
///    \--/
///     \/
///
///
///
///

class TrainerListItem extends StatelessWidget {
  const TrainerListItem({
    Key? key,
    required this.trainer,
  }) : super(key: key);

  final TrainerModel trainer;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      margin: EdgeInsets.only(top: 15, bottom: 15, left: 13),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Container(
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  child: trainer.genderMale
                      ? Image.asset('icons/man.png')
                      : Image.asset('icons/woman.png'),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      trainer.fullName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.blueGrey),
                    ),
                    Center(
                      child: Text(
                        trainer.phoneNum,
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
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

///
///
///
///
///
///
///
///
/// this is the Sport listview item
///   \----/
///    \--/
///     \/
///
///
///
///
///
///

class SportListItem extends StatelessWidget {
  const SportListItem({
    Key? key,
    required this.sport,
  }) : super(key: key);

  final Sport sport;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
        color: Color(0xFFEEEEEE),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(5),
          bottom: Radius.circular(5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 3),
            blurRadius: 3,
            spreadRadius: 0.001,
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            flex: 11,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(5),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
                child: Image.asset('icons/manwomen.png'),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                sport.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Text('سعر التسجيل'),
                      Text('SYP ${sport.price}'),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Text('المدربون'),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
