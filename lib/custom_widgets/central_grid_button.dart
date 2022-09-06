import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CentralGridButton extends StatelessWidget {
  final Color borderColor;
  final Color shadowColor;
  
  final String iconPath;
  final Color backgroundColor;
  final VoidCallback callback;
  final String title;
  final String hero;

  const CentralGridButton({
    Key? key,
    required this.borderColor,
    required this.shadowColor,
    
    required this.iconPath,
    required this.backgroundColor,
    required this.callback,
    required this.title,
    required this.hero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        margin: const EdgeInsets.all(2),
        decoration: ShapeDecoration(shadows: const [
          BoxShadow(
            
            offset: Offset(
              1.0, // Move horizontally
              2.0, // Move Vertically
            ),
          )
        ],color: shadowColor,  shape: Border.all(color: borderColor)),
        child: Container(
          color: backgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontFamily: 'JosefinsSans', fontWeight: FontWeight.w700)),
              SizedBox(
                height: 50,
                width: 50,
                child: Hero(
                  tag: hero,
                  child: SvgPicture.asset(
                    iconPath,
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
