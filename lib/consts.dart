// ignore_for_file: prefer_const_constructors

import 'package:easy_manager/main.dart';
import 'package:easy_manager/models/product.dart';
import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const String appName = 'HB Estilo Manager';

const String kpathSvgCheck = 'lib/assets/svg/check-mark.svg';
const String kpathSvgPlus = 'lib/assets/svg/plus.svg';
const String kpathSvgMinus = 'lib/assets/svg/minus.svg';
const String kpathSvgArrowBack = 'lib/assets/svg/arrow_back.svg';
const String kpathSvgArrowForward = 'lib/assets/svg/arrow-forward.svg';
const String kpathSvgRefresh = 'lib/assets/svg/refresh.svg';
const String kpathSvgPerson = 'lib/assets/svg/person.svg';
const String kpathSvgProduct = 'lib/assets/svg/product.svg';
const String kpathSvgFactory = 'lib/assets/svg/factory.svg';
const String kpathSvgPdv = 'lib/assets/svg/pdv.svg';
const String kpathSvgChart = 'lib/assets/svg/bar-chart-and-polyline.svg';
const String kpathSvgMoney = 'lib/assets/svg/money.svg';
const String kpathSvgShuffle = 'lib/assets/svg/shuffle.svg';
const String kpathSvgSettings = 'lib/assets/svg/settings.svg';
const String kpathSvgBudgets = 'lib/assets/svg/budget.svg';
const String kpathSvgSave = 'lib/assets/svg/save.svg';
const String kpathSvgShare = 'lib/assets/svg/share.svg';

const String kpathLottieCheck = 'lib/assets/animations/home_page_check.json';
const List<String> kpathLottieIntro = [
  'lib/assets/animations/69164-marketing-campaign-creative-3d-animation.json',
  'lib/assets/animations/69854-successful-launch.json'
];
const String kpathMainLogo = 'lib/assets/img/logo-HBEstilo-sem-fundo.png';

enum UserType { administrator, employee }

enum BudgetStatus { pending, approved, canceled, finished }

showGeneralInformationDialogErrorMessage(String message, BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'))
          ],
          content: Text(message),
        );
      });
}

showGeneralLoading(BuildContext context) {
  final spinkit = SpinKitFadingCube(
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            color:
                index.isEven ? productBackgroundColor : budgetBackgroundColor),
      );
    },
  );
  showDialog(
      context: context,
      builder: (context) => Container(
          width: 50, height: 50, color: Colors.white70, child: spinkit));
}

Future<bool?> showGeneralConfirmationExitDialog(BuildContext context) async =>
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('O cadastro não foi salvo. Deseja realmente sair?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text('NÃO')),
          TextButton(
              onPressed: () {
                Navigator.pop(context, true);
                Navigator.pop(context, true);
              },
              child: Text('SIM'))
        ],
      ),
    );
