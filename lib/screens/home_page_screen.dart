// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print

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
                    crossAxisCount: 4),
                children: [
                  GestureDetector(
                    onTap: () {
                      print('tap');
                    },
                    child: Card(
                        child: GridTile(
                            header: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 20,
                              color: Colors.amber,
                            ),
                            footer: Text(
                              'Clientes',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 40),
                            ),
                            child: Icon(
                              FontAwesomeIcons.bilibili,
                            ))),
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
