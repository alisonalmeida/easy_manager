// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {Key? key,
      required this.controller,
      required this.name,
      required this.textInputAction,
      this.callback,
      this.textInputFormatterList,
      this.textInputType,
      this.prefixIcon,
      this.minLines,
      this.maxLines,
      this.focusNode,
      this.maxLength})
      : super(key: key);

  final List<TextInputFormatter>? textInputFormatterList;
  final TextInputType? textInputType;
  final TextEditingController controller;
  final String name;
  final TextInputAction textInputAction;
  final VoidCallback? callback;
  final Widget? prefixIcon;
  final int? minLines;
  final int? maxLines;
  final FocusNode? focusNode;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      focusNode: focusNode,
      keyboardType: textInputType,
      inputFormatters: textInputFormatterList,
      textInputAction: textInputAction,
      onEditingComplete: callback,
      controller: controller,
      minLines: minLines,
      maxLines: maxLines,
      decoration: InputDecoration(
          counterText: '',
          prefixIcon: prefixIcon,
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
