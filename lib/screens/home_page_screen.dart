// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print

import 'package:easy_manager/screens/clients_screen.dart';
import 'package:easy_manager/screens/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Teste',
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: Center(
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                children: [
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ClientsScreen(),
                        )),
                    child: Card(
                        child: GridTile(
                            header: Container(
                              color: Colors.amber,
                              child: Text('Clientes',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 20)),
                            ),
                            child: Icon(
                              FontAwesomeIcons.bilibili,
                            ))),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductsScreen(),
                        )),
                    child: Card(
                        child: GridTile(
                            header: Container(
                              color: Colors.amber,
                              child: Text('Produtos',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 20)),
                            ),
                            child: Icon(FontAwesomeIcons.boxOpen))),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
