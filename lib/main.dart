import 'dart:io';

import 'package:easy_manager/helper/customer_box_helper.dart';
import 'package:easy_manager/models/db_model.dart';
import 'package:easy_manager/objectbox.g.dart';

import 'package:easy_manager/screens/home_page_screen.dart';
import 'package:flutter/material.dart';

//late CustomerBox customerBox;
//late ProductBox productBox;
late Store? _store;
late Box<DbModelBox>? dbBox;
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await openStore().then((Store store) {
    _store = store;
    var syncServerIp = Platform.isAndroid ? '10.0.0.2' : '127.0.0.1';
    Sync.client(store, 'ws:$syncServerIp:9999', SyncCredentials.none());
    dbBox = store.box<DbModelBox>();
  });
  //customerBox = await CustomerBox.init();
  //productBox = await ProductBox.init();

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
