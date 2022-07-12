import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile(
      {Key? key,
      required this.callback,
      required this.text,
      required this.icon})
      : super(key: key);

  final VoidCallback callback;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(shadows: const [
        BoxShadow(
          color: Colors.black,
          offset: Offset(
            0.0, // Move to right 10  horizontally
            4.0, // Move to bottom 5 Vertically
          ),
        )
      ], color: Colors.white, shape: Border.all()
          // CircleBorder(side: BorderSide(color: borderColor, width: 2)),
          ),
      child: ListTile(
        onTap: callback,
        leading: Icon(icon, color: Colors.black),
        title: Text(text,
            style: const TextStyle(
                fontFamily: 'JosefinsSans', fontWeight: FontWeight.w700)),
      ),
    );
  }
}
