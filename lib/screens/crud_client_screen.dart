// ignore_for_file: prefer_const_constructors

import 'package:easy_manager/core/cep_network.dart';
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
  final _nameController = TextEditingController();
  final _cpfController = TextEditingController();
  final _cepController = TextEditingController();
  final _streetController = TextEditingController();
  final _districtController = TextEditingController();
  final _numberController = TextEditingController();
  final _complementController = TextEditingController();
  final _ufController = TextEditingController();
  final _cityController = TextEditingController();
  final _emailController = TextEditingController();
  final _observationsController = TextEditingController();

  Address _address = Address();

  _showGeneralDialogMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              ElevatedButton(
                  onPressed: () => Navigator.pop(context), child: Text('OK'))
            ],
            content: Text(message),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dandelion,
      appBar: CustomAppBar(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.all(5),
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
          )),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        color: dandelion,
        child: ListView(
          children: [
            SizedBox(height: 5),
            CustomTextField(
                controller: _nameController,
                name: 'Nome',
                textInputAction: TextInputAction.next),
            SizedBox(height: 5),
            CustomTextField(
                controller: _cpfController,
                name: 'CPF',
                textInputAction: TextInputAction.next),
            SizedBox(height: 5),
            CustomTextField(
                controller: _emailController,
                name: 'Email',
                textInputAction: TextInputAction.next),
            SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                    child: CustomTextField(
                        controller: _cepController,
                        name: 'CEP',
                        textInputAction: TextInputAction.done,
                        callback: () async {
                          try {
                            var r = await CepHelper.getData(_cepController.text
                                .replaceAll(RegExp(r'[^0-9]'), ''));
                            _address = Address.fromJson(r);
                            _ufController.text = _address.uf!;
                            _cityController.text = _address.localidade!;
                            _streetController.text = _address.logradouro!;
                            _districtController.text = _address.bairro!;
                          } catch (e) {
                            _showGeneralDialogMessage('Cep incorreto');
                          }
                        })),
                SizedBox(
                  height: 50,
                  width: 50,
                  child: ButtonRoundWithShadow(
                      borderColor: woodSmoke,
                      shadowColor: woodSmoke,
                      color: white,
                      iconPath: 'lib/assets/svg/refresh.svg',
                      size: 50,
                      callback: () async {
                        try {
                          var r = await CepHelper.getData(_cepController.text
                              .replaceAll(RegExp(r'[^0-9]'), ''));
                          _address = Address.fromJson(r);
                          _ufController.text = _address.uf!;
                          _cityController.text = _address.localidade!;
                          _streetController.text = _address.logradouro!;
                          _districtController.text = _address.bairro!;
                        } catch (e) {
                          _showGeneralDialogMessage('Cep incorreto');
                        }
                      }),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: CustomTextField(
                      controller: _ufController,
                      name: 'UF',
                      textInputAction: TextInputAction.next),
                ),
                Spacer(flex: 1),
                Expanded(
                  flex: 8,
                  child: CustomTextField(
                      controller: _cityController,
                      name: 'Cidade',
                      textInputAction: TextInputAction.next),
                )
              ],
            ),
            SizedBox(height: 5),
            CustomTextField(
                controller: _streetController,
                name: 'Rua',
                textInputAction: TextInputAction.next),
            SizedBox(height: 5),
            CustomTextField(
                controller: _numberController,
                name: 'Número',
                textInputAction: TextInputAction.next),
            SizedBox(height: 5),
            CustomTextField(
                controller: _districtController,
                name: 'Bairro',
                textInputAction: TextInputAction.next),
            SizedBox(height: 5),
            CustomTextField(
                controller: _complementController,
                name: 'Complemento',
                textInputAction: TextInputAction.next),
            SizedBox(height: 10),
            CustomTextField(
                controller: _observationsController,
                name: 'Observações',
                textInputAction: TextInputAction.next),
            SizedBox(height: 40),
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
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
