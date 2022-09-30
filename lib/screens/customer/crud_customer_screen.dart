// ignore_for_file: prefer_const_constructors

import 'package:easy_manager/consts.dart';
import 'package:easy_manager/helper/cep_network.dart';
import 'package:easy_manager/core/upper_case_text_formatter.dart';
import 'package:easy_manager/custom_widgets/custom_address_area.dart';
import 'package:easy_manager/custom_widgets/custom_app_bar.dart';
import 'package:easy_manager/custom_widgets/custom_button_cancel.dart';
import 'package:easy_manager/custom_widgets/custom_button_confirm.dart';
import 'package:easy_manager/custom_widgets/custom_text_field.dart';
import 'package:easy_manager/main.dart';
import 'package:easy_manager/models/address.dart';
import 'package:easy_manager/models/customer_model.dart';
import 'package:easy_manager/screens/customer/customer_screen.dart';
import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CrudCustomerScreen extends StatefulWidget {
  const CrudCustomerScreen({Key? key, this.id}) : super(key: key);

  final String? id;

  @override
  State<CrudCustomerScreen> createState() => _CrudCustomerScreenState();
}

class _CrudCustomerScreenState extends State<CrudCustomerScreen> {
  late FocusNode _focusNode;
  late bool isUpdate;

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
    isUpdate = widget.id == null ? false : true;
    isUpdate ? _fillFields() : null;
    super.initState();
  }

  _fillFields() async {
    Customer? customer = await gSheetDb.getCustomer(widget.id!);

    _nameController.text = customer!.nome!;
    _cpfController.text = customer.documento!;
    _phoneNumber1Controller.text = customer.telefone1!;
    _phoneNumber2Controller.text = customer.telefone2!;
    _emailController.text = customer.email!;
    _cepController.text = customer.cep!;
    _ufController.text = customer.uf!;
    _cityController.text = customer.localidade!;
    _streetController.text = customer.logradouro!;
    _districtController.text = customer.bairro!;
    _numberController.text = customer.numero!;
    _complementController.text = customer.complemento!;
    _observationsController.text = customer.observacoes!;
  }

  Future? _saveUpdate() async {
    showGeneralLoading(context);

    Customer customer = Customer(
        id: isUpdate ? widget.id : '',
        nome: _nameController.text,
        documento: _cpfController.text,
        telefone1: _phoneNumber1Controller.text,
        telefone2: _phoneNumber2Controller.text,
        email: _emailController.text,
        cep: _cepController.text,
        uf: _ufController.text,
        localidade: _cityController.text,
        logradouro: _streetController.text,
        numero: _numberController.text,
        bairro: _districtController.text,
        complemento: _complementController.text,
        observacoes: _observationsController.text);
    await gSheetDb.putCustomer(customer);
    if (mounted) {
      Navigator.pop(context);
      Navigator.pop(context);
    }
  }

  _getCep() async {
    showGeneralLoading(context);
    try {
      Address address = await CepHelper.getData(
          _cepController.text.replaceAll(RegExp(r'[^0-9]'), '').toUpperCase());

      _ufController.text = address.uf!;
      _cityController.text = address.localidade!.toUpperCase();
      _streetController.text = address.logradouro!.toUpperCase();
      _districtController.text = address.bairro!.toUpperCase();

      if (!mounted) return; //check if the data has come
      Navigator.pop(context);
      _focusNode.requestFocus(); //send focus to number address textfield
    } catch (e) {
      Navigator.pop(context);
      showGeneralInformationDialogErrorMessage('Erro: $e', context);
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _nameController.dispose();
    _cpfController.dispose();
    _cepController.dispose();
    _streetController.dispose();
    _districtController.dispose();
    _numberController.dispose();
    _complementController.dispose();
    _ufController.dispose();
    _cityController.dispose();
    _phoneNumber1Controller.dispose();
    _phoneNumber2Controller.dispose();
    _emailController.dispose();
    _observationsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) => WillPopScope(
        onWillPop: () async {
          final shouldPop = await _showConfirmationExitDialog();
          shouldPop == true ? ref.refresh(customersProvider) : null;

          return shouldPop ?? false;
        },
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            backgroundColor: customerBackgroundColor,
            appBar: CustomAppBar(
              heroAnimation: CustomerScreen.name,
              svgImage: kpathSvgPerson,
              callback: () async =>
                  await showGeneralConfirmationExitDialog(context),
              backgroundColor: customerBackgroundColor,
              title: CustomerScreen.name,
            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              color: customerBackgroundColor,
              child: ListView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
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
                  CustomTextField(
                      textInputType: TextInputType.emailAddress,
                      controller: _phoneNumber1Controller,
                      name: 'Telefone 1',
                      textInputAction: TextInputAction.next),
                  SizedBox(height: 5),
                  CustomTextField(
                      textInputType: TextInputType.emailAddress,
                      controller: _phoneNumber2Controller,
                      name: 'Telefone 2',
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
                      maxLines: 6,
                      textInputFormatterList: [UpperCaseTextFormatter()],
                      controller: _observationsController,
                      name: 'Observações',
                      textInputAction: TextInputAction.done),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          flex: 4,
                          child: CustomButtonCancel(
                              text: 'Cancelar',
                              onTap: () => Navigator.pop(context))),
                      Spacer(flex: 1),
                      Expanded(
                          flex: 4,
                          child: CustomButtonConfirm(
                            isEnabled: true,
                            text: 'Salvar',
                            onTap: () async {
                              await _saveUpdate();
                              ref.refresh(customersProvider);
                            },
                          ))
                    ],
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ),
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
