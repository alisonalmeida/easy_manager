// ignore_for_file: prefer_const_constructors
// flutter pub run build_runner build --delete-conflicting-outputs

import 'package:easy_manager/helper/spreadsheet_connection.dart';
import 'package:easy_manager/models/user_model.dart';
import 'package:easy_manager/screens/error_page.dart';
import 'package:easy_manager/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

GSheetDb gSheetDb = GSheetDb();
User loggedUser = User(nome: '', email: '', perfil: '', senha: '');

final productProvidersProvider = FutureProvider((_) => gSheetDb.getProviders());
final productsProvider = FutureProvider((_) => gSheetDb.getProducts());

final customersProvider = FutureProvider((_) {
  return gSheetDb.getCustomers();
});
final budgetsProvider = FutureProvider((_) => gSheetDb.getBudgets());

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await gSheetDb.init();
    runApp(ProviderScope(child: const MyApp()));
  } catch (e) {
    runApp(ErrorApp());
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class ErrorApp extends ConsumerWidget {
  const ErrorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ErrorPage(),
    );
  }
}
