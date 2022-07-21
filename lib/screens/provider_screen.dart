// ignore_for_file: prefer_const_constructors

import 'package:easy_manager/consts.dart';
import 'package:easy_manager/custom_widgets/button_round_with_shadow.dart';
import 'package:easy_manager/custom_widgets/custom_app_bar.dart';
import 'package:easy_manager/custom_widgets/empty_widget.dart';
import 'package:easy_manager/models/product_provider_model.dart';
import 'package:easy_manager/screens/crud_provider_screen.dart';
import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';

class ProvidersScreen extends StatefulWidget {
  const ProvidersScreen({Key? key}) : super(key: key);

  @override
  State<ProvidersScreen> createState() => _ProvidersScreenState();
}

class _ProvidersScreenState extends State<ProvidersScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: carribeanGreen,
        appBar: CustomAppBar(
            title: 'Fornecedores',
            backgroundColor: carribeanGreen,
            callback: () async => Navigator.pop(context),
            svgImage: kpathSvgFactory,
            heroAnimation: 'Fornecedores'),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: EmptyWidget()),
        persistentFooterButtons: [
          ElevatedButton(onPressed: () {}, child: Text('Teste'))
        ],
        floatingActionButton: ButtonRoundWithShadow(
            size: 60,
            borderColor: woodSmoke,
            color: white,
            callback: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => CrudProviderScreen())),
            shadowColor: woodSmoke,
            iconPath: kpathSvgPlus));
  }
}
