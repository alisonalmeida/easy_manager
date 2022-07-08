// ignore_for_file: prefer_const_constructors

import 'package:easy_manager/consts.dart';
import 'package:easy_manager/core/cep_network.dart';
import 'package:easy_manager/custom_widgets/button_round_with_shadow.dart';
import 'package:easy_manager/custom_widgets/custom_app_bar.dart';
import 'package:easy_manager/custom_widgets/custom_button_cancel.dart';
import 'package:easy_manager/custom_widgets/custom_button_confirm.dart';
import 'package:easy_manager/custom_widgets/custom_text_field.dart';
import 'package:easy_manager/models/address_model.dart';
import 'package:easy_manager/models/product_provider_model.dart';
import 'package:easy_manager/utils/colors.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

class CrudProviderScreen extends StatefulWidget {
  const CrudProviderScreen(
      {Key? key, required this.isUpdate, this.productProviderKey})
      : super(key: key);

  final bool isUpdate;
  final int? productProviderKey;

  @override
  State<CrudProviderScreen> createState() => _CrudProviderScreenState();
}

class _CrudProviderScreenState extends State<CrudProviderScreen> {
  late FocusNode _focusNode;
  late Box _productProviderBox;

  final _providerNameController = TextEditingController();
  final _cpfCnpjController = TextEditingController();
  final _phoneNumberController1 = TextEditingController();
  final _phoneNumberController2 = TextEditingController();
  final _emailController = TextEditingController();
  final _cepController = TextEditingController();
  final _ufController = TextEditingController();
  final _cityController = TextEditingController();
  final _streetController = TextEditingController();
  final _districtController = TextEditingController();
  final _numberController = TextEditingController();
  final _complementController = TextEditingController();
  final _observationsController = TextEditingController();

  @override
  void initState() {
    _openBox();
    _focusNode = FocusNode();
    //TODO
    super.initState();
  }

  _addUpdate() async {
    if (widget.isUpdate) {
    } else {
      Address address = Address(
          bairro: _districtController.text,
          cep: _cepController.text,
          complemento: _complementController.text,
          localidade: _cityController.text,
          logradouro: _streetController.text,
          numero: _numberController.text,
          uf: _ufController.text);
      ProductProvider productProvider = ProductProvider(
          name: _providerNameController.text,
          document: _cpfCnpjController.text,
          phoneNumber1: _phoneNumberController1.text,
          phoneNumber2: _phoneNumberController2.text,
          address: address,
          email: _emailController.text,
          observations: _observationsController.text);
      await _productProviderBox.add(productProvider);
    }
    Navigator.pop(context);
  }

  _openBox() async {
    _productProviderBox = await Hive.openBox(kProductProviderBox);
  }

  _getCep() async {
    showGeneralWaitingDialog(context);
    try {
      final Address address;
      var r = await CepHelper.getData(
          _cepController.text.replaceAll(RegExp(r'[^0-9]'), ''));
      address = Address.fromJson(r);
      _ufController.text = address.uf;
      _cityController.text = address.localidade;
      _streetController.text = address.logradouro;
      _districtController.text = address.bairro;

      if (!mounted) return; //check if the data has come
      Navigator.pop(context);
      _focusNode.requestFocus();
    } catch (e) {
      Navigator.pop(context);
      showGeneralDialogErrorMessage('Erro: $e', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: carribeanGreen,
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
                        'Cadastrar Fornecedor',
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
        color: carribeanGreen,
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: [
            SizedBox(height: 5),
            CustomTextField(
                controller: _providerNameController,
                name: 'Nome do Fornecedor',
                textInputAction: TextInputAction.next),
            SizedBox(height: 5),
            CustomTextField(
                textInputType: TextInputType.number,
                textInputFormatterList: [
                  FilteringTextInputFormatter.digitsOnly,
                  TextInputMask(mask: ['999.999.999-99', '99.999.999/9999-99'])
                ],
                controller: _cpfCnpjController,
                name: 'CPF/CNPJ',
                textInputAction: TextInputAction.next),
            SizedBox(height: 5),
            CustomTextField(
              textInputType: TextInputType.number,
              textInputFormatterList: [
                FilteringTextInputFormatter.digitsOnly,
                TextInputMask(mask: ['(99) 9 9999-9999)'])
              ],
              controller: _phoneNumberController1,
              name: 'Telefone 1',
              textInputAction: TextInputAction.next,
            ),
            CustomTextField(
              textInputType: TextInputType.number,
              textInputFormatterList: [
                FilteringTextInputFormatter.digitsOnly,
                TextInputMask(mask: ['(99) 9 9999-9999)'])
              ],
              controller: _phoneNumberController2,
              name: 'Telefone 2',
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: 5),
            CustomTextField(
                textInputType: TextInputType.emailAddress,
                controller: _emailController,
                name: 'E-mail',
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
                        callback: () => _getCep())),
                ButtonRoundWithShadow(
                    borderColor: woodSmoke,
                    shadowColor: woodSmoke,
                    color: white,
                    iconPath: 'lib/assets/svg/refresh.svg',
                    size: 50,
                    callback: () => _getCep()),
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
                focusNode: _focusNode,
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
            SizedBox(height: 5),
            CustomTextField(
                minLines: 3,
                maxLines: 6,
                controller: _observationsController,
                name: 'Observações',
                textInputAction: TextInputAction.done),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    flex: 4,
                    child: CustomButtonCancel(text: 'Cancelar', onTap: () {})),
                Spacer(flex: 1),
                Expanded(
                    flex: 4,
                    child: CustomButtonConfirm(
                        text: 'Salvar', onTap: () async => _addUpdate()))
              ],
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Text('Teste'),
          onPressed: () {
            _productProviderBox.clear();
          }),
    );
  }
}
