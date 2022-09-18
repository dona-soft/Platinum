import 'package:flutter/material.dart';

typedef OnPressed = void Function();

class GridViewCard extends StatefulWidget {
  GridViewCard({
    Key? key,
    this.color,
    this.splashColor,
    this.borderRadius = 0,
    this.onPressed,
    required this.label,
    this.subLabel,
  }) : super(key: key);
  final double borderRadius;
  final Color? color, splashColor;
  final OnPressed? onPressed;
  final Widget? subLabel;
  final Widget label;

  @override
  State<GridViewCard> createState() => _GridViewCardState();
}

class _GridViewCardState extends State<GridViewCard> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Material(
        elevation: 3,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: InkWell(
          onTap: widget.onPressed,
          onLongPress: () {
            setState(() {
              isChecked = !isChecked;
            });
          },
          splashColor: widget.splashColor,
          enableFeedback: false,
          customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius)),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(widget.borderRadius),
                      topLeft: Radius.circular(widget.borderRadius),
                    ),
                    color: Colors.orange,
                  ),
                  alignment: Alignment.center,
                  child: widget.label,
                ),
              ),
              Expanded(
                flex: 8,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 15),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(widget.borderRadius)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'arms dumbell',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey,
                            ),
                          ),
                          Container(
                            width: 50,
                            height: 50,
                            child: Icon(
                              Icons.av_timer_rounded,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '3x15',
                            style: TextStyle(color: Colors.blueGrey),
                          ),
                          Checkbox(
                              shape: CircleBorder(),
                              activeColor: Colors.green,
                              splashRadius: 25,
                              value: isChecked,
                              onChanged: (newVal) {
                                setState(() {
                                  isChecked = !isChecked;
                                });
                              })
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
