// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print

import 'package:easy_manager/custom_widgets/central_grid_Button.dart';
import 'package:easy_manager/custom_widgets/custom_app_bar.dart';
import 'package:easy_manager/screens/clients_screen.dart';
import 'package:easy_manager/screens/products_screen.dart';
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
      appBar: CustomAppBar(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                textAlign: TextAlign.center,
                'Easy Manager',
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'JosefinsSans',
                    fontWeight: FontWeight.w700),
              )
            ],
          )),
      body: Center(
        child: GridView(
          padding: const EdgeInsets.all(8.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
          children: [
            CentralGridButton(
              title: 'Clientes',
              backgroundColor: dandelion,
              borderColor: lighteningYellow,
              shadowColor: lighteningYellow,
              color: white,
              iconPath: 'lib/assets/svg/person.svg',
              callback: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ClientsScreen(),
                  )),
            ),
            CentralGridButton(
              title: 'Produtos',
              backgroundColor: pastelPink,
              borderColor: pinkSalomn,
              shadowColor: pinkSalomn,
              color: white,
              iconPath: 'lib/assets/svg/product.svg',
              callback: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductsScreen(),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
