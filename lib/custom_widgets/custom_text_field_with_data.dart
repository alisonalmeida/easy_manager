// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomTextFieldWithData extends StatelessWidget {
  CustomTextFieldWithData(
      {Key? key,
      required this.controller,
      required this.name,
      required this.items,
      this.callback,
      this.validator})
      : super(key: key);

  final TextEditingController controller;
  final String name;
  final Widget items;
  final String? Function(String?)? validator;
  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onSaved: (newValue) {},
      onTap: callback,
      readOnly: true,
      controller: controller,
      decoration: InputDecoration(
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: flamingo),
              borderRadius: BorderRadius.all(Radius.circular(16))),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 4, color: flamingo),
              borderRadius: BorderRadius.all(Radius.circular(5))),
          fillColor: white,
          filled: true,
          focusColor: white,
          hoverColor: white,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: black),
              borderRadius: BorderRadius.all(Radius.circular(16))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 4, color: black),
              borderRadius: BorderRadius.all(Radius.circular(5))),
          labelText: name,
          labelStyle: TextStyle(color: black),
          hintText: name),
    );
  }
}
