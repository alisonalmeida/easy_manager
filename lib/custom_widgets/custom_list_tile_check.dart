import 'package:easy_manager/consts.dart';
import 'package:easy_manager/custom_widgets/button_round_with_shadow.dart';
import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomListTileCheck extends StatelessWidget {
  const CustomListTileCheck(
      {Key? key,
      required this.title,
      required this.icon,
      required this.subtitle})
      : super(key: key);

  final String title;
  final IconData icon;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(shadows: const [
        BoxShadow(
          color: Colors.black,
          offset: Offset(
            3.0,
            4.0,
          ),
        )
      ], color: Colors.white, shape: Border.all()),
      child: ListTile(
        trailing: ButtonRoundWithShadow(
            borderColor: black,
            shadowColor: black,
            color: white,
            iconPath: kpathSvgCheck,
            size: 50,
            callback: () {}),
        leading: Icon(icon, color: Colors.black),
        title: Text(title,
            style: const TextStyle(
                fontFamily: 'JosefinsSans', fontWeight: FontWeight.w700)),
        subtitle: Text(subtitle),
      ),
    );
  }
}
