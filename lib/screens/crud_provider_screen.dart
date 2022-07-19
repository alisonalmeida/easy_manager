// ignore_for_file: prefer_const_constructors

import 'package:easy_manager/consts.dart';
import 'package:easy_manager/core/cep_network.dart';
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
  const CrudProviderScreen(
      {Key? key, required this.isUpdate, this.productProviderKey})
      : super(key: key);

  final bool isUpdate;
  final String? productProviderKey;

  @override
  State<CrudProviderScreen> createState() => _CrudProviderScreenState();
}

class _CrudProviderScreenState extends State<CrudProviderScreen> {
  late FocusNode _focusNode;
  late String keyToDelete;

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
    /*
    _productProviderBox = Hive.box(kProductProviderBox);
    _focusNode = FocusNode();
    if (widget.isUpdate) {
      keyToDelete = widget.productProviderKey!;
      final ProductProvider productProvider =
          _productProviderBox.get(widget.productProviderKey);

      _providerNameController.text = productProvider.name;
      _cpfCnpjController.text = productProvider.document;
      _phoneNumberController1.text = productProvider.phoneNumber1;
      _phoneNumberController2.text = productProvider.phoneNumber2;
      _emailController.text = productProvider.email;
      _cepController.text = productProvider.address.cep;
      _ufController.text = productProvider.address.uf;
      _cityController.text = productProvider.address.localidade;
      _streetController.text = productProvider.address.logradouro;
      _numberController.text = productProvider.address.numero.toString();
      _districtController.text = productProvider.address.bairro;
      _complementController.text = productProvider.address.complemento;
      _observationsController.text = productProvider.observations;
    }*/
    super.initState();
  }

  _addUpdate() async {
    /*
    final Address address = Address(
        bairro: _districtController.text,
        cep: _cepController.text,
        complemento: _complementController.text,
        localidade: _cityController.text,
        logradouro: _streetController.text,
        numero: _numberController.text,
        uf: _ufController.text);
    final ProductProvider productProvider = ProductProvider(
        name: _providerNameController.text,
        document: _cpfCnpjController.text,
        phoneNumber1: _phoneNumberController1.text,
        phoneNumber2: _phoneNumberController2.text,
        address: address,
        email: _emailController.text,
        observations: _observationsController.text);
    if (widget.isUpdate) {
      await _productProviderBox.delete(keyToDelete);
    }
    if (_productProviderBox.containsKey(_cpfCnpjController.text)) {
      showGeneralDialogErrorMessage('Este CNPJ já foi cadastrado!', context);
    } else {
      await _productProviderBox.put(_cpfCnpjController.text, productProvider);
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
      _focusNode.requestFocus();
    } catch (e) {
      Navigator.pop(context);
      showGeneralDialogErrorMessage('Erro: $e', context);
    }
  }

  @override
  void dispose() {
    // _focusNode.dispose();
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
          backgroundColor: carribeanGreen,
          appBar: CustomAppBar(
              callback: () async => showGeneralConfirmationExitDialog(context),
              heroAnimation: '',
              svgImage: kpathSvgFactory,
              title: 'Cadastrar Fornecedor',
              backgroundColor: carribeanGreen),
          body: Container(
            color: carribeanGreen,
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: ListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                            onTap: () {
                              Navigator.pop(context);
                            })),
                    Spacer(flex: 1),
                    Expanded(
                        flex: 4,
                        child: CustomButtonConfirm(
                            text: 'Salvar', onTap: () => _addUpdate()))
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
