import 'package:flutter/material.dart';

class DualLogo extends StatelessWidget {
  const DualLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.20,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.lerp(
                          Alignment.topLeft, Alignment.bottomRight, 0.30)
                      as AlignmentGeometry,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: Image.asset('icons/Logo_light.png'),
                  ),
                ),
                Align(
                  alignment: Alignment.lerp(
                          Alignment.topLeft, Alignment.bottomRight, 0.70)
                      as AlignmentGeometry,
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        child: Container(
                          child: Image.asset('icons/DonaSoft.png'),
                          margin: EdgeInsets.all(5),
                        ),
                      )),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(),
          ),
        ],
      ),
    );
  }
}
