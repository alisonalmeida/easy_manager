// ignore_for_file: prefer_const_constructors

import 'package:easy_manager/models/address_model.dart';
import 'package:easy_manager/models/client_model.dart';
import 'package:easy_manager/screens/home_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'consts.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(AddressAdapter());
  await Hive.openBox<Address>(kAddressBox);

  Hive.registerAdapter(ClientAdapter());
  await Hive.openBox<Client>(kClientBox);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Teste',
      home: HomePage(),
    );
  }
}
