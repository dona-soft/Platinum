import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  const SettingsItem(
      {Key? key,
      required this.icon,
      required this.label,
      required this.onPressed})
      : super(key: key);
  final Widget icon, label;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      height: MediaQuery.of(context).size.height * 0.11,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Material(
        borderRadius: BorderRadius.circular(15),
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: onPressed,
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              Expanded(
                flex: 1,
                child: icon,
              ),
              Expanded(
                flex: 3,
                child: label,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.all(15),
                  alignment: AlignmentDirectional.centerEnd,
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.grey,
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
