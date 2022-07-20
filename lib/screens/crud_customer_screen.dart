// ignore_for_file: prefer_const_constructors

import 'package:easy_manager/consts.dart';
import 'package:easy_manager/core/cep_network.dart';
import 'package:easy_manager/core/upper_case_text_formatter.dart';
import 'package:easy_manager/custom_widgets/custom_address_area.dart';
import 'package:easy_manager/custom_widgets/custom_app_bar.dart';
import 'package:easy_manager/custom_widgets/custom_button_cancel.dart';
import 'package:easy_manager/custom_widgets/custom_button_confirm.dart';
import 'package:easy_manager/custom_widgets/custom_text_field.dart';
import 'package:easy_manager/main.dart';
import 'package:easy_manager/models/address_model.dart';
import 'package:easy_manager/models/customer_model.dart';
import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/services.dart';

class CrudCustomerScreen extends StatefulWidget {
  const CrudCustomerScreen({Key? key, this.customerKey}) : super(key: key);

  final int? customerKey;

  @override
  State<CrudCustomerScreen> createState() => _CrudCustomerScreenState();
}

class _CrudCustomerScreenState extends State<CrudCustomerScreen> {
  late FocusNode _focusNode;
  bool _isEnabled = true;

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
    //update
    if (widget.customerKey != null) {
      final Customer customer = companyDB.getCustomer(widget.customerKey!)!;
      Address address = Address();
      _nameController.text = customer.name!;
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
      _observationsController.text = customer.observations!;
    }

    super.initState();
  }

  _saveUpdate() {
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
        address: addressToJson(address),
        phoneNumber1: _phoneNumber1Controller.text,
        phoneNumber2: _phoneNumber2Controller.text,
        email: _emailController.text,
        observations: _observationsController.text);
    if (widget.customerKey != null) {
      companyDB.deleteCustomer(widget.customerKey!);
    }
    companyDB.insertCustomer(customer);
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
      showGeneralInformationDialogErrorMessage('Erro: $e', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await _showConfirmationExitDialog();
        return shouldPop ?? false;
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: dandelion,
          appBar: CustomAppBar(
            heroAnimation: '',
            svgImage: kpathSvgPerson,
            callback: () async => showGeneralConfirmationExitDialog(context),
            backgroundColor: dandelion,
            title: 'Cadastrar Cliente',
          ),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            color: dandelion,
            child: ListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                          isEnabled: _isEnabled,
                          text: 'Salvar',
                          onTapValid: () => _saveUpdate(),
                          onTapInValid: () =>
                              showGeneralInformationDialogErrorMessage(
                                  'Por favor, preencha todos os campos obrigatórios!',
                                  context),
                        ))
                  ],
                ),
                SizedBox(height: 50),
              ],
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
