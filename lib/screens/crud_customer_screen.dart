// ignore_for_file: prefer_const_constructors

import 'package:easy_manager/consts.dart';
import 'package:easy_manager/core/cep_network.dart';
import 'package:easy_manager/custom_widgets/button_round_with_shadow.dart';
import 'package:easy_manager/custom_widgets/custom_app_bar.dart';
import 'package:easy_manager/custom_widgets/custom_button_cancel.dart';
import 'package:easy_manager/custom_widgets/custom_button_confirm.dart';
import 'package:easy_manager/custom_widgets/custom_text_field.dart';
import 'package:easy_manager/models/address_model.dart';
import 'package:easy_manager/models/customer_model.dart';
import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

class CrudCustomerScreen extends StatefulWidget {
  const CrudCustomerScreen({Key? key, required this.isUpdate, this.customerKey})
      : super(key: key);
  final bool isUpdate;
  final String? customerKey;

  @override
  State<CrudCustomerScreen> createState() => _CrudCustomerScreenState();
}

class _CrudCustomerScreenState extends State<CrudCustomerScreen> {
  late FocusNode _focusNode;
  late Box _customerBox;
  late String keyToDelete;
  final _nameController = TextEditingController();
  final _cpfController = TextEditingController();
  final _cepController = TextEditingController();
  final _streetController = TextEditingController();
  final _districtController = TextEditingController();
  final _numberController = TextEditingController();
  final _complementController = TextEditingController();
  final _ufController = TextEditingController();
  final _cityController = TextEditingController();
  final _phoneNumber1Controller = TextEditingController();
  final _phoneNumber2Controller = TextEditingController();
  final _emailController = TextEditingController();
  final _observationsController = TextEditingController();

  @override
  void initState() {
    _focusNode = FocusNode();
    _customerBox = Hive.box(kCustomerBox);
    if (widget.isUpdate) {
      keyToDelete = widget.customerKey!;
      Customer customer = _customerBox.get(widget.customerKey);

      _nameController.text = customer.name;
      _cpfController.text = customer.cpf;
      _phoneNumber1Controller.text = customer.phoneNumber1;
      _phoneNumber2Controller.text = customer.phoneNumber2;
      _emailController.text = customer.email;
      _cepController.text = customer.address.cep;
      _ufController.text = customer.address.uf;
      _cityController.text = customer.address.localidade;
      _streetController.text = customer.address.logradouro;
      _numberController.text = customer.address.numero.toString();
      _districtController.text = customer.address.bairro;
      _complementController.text = customer.address.complemento;
      _observationsController.text = customer.observations;
    }

    super.initState();
  }

  _addUpdate() async {
    Address address = Address(
        bairro: _districtController.text,
        cep: _cepController.text,
        complemento: _complementController.text,
        localidade: _cityController.text,
        logradouro: _streetController.text,
        numero: _numberController.text,
        uf: _ufController.text);
    Customer customer = Customer(
        name: _nameController.text,
        cpf: _cpfController.text,
        address: address,
        phoneNumber1: _phoneNumber1Controller.text,
        phoneNumber2: _phoneNumber2Controller.text,
        email: _emailController.text,
        observations: _observationsController.text);

    if (widget.isUpdate) {
      await _customerBox.delete(keyToDelete);
    }
    if (_customerBox.containsKey(_cpfController.text)) {
      showGeneralDialogErrorMessage('Este CPF já foi cadastrado!', context);
    } else {
      await _customerBox.put(_cpfController.text, customer);
      Navigator.pop(context);
    }
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
                          iconPath: kpathSvgArrowBack),
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
                        callback: () => _getCep)),
                ButtonRoundWithShadow(
                    borderColor: woodSmoke,
                    shadowColor: woodSmoke,
                    color: white,
                    iconPath: 'lib/assets/svg/refresh.svg',
                    size: 50,
                    callback: () => _getCep),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    flex: 4,
                    child: CustomButtonCancel(
                        text: 'Cancelar',
                        onTap: () {
                          Navigator.pop(context);
                        })),
                Spacer(flex: 1),
                Expanded(
                    flex: 4,
                    child: CustomButtonConfirm(
                        text: 'Salvar', onTap: () => _addUpdate())),
              ],
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
