import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({Key? key, required this.controller, required this.name})
      : super(key: key);

  final TextEditingController controller;
  final String name;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          fillColor: white,
          filled: true,
          focusColor: white,
          hoverColor: white,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: black),
              borderRadius: BorderRadius.all(Radius.circular(16))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: black),
              borderRadius: BorderRadius.all(Radius.circular(5))),
          labelText: name,
          labelStyle: TextStyle(color: black),
          hintText: name),
    );
  }
}
