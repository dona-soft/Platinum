import 'package:flutter/material.dart';
import 'package:platinum/core/themes/main_theme.dart';
import 'package:platinum/features/person/presentation/widgets/training_screen/counter_dialog.dart';
import 'package:platinum/features/person/presentation/widgets/training_screen/training_card.dart';
import 'package:platinum/features/person/presentation/widgets/training_screen/toggle_list_item.dart';

class TrainingScreen extends StatelessWidget {
  const TrainingScreen({Key? key, required this.trainingProgram})
      : super(key: key);

  final List<int> trainingProgram;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        foregroundColor: Colors.white,
        backgroundColor: LightTheme.primaryColorLight,
        title: Text(
          'Daily Training',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
        ),
      ),
      backgroundColor: LightTheme.primaryColorLight,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 70,
              child: ToggleList(
                children: [for (int i = 0; i < 10; i++) 'sport $i'],
                onPressed: () {},
                activeColor: Colors.blueGrey,
                inactiveColor: Colors.grey.shade300,
                isHorizontal: true,
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  padding:
                      const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
                  itemBuilder: (context, index) {
                    return GridViewCard(
                      color: Colors.grey.shade700,
                      borderRadius: 5,
                      splashColor: Colors.grey.shade300,
                      label: const Text(
                        'Training',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return CounterDialog();
                            });
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 15,
                    );
                  },
                  itemCount: trainingProgram.length + 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
