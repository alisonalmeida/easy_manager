// ignore_for_file: prefer_const_constructors

import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';

class PdvScreen extends StatefulWidget {
  const PdvScreen({super.key});

  @override
  State<PdvScreen> createState() => _PdvScreenState();
}

class _PdvScreenState extends State<PdvScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: pdvBackgroundColor,
        body: Container(),
      ),
    );
  }
}
