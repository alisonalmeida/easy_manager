// ignore_for_file: prefer_const_constructors

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_manager/consts.dart';
import 'package:easy_manager/helper/check_connectivity.dart';
import 'package:easy_manager/main.dart';
import 'package:easy_manager/models/user_model.dart';
import 'package:easy_manager/screens/home_page_screen.dart';
import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerWidget {
  LoginPage({Key? key}) : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(usersProvider);
    final providedLoggedUser = ref.watch(loggedUser);

    tryLogin() async {
      bool userFound = false;

      users.when(
        data: (data) {
          for (var i = 0; i < data.length; i++) {
            var user = User.fromMap(data[i]);
            if (user.email == emailController.text &&
                user.senha == passwordController.text) {
              userFound = true;
              providedLoggedUser.email = user.email;
              providedLoggedUser.senha = user.senha;
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
        },
        error: (error, stackTrace) {
          showGeneralInformationDialogErrorMessage(error.toString(), context);
        },
        loading: () {
          showGeneralLoading(context);
        },
      );
    }

    return Scaffold(
      body: Column(
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
      bottomSheet: StreamBuilder(
        stream: Connection().checkConnection(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            ConnectivityResult result = snapshot.data as ConnectivityResult;
            if (result == ConnectivityResult.none) {
              return Text(
                'SEM INTERNET',
                style: TextStyle(backgroundColor: Colors.red),
              );
            } else {
              return Row();
            }
          } else {
            return Row();
          }
        },
      ),
    );
  }
}
