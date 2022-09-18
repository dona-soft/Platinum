import 'package:flutter/material.dart';

class CounterDialog extends StatefulWidget {
  const CounterDialog({Key? key}) : super(key: key);

  @override
  State<CounterDialog> createState() => _CounterDialogState();
}

class _CounterDialogState extends State<CounterDialog>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  bool isTImerStarted = false, istrainFinished = false;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    animation = Tween<double>(begin: 0, end: 1).animate(controller)
      ..addListener(() {
        if (controller.isCompleted) {
          setState(() {
            isTImerStarted = false;
            istrainFinished = true;
          });
        }
        setState(() {});
      });
  }

  void startPauseAnimation() {
    if (controller.isCompleted) {
      istrainFinished = false;
      controller.reset();
      controller.forward();
    } else if (isTImerStarted) {
      controller.stop();
    } else {
      controller.forward();
    }
    setState(() {
      isTImerStarted = !isTImerStarted;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.all(5),
      title: Text('Arms dumbell'),
      backgroundColor: Colors.white,
      children: [
        Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.3,
              child: Image.asset('icons/training_1.jpg'),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                  'Lorem Ipsom and the big brown fox jumps over the lazy dog, such that the angular velocity is the first derivative of angle'),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 70,
                    width: 70,
                    child: CircularProgressIndicator.adaptive(
                      // valueColor: controller.drive(
                      //     ColorTween(begin: Colors.amber, end: Colors.green)),
                      backgroundColor: Colors.grey.shade300,
                      value: 1.0 - animation.value,
                      semanticsValue: 'aasd',
                      semanticsLabel: 'asd',
                      strokeWidth: 1.5,
                    ),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 1000),
                    child: Text(
                      "${((1 - controller.value) * 30).ceil()}",
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 1,
              color: Colors.grey.shade300,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {},
                  splashRadius: 20,
                  icon: Icon(
                    Icons.arrow_circle_left,
                    color: Colors.blueGrey,
                  ),
                ),
                OutlinedButton(
                  onPressed: startPauseAnimation,
                  child: Icon(
                    isTImerStarted
                        ? Icons.pause
                        : (istrainFinished
                            ? Icons.replay_sharp
                            : Icons.play_arrow),
                    color: Colors.blueGrey,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  splashRadius: 20,
                  icon: Icon(
                    Icons.arrow_circle_right,
                    color: Colors.blueGrey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
