// ignore_for_file: prefer_const_constructors

import 'package:easy_manager/helper/spreadsheet_connection.dart';
import 'package:easy_manager/screens/budget/add_budget_screen.dart';
import 'package:easy_manager/screens/budget/budget_screen.dart';
import 'package:easy_manager/screens/home_page_screen.dart';
import 'package:easy_manager/screens/login_screen.dart';
import 'package:easy_manager/screens/product/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

late GSheetDb gSheetDb;
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  gSheetDb = GSheetDb();
  await gSheetDb.init();

  runApp( const MyApp());
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AddBudgetScreen(),
    );
  }
}
