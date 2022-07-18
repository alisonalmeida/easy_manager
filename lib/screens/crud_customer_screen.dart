// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:easy_manager/consts.dart';
import 'package:easy_manager/core/cep_network.dart';
import 'package:easy_manager/core/upper_case_text_formatter.dart';
import 'package:easy_manager/custom_widgets/button_round_with_shadow.dart';
import 'package:easy_manager/custom_widgets/custom_address_area.dart';
import 'package:easy_manager/custom_widgets/custom_app_bar.dart';
import 'package:easy_manager/custom_widgets/custom_button_cancel.dart';
import 'package:easy_manager/custom_widgets/custom_button_confirm.dart';
import 'package:easy_manager/custom_widgets/custom_cancel_save_buttons.dart';
import 'package:easy_manager/custom_widgets/custom_text_field.dart';
import 'package:easy_manager/main.dart';
import 'package:easy_manager/models/address_model.dart';
import 'package:easy_manager/models/customer_model.dart';
import 'package:easy_manager/models/company_model.dart';
import 'package:easy_manager/models/product_model.dart';
import 'package:objectbox/objectbox.dart';

import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/services.dart';

class CrudCustomerScreen extends StatefulWidget {
  const CrudCustomerScreen(
      {Key? key,
      required this.isUpdate,
      this.customerKey,
      required this.customerBox})
      : super(key: key);

  final Box<CustomerModel> customerBox;

  final bool isUpdate;
  final int? customerKey;

  @override
  State<CrudCustomerScreen> createState() => _CrudCustomerScreenState();
}

class _CrudCustomerScreenState extends State<CrudCustomerScreen> {
  late FocusNode _focusNode;
  late int keyToDelete;

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
    /*
    _focusNode = FocusNode();

    if (widget.isUpdate) {
      keyToDelete = widget.customerKey!;
      Address address = Address();
      CustomerModel? customer = customerBox.getCustomer(widget.customerKey!);
      _nameController.text = customer!.name!;
      _cpfController.text = customer.cpf!;
      _phoneNumber1Controller.text = customer.phoneNumber1!;
      _phoneNumber2Controller.text = customer.phoneNumber2!;
      _emailController.text = customer.email!;

      address = addressFromJson(customer.getAddress);
      _cepController.text = address.cep!;
      _districtController.text = address.bairro!;
      _streetController.text = address.logradouro!;
      _numberController.text = address.numero!;
      _complementController.text = address.complemento!;
      _ufController.text = address.uf!;
      _cityController.text = address.localidade!;
    }
*/
    super.initState();
  }

  _addUpdate() {
    Address address = Address(
        bairro: _districtController.text,
        cep: _cepController.text,
        complemento: _complementController.text,
        localidade: _cityController.text,
        logradouro: _streetController.text,
        numero: _numberController.text,
        uf: _ufController.text);
    CustomerModel customer = CustomerModel(
        name: _nameController.text,
        cpf: _cpfController.text,
        address: addressToJson(address),
        phoneNumber1: _phoneNumber1Controller.text,
        phoneNumber2: _phoneNumber2Controller.text,
        email: _emailController.text,
        observations: _observationsController.text);

    if (widget.isUpdate) {
      keyToDelete = widget.customerKey!;
      widget.customerBox.put(customer);

      //customerBox.deleteCustomer(keyToDelete);
    }

    //customerBox.insertCustomer(customer);

    Navigator.pop(context);
  }

  _getCep() async {
    showGeneralWaitingDialog(context);
    try {
      final Address address;
      var r = await CepHelper.getData(
          _cepController.text.replaceAll(RegExp(r'[^0-9]'), '').toUpperCase());
      address = Address.fromJson(r);
      _ufController.text = address.uf!.toUpperCase();
      _cityController.text = address.localidade!.toUpperCase();
      _streetController.text = address.logradouro!.toUpperCase();
      _districtController.text = address.bairro!.toUpperCase();

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
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await _showConfirmationExitDialog();
        return shouldPop ?? false;
      },
      child: Scaffold(
        backgroundColor: dandelion,
        appBar: CustomAppBar(
          callback: _showConfirmationExitDialog,
          backgroundColor: dandelion,
          title: 'Cadastrar Cliente',
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          color: dandelion,
          child: ListView(
            children: [
              SizedBox(height: 5),
              CustomTextField(
                  textInputFormatterList: [UpperCaseTextFormatter()],
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
              CustomAddressArea(
                  cepController: _cepController,
                  callback: _getCep,
                  ufController: _ufController,
                  cityController: _cityController,
                  streetController: _streetController,
                  districtController: _districtController,
                  numberController: _numberController,
                  complementController: _complementController,
                  focusNode: _focusNode),
              SizedBox(height: 10),
              CustomTextField(
                  minLines: 3,
                  maxLines: 3,
                  textInputFormatterList: [UpperCaseTextFormatter()],
                  controller: _observationsController,
                  name: 'Observações',
                  textInputAction: TextInputAction.done),
              SizedBox(height: 40),
              CustomCancelSaveButtons(
                  saveCallback: _addUpdate,
                  cancelCallback: () {
                    _showConfirmationExitDialog();
                  }),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool?> _showConfirmationExitDialog() async => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('O cadastro não foi salvo. Deseja realmente sair?'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text('NÃO')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                    Navigator.pop(context, true);
                  },
                  child: Text('SIM'))
            ],
          ));
}
