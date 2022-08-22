// ignore_for_file: prefer_const_constructors

import 'package:easy_manager/helper/spreadsheet_connection.dart';
import 'package:easy_manager/screens/home_page_screen.dart';
import 'package:flutter/material.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GSheetDb gSheets = GSheetDb();
  await gSheets.init();
  var v = await gSheets.getUsers();
  print(v);

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
      home: HomePage(),
    );
  }
}
