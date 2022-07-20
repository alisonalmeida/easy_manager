import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomButtonConfirm extends StatelessWidget {
  final String text;
  final VoidCallback onTapValid;
  final VoidCallback onTapInValid;
  final bool isEnabled;

  const CustomButtonConfirm(
      {Key? key,
      required this.text,
      required this.onTapValid,
      required this.onTapInValid,
      required this.isEnabled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          side: BorderSide(width: isEnabled ? 2 : 0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          padding: const EdgeInsets.all(16),
          primary: isEnabled ? woodSmoke : Colors.grey),
      onPressed: isEnabled ? onTapValid : onTapInValid,
      child: Text(
        text,
        maxLines: 1,
        style: isEnabled
            ? const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 20,
                shadows: [
                    Shadow(
                        blurRadius: 5,
                        color: Colors.black,
                        offset: Offset(1, 2))
                  ])
            : const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 20,
                shadows: [
                    Shadow(
                        blurRadius: 5, color: Colors.grey, offset: Offset(1, 2))
                  ]),
      ),
    );
  }
}
