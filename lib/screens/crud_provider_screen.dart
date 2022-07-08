// ignore_for_file: prefer_const_constructors

import 'package:easy_manager/consts.dart';
import 'package:easy_manager/core/cep_network.dart';
import 'package:easy_manager/custom_widgets/button_round_with_shadow.dart';
import 'package:easy_manager/custom_widgets/custom_app_bar.dart';
import 'package:easy_manager/custom_widgets/custom_button_cancel.dart';
import 'package:easy_manager/custom_widgets/custom_button_confirm.dart';
import 'package:easy_manager/custom_widgets/custom_text_field.dart';
import 'package:easy_manager/models/address_model.dart';
import 'package:easy_manager/models/product_model.dart';
import 'package:easy_manager/models/product_provider_model.dart';
import 'package:easy_manager/utils/colors.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

class CrudProviderScreen extends StatefulWidget {
  CrudProviderScreen({Key? key, required this.isUpdate}) : super(key: key);

  bool isUpdate;

  @override
  State<CrudProviderScreen> createState() => _CrudProviderScreenState();
}

class _CrudProviderScreenState extends State<CrudProviderScreen> {
  late Box _productProviderBox;
  final _providerNameController = TextEditingController();
  final _cpfCnpjController = TextEditingController();
  final _phoneNumberController1 = TextEditingController();
  final _phoneNumberController2 = TextEditingController();
  final _emailController = TextEditingController();
  final _observationsController = TextEditingController();

  late bool _phoneVisibility;

  @override
  void initState() {
    _openBox();
    _phoneVisibility = false; //TODO
    super.initState();
  }

  _addUpdate() async {
    if (widget.isUpdate) {
    } else {
//ProductProvider(name: _providerNameController.text, document: _cpfCnpjController.text, phoneList: [_phoneNumberController1.text,_phoneNumberController2.text], address: , email: email, observations: observations)
      //     await _productProviderBox.add();
    }
  }

  _openBox() async {
    _productProviderBox = await Hive.openBox(kProductProviderBox);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    textInputType: TextInputType.number,
                    textInputFormatterList: [
                      FilteringTextInputFormatter.digitsOnly,
                      TextInputMask(mask: ['(99) 9 9999-9999)'])
                    ],
                    controller: _phoneNumberController1,
                    name: 'Telefone',
                    textInputAction: TextInputAction.next,
                  ),
                ),
                ButtonRoundWithShadow(
                    borderColor: woodSmoke,
                    shadowColor: woodSmoke,
                    color: white,
                    iconPath: _phoneVisibility ? kpathSvgMinus : kpathSvgPlus,
                    size: 50,
                    callback: () => setState(() {
                          _phoneVisibility = !_phoneVisibility;
                          _phoneNumberController2.clear();
                        }))
              ],
            ),
            Visibility(visible: _phoneVisibility, child: SizedBox(height: 5)),
            Visibility(
              visible: _phoneVisibility,
              child: CustomTextField(
                textInputType: TextInputType.number,
                textInputFormatterList: [
                  FilteringTextInputFormatter.digitsOnly,
                  TextInputMask(mask: ['(99) 9 9999-9999)'])
                ],
                controller: _phoneNumberController2,
                name: 'Telefone',
                textInputAction: TextInputAction.next,
              ),
            ),
            SizedBox(height: 5),
            CustomTextField(
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
                        callback: () async {
                          showGeneralWaitingDialog(context);

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
                            showGeneralDialogErrorMessage('Erro', context);
                          }
                        })),
                ButtonRoundWithShadow(
                    borderColor: woodSmoke,
                    shadowColor: woodSmoke,
                    color: white,
                    iconPath: 'lib/assets/svg/refresh.svg',
                    size: 50,
                    callback: () async {
                      showGeneralWaitingDialog(context);

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
            SizedBox(height: 5),
            CustomTextField(
                minLines: 3,
                maxLines: 6,
                controller: _observationsController,
                name: 'Observações',
                textInputAction: TextInputAction.next),
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
                    child: CustomButtonConfirm(text: 'Salvar', onTap: () {}))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
