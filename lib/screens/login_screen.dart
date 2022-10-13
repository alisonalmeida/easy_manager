// ignore_for_file: prefer_const_constructors

import 'package:easy_manager/consts.dart';
import 'package:easy_manager/main.dart';
import 'package:easy_manager/models/user_model.dart';
import 'package:easy_manager/screens/home_page_screen.dart';
import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  List<Map<String, String>> listUsers = [];

  tryLogin() async {
    bool userFound = false;
    for (var i = 0; i < listUsers.length; i++) {
      var user = User.fromMap(listUsers[i]);
      if (user.email == emailController.text &&
          user.senha == passwordController.text) {
        loggedUser = user;
        userFound = true;
        break;
      }
    }
    if (userFound) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } else {
      showGeneralInformationDialogErrorMessage(
          'Usuário ou Senha incorretos', context);
    }
  }

  @override
  void initState() {
    gSheetDb.getUsers().then((users) => listUsers = users);
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: Center(
                child: SizedBox(
                    width: 200, height: 150, child: Image.asset(kpathMainLogo)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Ex. abc@gmail.com'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 40),
              child: TextField(
                onEditingComplete: () => tryLogin(),
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Senha'),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(250, 50),
                backgroundColor: const Color.fromARGB(255, 155, 205, 255),
              ),
              onPressed: () async => tryLogin(),
              child: const Text(
                'Acessar',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 25, color: black),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
