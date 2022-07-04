// ignore_for_file: prefer_const_constructors

import 'package:easy_manager/core/database_connection.dart';
import 'package:easy_manager/custom_widgets/button_round_with_shadow.dart';
import 'package:easy_manager/custom_widgets/custom_app_bar.dart';
import 'package:easy_manager/custom_widgets/custom_button_confirm.dart';
import 'package:easy_manager/custom_widgets/custom_text_field.dart';
import 'package:easy_manager/models/address_model.dart';
import 'package:easy_manager/models/client_model.dart';
import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sqflite/sqflite.dart';

class CrudClientScreen extends StatefulWidget {
  const CrudClientScreen({Key? key}) : super(key: key);

  @override
  State<CrudClientScreen> createState() => _CrudClientScreenState();
}

class _CrudClientScreenState extends State<CrudClientScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _observationsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          height: 100,
          child: Container(
            padding: EdgeInsets.only(top: 10),
            color: dandelion,
            child: SafeArea(
              child: Column(
                children: [
                  Row(
                    children: [
                      ButtonRoundWithShadow(
                          size: 48,
                          borderColor: woodSmoke,
                          color: white,
                          callback: () => Navigator.pop(context),
                          shadowColor: woodSmoke,
                          iconPath: 'lib/assets/svg/arrow_back.svg'),
                      const SizedBox(width: 20),
                      Text(
                        textAlign: TextAlign.center,
                        'Cadastrar Cliente',
                        style: TextStyle(
                            fontSize: 25,
                            fontFamily: 'JosefinsSans',
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        color: dandelion,
        child: ListView(
          children: [
            SizedBox(height: 10),
            CustomTextField(controller: _nameController, name: 'Nome'),
            SizedBox(height: 10),
            CustomTextField(controller: _cpfController, name: 'CPF'),
            SizedBox(height: 20),
            CustomTextField(controller: _cpfController, name: 'CEP'),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child:
                      CustomTextField(controller: _cpfController, name: 'UF'),
                ),
                Spacer(flex: 1),
                Expanded(
                  flex: 8,
                  child: CustomTextField(
                      controller: _cpfController, name: 'Cidade'),
                )
              ],
            ),
            SizedBox(height: 5),
            CustomTextField(controller: _cpfController, name: 'Rua'),
            SizedBox(height: 5),
            CustomTextField(controller: _cpfController, name: 'Número'),
            SizedBox(height: 5),
            CustomTextField(controller: _cpfController, name: 'Bairro'),
            SizedBox(height: 5),
            CustomTextField(controller: _cpfController, name: 'Complemento'),
            SizedBox(height: 20),
            CursomButtonConfirm(
              text: 'Salvar',
              onTap: () async {
                Address address = Address(
                    id: '_cepController.text',
                    cep: '',
                    logradouro: 'logradouro',
                    complemento: 'complemento',
                    bairro: 'bairro',
                    localidade: 'localidade',
                    uf: 'uf',
                    numero: 'numero');
                Client client = Client(
                    name: _nameController.text,
                    cpf: '_cpf.text',
                    address: address,
                    phoneList: [],
                    email: '_email.text',
                    observations: '_observations.text');

                var db = DatabaseConnection.instance;
                print(db.close());

                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
