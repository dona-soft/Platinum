import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:platinum/core/themes/main_theme.dart';

class AnimatedCircle extends StatelessWidget {
  AnimatedCircle({
    Key? key,
    required this.radius,
    this.top,
    this.right,
    this.bottom,
    this.left,
  }) : super(key: key);

  final double radius;
  double? top, bottom, left, right;
  

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      curve: Curves.easeInOutCubic,
      duration: const Duration(seconds: 2),
      top: top,
      right: right,
      bottom: bottom,
      left: left,
      child: Container(
        height: radius,
        width: radius,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: LightTheme.primaryColorLight,
        ),
      ),
    );
  }
}
