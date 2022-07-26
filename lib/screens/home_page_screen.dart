// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print

import 'dart:io';

import 'package:easy_manager/consts.dart';
import 'package:easy_manager/custom_widgets/central_grid_button.dart';
import 'package:easy_manager/models/company_model.dart';
import 'package:easy_manager/models/customer_model.dart';
import 'package:easy_manager/models/product_model.dart';
import 'package:easy_manager/objectbox.g.dart';
import 'package:easy_manager/screens/customer_screen.dart';
import 'package:easy_manager/screens/product_screen.dart';
import 'package:easy_manager/screens/provider_screen.dart';
import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';
import '../custom_widgets/custom_home_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  Store? _store;
  Box<Customer>? customerBox;

  final syncServerIp = Platform.isAndroid ? '10.0.2.2' : '127.0.0.1';
  late final AnimationController _animationController;
  bool _checked = true;

  @override
  initState() {
    openStore().then((Store store) {
      _store = store;
      Sync.client(
        store,
        'ws://$syncServerIp:9999', // wss for SSL, ws for unencrypted traffic
        SyncCredentials.none(),
      ).start();
      customerBox = store.box<Customer>();
    });
    _animationController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {_store?.close();
    _animationController.dispose();
    super.dispose();
  }

  void changeAnimation() {
    print(_checked);
    if (_checked) {
      _animationController.forward();
      _checked = !_checked;
    } else {
      _animationController.reverse();
      _checked = !_checked;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: selago,
      appBar: CustomHomeAppBar(
          controller: _animationController,
          title: 'Easy Manager',
          callback: () => changeAnimation()),
      body: Container(
        color: selago,
        padding: EdgeInsets.all(5),
        child: GridView(
          padding: const EdgeInsets.all(8.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
          children: [
            CentralGridButton(
              hero: 'Produtos',
              title: 'Produtos',
              backgroundColor: pastelPink,
              borderColor: pinkSalomn,
              shadowColor: pinkSalomn,
              color: white,
              iconPath: kpathSvgProduct,
              callback: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductsScreen(),
                  )),
            ),
            CentralGridButton(
              hero: 'Clientes',
              title: 'Clientes',
              backgroundColor: dandelion,
              borderColor: dandelionShadow,
              shadowColor: dandelionShadow,
              color: white,
              iconPath: kpathSvgPerson,
              callback: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CustomerScreen(),
                  )),
            ),
            CentralGridButton(
              hero: 'Fornecedores',
              title: 'Fornecedores',
              backgroundColor: carribeanGreen,
              borderColor: carribeanGreenShadow,
              shadowColor: carribeanGreenShadow,
              color: white,
              iconPath: kpathSvgFactory,
              callback: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProvidersScreen(),
                  )),
            ),
            CentralGridButton(
                hero: 'PDV',
                title: 'PDV',
                backgroundColor: purple,
                borderColor: purpleShadow,
                shadowColor: purpleShadow,
                color: white,
                iconPath: kpathSvgPdv,
                callback: () {}),
            CentralGridButton(
                hero: 'Gráficos',
                //title: 'Gráficos',
                title: 'TESTE',
                backgroundColor: blueBlue,
                borderColor: blueBlueShadow,
                shadowColor: blueBlueShadow,
                color: white,
                iconPath: kpathSvgChart,
                callback: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TextPage()))),
            CentralGridButton(
                hero: 'Entrada e Saída',
                title: 'Entrada e Saída',
                backgroundColor: grey,
                borderColor: greyShadow,
                shadowColor: greyShadow,
                color: white,
                iconPath: kpathSvgMoney,
                callback: () {}),
          ],
        ),
      ),
    );
  }
}

class TextPage extends StatefulWidget {
  const TextPage({Key? key}) : super(key: key);

  @override
  State<TextPage> createState() => _TextPageState();
}

class _TextPageState extends State<TextPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('data'),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {}),
    );
  }
}
