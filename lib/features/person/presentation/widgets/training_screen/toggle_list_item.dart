import 'package:flutter/material.dart';

typedef OnPressed = void Function();

class ToggleList extends StatefulWidget {
  const ToggleList({
    Key? key,
    required this.children,
    required this.onPressed,
    this.isHorizontal = false,
    required this.activeColor,
    required this.inactiveColor,
  }) : super(key: key);

  final List<String> children;
  final OnPressed onPressed;
  final bool isHorizontal;
  final Color activeColor, inactiveColor;

  @override
  State<ToggleList> createState() => _ToggleListState();
}

class _ToggleListState extends State<ToggleList> {
  int activeItem = 0;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      itemCount: widget.children.length,
      itemBuilder: (context, index) {
        return Material(
          elevation: 2,
          color:
              activeItem == index ? widget.activeColor : widget.inactiveColor,
          borderRadius: BorderRadius.circular(25),
          child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            onTap: () {
              setState(() {
                activeItem = index;
              });

              widget.onPressed;
            },
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
              child: Text(
                widget.children[index],
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: activeItem == index
                        ? Colors.white
                        : Colors.grey.shade700),
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          width: MediaQuery.of(context).size.width * 0.06,
        );
      },
      scrollDirection: widget.isHorizontal ? Axis.horizontal : Axis.vertical,
    );
  }
}
