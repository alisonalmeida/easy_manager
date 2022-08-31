// ignore_for_file: prefer_const_constructors

import 'package:easy_manager/core/misc.dart';
import 'package:easy_manager/helper/spreadsheet_connection.dart';
import 'package:easy_manager/screens/home_page_screen.dart';
import 'package:easy_manager/screens/intro_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

late GSheetDb gSheetDb;
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /**
   * gSheetDb = GSheetDb();
  await gSheetDb.init();
   */
  _checkFirstLauch();
  runApp(const MyApp());
}

_checkFirstLauch() async {
  final prefs = await SharedPreferences.getInstance();
  
  isFirstLaunch = prefs.getBool('isFirstLaunch')!;
  isFirstLaunch == null ? true : false;
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
      home: isFirstLaunch! ? IntroPage() : HomePage(),
    );
  }
}
