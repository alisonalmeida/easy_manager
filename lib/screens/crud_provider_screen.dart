// ignore_for_file: prefer_const_constructors

import 'package:easy_manager/consts.dart';
import 'package:easy_manager/core/cep_network.dart';
import 'package:easy_manager/core/upper_case_text_formatter.dart';
import 'package:easy_manager/custom_widgets/custom_address_area.dart';
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

class CrudProviderScreen extends StatefulWidget {
  const CrudProviderScreen({Key? key, this.productProviderKey})
      : super(key: key);

  final int? productProviderKey;

  @override
  State<CrudProviderScreen> createState() => _CrudProviderScreenState();
}

class _CrudProviderScreenState extends State<CrudProviderScreen> {
  late FocusNode _focusNode;

  bool _isEnabled = true;
  late bool isUpdate;

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
    _focusNode = FocusNode();
    isUpdate = widget.productProviderKey == null ? false : true;
    //update
   /**
    *  if (isUpdate) {
      ProductProvider? productProvider =
          companyBox.getProvider(widget.productProviderKey!);
      Address address = Address();
      _providerNameController.text = productProvider!.name!;
      _cpfCnpjController.text = productProvider.document!;
      _phoneNumberController1.text = productProvider.phoneNumber1!;
      _phoneNumberController2.text = productProvider.phoneNumber2!;
      _emailController.text = productProvider.email!;
      address = addressFromJson(productProvider.getAddress);
      _cepController.text = address.cep!;
      _ufController.text = address.uf!;
      _cityController.text = address.localidade!;
      _streetController.text = address.logradouro!;
      _numberController.text = address.numero.toString();
      _districtController.text = address.bairro!;
      _complementController.text = address.complemento!;
      _observationsController.text = productProvider.observations!;
    }
    */
    super.initState();
  }

  _saveUpdate() async {
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
        address: addressToJson(address),
        email: _emailController.text,
        observations: _observationsController.text);

    if (isUpdate) {
      productProvider.id = widget.productProviderKey!;
    }

    /**
     * if (companyBox.checkProviderDocument(productProvider.document!) &&
        !isUpdate) {
      showGeneralInformationDialogErrorMessage(
          'O CPF/CNPJ já está cadastrado. Edite o antigo ou escolha outro documento!',
          context);
    } else {
      companyBox.insertProvider(productProvider);
      Navigator.pop(context);
    }
     */
  }

  _getCep() async {
    showGeneralWaitingDialog(context);
    try {
      final Address address;
      var r = await CepHelper.getData(
          _cepController.text.replaceAll(RegExp(r'[^0-9]'), ''));
      address = Address.fromJson(r);
      _ufController.text = address.uf!;
      _cityController.text = address.localidade!;
      _streetController.text = address.logradouro!;
      _districtController.text = address.bairro!;

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
    _providerNameController.dispose();
    _cpfCnpjController.dispose();
    _phoneNumberController1.dispose();
    _phoneNumberController2.dispose();
    _emailController.dispose();
    _cepController.dispose();
    _ufController.dispose();
    _cityController.dispose();
    _streetController.dispose();
    _districtController.dispose();
    _numberController.dispose();
    _complementController.dispose();
    _observationsController.dispose();

    super.dispose();
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
          backgroundColor: providerBackgroundColor,
          appBar: CustomAppBar(
              callback: () async => showGeneralConfirmationExitDialog(context),
              heroAnimation: '',
              svgImage: kpathSvgFactory,
              title: 'Cadastrar Fornecedor',
              backgroundColor: providerBackgroundColor),
          body: Container(
            color: providerBackgroundColor,
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: ListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              children: [
                SizedBox(height: 5),
                CustomTextField(
                    textInputFormatterList: [UpperCaseTextFormatter()],
                    textInputType: TextInputType.name,
                    controller: _providerNameController,
                    name: 'Nome do Fornecedor',
                    textInputAction: TextInputAction.next),
                SizedBox(height: 5),
                CustomTextField(
                    textInputType: TextInputType.number,
                    textInputFormatterList: [
                      FilteringTextInputFormatter.digitsOnly,
                      TextInputMask(
                          mask: ['999.999.999-99', '99.999.999/9999-99'])
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
                SizedBox(height: 5),
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
                            onTap: () =>
                              Navigator.pop(context)
                            )),
                    Spacer(flex: 1),
                    Expanded(
                        flex: 4,
                        child: CustomButtonConfirm(
                          isEnabled: _isEnabled,
                          text: 'Salvar',
                          onTap: _saveUpdate,
                        ))
                  ],
                ),
                SizedBox(height: 40),
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
