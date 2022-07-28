// ignore_for_file: prefer_const_constructors

import 'package:easy_manager/helper/objectbox_helper.dart';
import 'package:easy_manager/screens/home_page_screen.dart';
import 'package:flutter/material.dart';

late ObjectBox companyBox;
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  companyBox = await ObjectBox.init();

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
