// ignore_for_file: prefer_const_constructors

import 'package:easy_manager/consts.dart';
import 'package:easy_manager/custom_widgets/custom_app_bar.dart';
import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';

class PdvScreen extends StatefulWidget {
  const PdvScreen({super.key});
  static String name = 'PDV';

  @override
  State<PdvScreen> createState() => _PdvScreenState();
}

class _PdvScreenState extends State<PdvScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
            title: PdvScreen.name,
            backgroundColor: pdvBackgroundColor,
            callback: () async {
              Navigator.pop(context);
            },
            svgImage: kpathSvgPdv,
            heroAnimation: PdvScreen.name),
        backgroundColor: pdvBackgroundColor,
        body: Container(),
      ),
    );
  }
}
