import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomButtonConfirm extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const CustomButtonConfirm({Key? key, required this.text, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            side: const BorderSide(width: 2),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)),
            padding: const EdgeInsets.all(16),
            primary: woodSmoke),
        onPressed: onTap,
        child: Text(
          text,
          maxLines: 1,
          style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 20,
              shadows: [
                Shadow(blurRadius: 5, color: Colors.black, offset: Offset(1, 2))
              ]),
        ),
      ),
    );
  }
}
