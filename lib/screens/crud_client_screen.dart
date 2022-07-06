// ignore_for_file: prefer_const_constructors

import 'package:easy_manager/consts.dart';
import 'package:easy_manager/core/cep_network.dart';
import 'package:easy_manager/custom_widgets/button_round_with_shadow.dart';
import 'package:easy_manager/custom_widgets/custom_app_bar.dart';
import 'package:easy_manager/custom_widgets/custom_button_confirm.dart';
import 'package:easy_manager/custom_widgets/custom_text_field.dart';
import 'package:easy_manager/models/address_model.dart';
import 'package:easy_manager/models/client_model.dart';
import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

class CrudClientScreen extends StatefulWidget {
  const CrudClientScreen({Key? key}) : super(key: key);

  @override
  State<CrudClientScreen> createState() => _CrudClientScreenState();
}

class _CrudClientScreenState extends State<CrudClientScreen> {
  late Box _clientBox;
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

  @override
  void initState() {
    _openBox();
    super.initState();
  }

  addUpdateClient(Client client) async {
    await _clientBox.add(client);
  }

  _showGeneralDialogErrorMessage(String message) {
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

  _showGeneralWaitingDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: CircularProgressIndicator(),
          );
        });
  }

  _openBox() async {
    _clientBox = await Hive.openBox(kClientBox);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dandelion,
      appBar: CustomAppBar(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.all(5),
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
            SizedBox(height: 5),
            CustomTextField(
                textInputType: TextInputType.name,
                controller: _nameController,
                name: 'Nome',
                textInputAction: TextInputAction.next),
            SizedBox(height: 5),
            CustomTextField(
                textInputType: TextInputType.number,
                textInputFormatterList: [
                  FilteringTextInputFormatter.digitsOnly,
                  TextInputMask(mask: '999.999.999-99')
                ],
                controller: _cpfController,
                name: 'CPF',
                textInputAction: TextInputAction.next),
            SizedBox(height: 5),
            CustomTextField(
                textInputType: TextInputType.emailAddress,
                controller: _emailController,
                name: 'Email',
                textInputAction: TextInputAction.next),
            SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                    child: CustomTextField(
                        textInputType: TextInputType.number,
                        textInputFormatterList: [
                          TextInputMask(mask: '99999-999')
                        ],
                        controller: _cepController,
                        name: 'CEP',
                        textInputAction: TextInputAction.done,
                        callback: () async {
                          _showGeneralWaitingDialog();

                          try {
                            var r = await CepHelper.getData(_cepController.text
                                .replaceAll(RegExp(r'[^0-9]'), ''));
                            _address = Address.fromJson(r);
                            _ufController.text = _address.uf!;
                            _cityController.text = _address.localidade!;
                            _streetController.text = _address.logradouro!;
                            _districtController.text = _address.bairro!;
                            if (!mounted) return; //check if the data has come
                            Navigator.pop(context);
                          } catch (e) {
                            _showGeneralDialogErrorMessage('Erro');
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
                        _showGeneralWaitingDialog();

                        try {
                          var r = await CepHelper.getData(_cepController.text
                              .replaceAll(RegExp(r'[^0-9]'), ''));
                          _address = Address.fromJson(r);
                          _ufController.text = _address.uf!;
                          _cityController.text = _address.localidade!;
                          _streetController.text = _address.logradouro!;
                          _districtController.text = _address.bairro!;
                          if (!mounted) return; //check if the data has come
                          Navigator.pop(context);
                        } catch (e) {
                          _showGeneralDialogErrorMessage('Erro');
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
              onTap: () {
                Address address = Address(
                    cep: _cepController.text,
                    logradouro: _streetController.text,
                    complemento: _complementController.text,
                    bairro: _districtController.text,
                    localidade: _cityController.text,
                    uf: _ufController.text,
                    numero: _numberController.text);
                Client client = Client(
                    name: _nameController.text,
                    cpf: _cpfController.text,
                    address: address,
                    phoneList: [],
                    email: _emailController.text,
                    observations: _observationsController.text);

                addUpdateClient(client);

                Navigator.pop(context);
              },
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        _clientBox.toMap().forEach((key, value) {
          Client client = value;

          print('Key: $key');
          print('Value: ${client.name}');
          print('Value: ${client.address}');
          print('Value: ${client.cpf}');
          print('Value: ${client.email}');
          print('Value: ${client.observations}');
          print('Value: ${client.phoneList}');
        });
      }),
    );
  }
}
