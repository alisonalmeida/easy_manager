import 'dart:io';

import 'package:easy_manager/consts.dart';
import 'package:easy_manager/models/address_model.dart';
import 'package:easy_manager/models/customer_model.dart';
import 'package:easy_manager/models/product_model.dart';
import 'package:easy_manager/models/product_provider_model.dart';
import 'package:easy_manager/screens/home_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var dir = await getApplicationDocumentsDirectory();
  Hive
    ..init(dir.path)
    ..registerAdapter(AddressAdapter())
    ..registerAdapter(CustomerAdapter())
    ..registerAdapter(ProductAdapter())
    ..registerAdapter(ProductProviderAdapter());
  Hive.openBox(kAddressBox);
  Hive.openBox(kCustomerBox);
  Hive.openBox(kProductBox);
  Hive.openBox(kProductProviderBox);

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
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
