// ignore_for_file: prefer_const_constructors

import 'package:easy_manager/helper/spreadsheet_connection.dart';
import 'package:easy_manager/models/user_model.dart';
import 'package:easy_manager/screens/budget/budget_screen.dart';
import 'package:easy_manager/screens/home_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

late GSheetDb gSheetDb;
final usersProvider = FutureProvider(
  (_) => gSheetDb.getUsers(),
);
final loggedUser = Provider<User>(
  (_) => User(),
);
final productProvidersProvider = FutureProvider(
  (_) => gSheetDb.getProviders(),
);
final productsProvider = FutureProvider(
  (_) => gSheetDb.getProducts(),
);

final customersProvider = FutureProvider(
  (_) => gSheetDb.getCustomers(),
);
final budgetsProvider = FutureProvider(
  (_) => gSheetDb.getBudgets(),
);
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  gSheetDb = GSheetDb();
  await gSheetDb.init();

  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
