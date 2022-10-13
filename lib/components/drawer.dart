// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:easy_manager/main.dart';
import 'package:easy_manager/screens/configurations_screen.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: UserAccountsDrawerHeader(
                arrowColor: Colors.green,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [Colors.yellow, Colors.lightBlue])),
                accountName: Text(loggedUser.nome!),
                accountEmail: Text(loggedUser.email!)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Configurations(),
                        ));
                  },
                  leading: Icon(Icons.settings),
                  title: Text('Configurações'),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  leading: Icon(Icons.logout),
                  title: Text('Deslogar'),
                ),
                Divider(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
