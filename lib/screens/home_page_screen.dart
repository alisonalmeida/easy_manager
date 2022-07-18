// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print

import 'dart:io';

import 'package:easy_manager/consts.dart';
import 'package:easy_manager/custom_widgets/central_grid_Button.dart';
import 'package:easy_manager/models/company_model.dart';

import 'package:easy_manager/screens/customer_screen.dart';
import 'package:easy_manager/screens/product_screen.dart';
import 'package:easy_manager/screens/provider_screen.dart';
import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: selago,
      /*appBar: CustomAppBar(
          height: 100,
          childAppbar: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    height: 50,
                    width: 50,
                    child: SvgPicture.asset('lib/assets/svg/check-mark.svg')),
                Text(
                  textAlign: TextAlign.center,
                  'Easy Manager App',
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'JosefinsSans',
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
          )),

          */
      body: Container(
        color: selago,
        padding: EdgeInsets.all(5),
        child: GridView(
          padding: const EdgeInsets.all(8.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
          children: [
            CentralGridButton(
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
                title: 'PDV',
                backgroundColor: purple,
                borderColor: purpleShadow,
                shadowColor: purpleShadow,
                color: white,
                iconPath: kpathSvgPdv,
                callback: () {}),
            CentralGridButton(
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
