import 'package:easy_manager/consts.dart';
import 'package:easy_manager/main.dart';
import 'package:easy_manager/models/user_model.dart';
import 'package:easy_manager/screens/home_page_screen.dart';
import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late List<Map<String, String>>? userList;

  @override
  void initState() {
    super.initState();
  }

  _tryLogin() async {
    bool isLogged = false;
    try {
      showGeneralWaitingDialog(context);
      userList = await gSheetDb.getUsers();
      for (var element in userList!) {
        User user = User.fromMap(element);
        if (user.email == _emailController.text &&
            user.senha == _passwordController.text) {
          if (mounted) {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomePage()));
            isLogged = true;
          }
        }
        break;
      }
      if (mounted && isLogged == false) {
        Navigator.pop(context);
        showGeneralInformationDialogErrorMessage(
            'Usuário ou senha incorretos!', context);
      }
    } catch (e) {
      showGeneralInformationDialogErrorMessage(e.toString(), context);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 80.0),
                child: Center(
                  child: SizedBox(
                      width: 200,
                      height: 150,
                      child: Image.asset(kpathMainLogo)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
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
                  onEditingComplete: () => _tryLogin(),
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Senha'),
                ),
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(20)),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 155, 205, 255),
                  ),
                  onPressed: () async => _tryLogin(),
                  child: const Text(
                    'Acessar',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: black),
                  ),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
