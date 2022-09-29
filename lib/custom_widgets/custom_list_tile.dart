// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile(
      {Key? key,
      
      required this.title,
      required this.icon,
      required this.subtitle,
      required this.listOptions})
      : super(key: key);

  
  final String title;
  final IconData icon;
  final String subtitle;
  final Widget listOptions;

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
        trailing: listOptions,
        leading: Icon(icon, color: Colors.black),
        title: Text(title,
            style: const TextStyle(
                fontFamily: 'JosefinsSans', fontWeight: FontWeight.w700)),
        subtitle: Text(subtitle),
      ),
    );
  }
}
