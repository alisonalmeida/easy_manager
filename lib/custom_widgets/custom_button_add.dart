import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomAddButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const CustomAddButton({Key? key, required this.text, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          padding: const EdgeInsets.all(16),
          backgroundColor: black),
      onPressed: onTap,
      child: Text(
        text,
        maxLines: 1,
        style: const TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 20,
        ),
      ),
    );
  }
}
