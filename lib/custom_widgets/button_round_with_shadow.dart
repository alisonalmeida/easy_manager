import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class ButtonRoundWithShadow extends StatelessWidget {
  final Color borderColor;
  final Color shadowColor;
  final Color color;
  final String iconPath;
  final VoidCallback callback;
  final double size;

  const ButtonRoundWithShadow(
      {Key? key,
      required this.borderColor,
      required this.shadowColor,
      required this.color,
      required this.iconPath,
      required this.size,
      required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        height: size,
        width: size,
        padding: const EdgeInsets.all(8),
        decoration: ShapeDecoration(
            shadows: [
              BoxShadow(
                color: shadowColor,
                offset: const Offset(
                  0.0, // Move to right 0  horizontally
                  4.0, // Move to bottom 4 Vertically
                ),
              )
            ],
            color: color,
            shape:
                CircleBorder(side: BorderSide(color: borderColor, width: 2))),
        child: SvgPicture.asset(
          iconPath,
        ),
      ),
    );
  }
}
