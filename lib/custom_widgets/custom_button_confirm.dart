import 'package:flutter/material.dart';

class CursomButtonConfirm extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const CursomButtonConfirm({Key? key, required this.text, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)),
            padding: const EdgeInsets.all(16),
            primary: Colors.black),
        onPressed: onTap,
        child: Text(
          text,
          maxLines: 1,
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}
