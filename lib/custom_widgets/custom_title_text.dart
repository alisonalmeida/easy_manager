import 'package:flutter/material.dart';

class CustomTitleText extends StatelessWidget {
  const CustomTitleText({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: TextAlign.center,
      title,
      style: const TextStyle(
          fontSize: 25,
          fontFamily: 'JosefinsSans',
          fontWeight: FontWeight.w700),
    );
  }
}
