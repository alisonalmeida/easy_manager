import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CentralGridButton extends StatelessWidget {
  final Color borderColor;
  final Color shadowColor;
  final Color color;
  final String iconPath;
  final Color backgroundColor;
  final VoidCallback callback;
  final String title;

  const CentralGridButton(
      {Key? key,
      required this.borderColor,
      required this.shadowColor,
      required this.color,
      required this.iconPath,
      required this.backgroundColor,
      required this.callback,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        margin: EdgeInsets.all(2),
        decoration: ShapeDecoration(shadows: [
          BoxShadow(
            color: shadowColor,
            offset: const Offset(
              1.0, // Move horizontally
              2.0, // Move Vertically
            ),
          )
        ], color: color, shape: Border.all(color: borderColor)
            // CircleBorder(side: BorderSide(color: borderColor, width: 2)),
            ),
        child: Container(
          color: backgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title,
                  style: TextStyle(
                      fontFamily: 'JosefinsSans', fontWeight: FontWeight.w700)),
              SizedBox(
                height: 50,
                width: 50,
                child: SvgPicture.asset(
                  iconPath,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
