// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'dart:io';

import 'package:easy_manager/consts.dart';
import 'package:easy_manager/core/generate_random_string.dart';
import 'package:easy_manager/custom_widgets/button_round_with_shadow.dart';
import 'package:easy_manager/custom_widgets/custom_app_bar.dart';
import 'package:easy_manager/custom_widgets/custom_button_cancel.dart';
import 'package:easy_manager/custom_widgets/custom_button_confirm.dart';
import 'package:easy_manager/custom_widgets/custom_modal_bottom_sheet_provider.dart';
import 'package:easy_manager/custom_widgets/custom_text_field.dart';
import 'package:easy_manager/custom_widgets/custom_text_field_with_data.dart';
import 'package:easy_manager/main.dart';
import 'package:easy_manager/models/product_model.dart';
import 'package:easy_manager/screens/crud_provider_screen.dart';
import 'package:easy_manager/screens/qr_scan_screen.dart';
import 'package:easy_manager/utils/colors.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../core/upper_case_text_formatter.dart';
import '../models/product_provider_model.dart';

class CrudProductScreen extends StatefulWidget {
  const CrudProductScreen({Key? key, this.productkey}) : super(key: key);
  final int? productkey;

  @override
  State<CrudProductScreen> createState() => _CrudProductScreenState();
}

class _CrudProductScreenState extends State<CrudProductScreen> {
  final _productCodeController = TextEditingController();
  final _productNameController = TextEditingController();
  final _productProviderController = TextEditingController();
  final _productBrandController = TextEditingController();
  final _productCategoryController = TextEditingController();
  final _unitMeasurementController = TextEditingController();
  final _minQuantityController = TextEditingController();
  final _costValueController = TextEditingController();
  final _saleValueController = TextEditingController();
  final _descriptionController = TextEditingController();
  late bool isUpdate;
  late bool isSaveButtonEnabled = false;
  final Map<String, bool> _textFields = {
    'Código': false,
    'Nome do Produto': false,
    'Fornecedor': false,
    'Quantidade Mínima': false,
    'Valor de Custo': false,
    'Valor de Venda': false
  };
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
/**
 * 
    streamProviders = companyBox.getProviders();
    isUpdate = widget.productkey == null ? false : true;
    if (isUpdate) {
      isSaveButtonEnabled = true;
      Product product = companyBox.getProduct(widget.productkey!)!;
      _productCodeController.text = product.cod;
      _productNameController.text = product.name;
      _productProviderController.text = product.productProviderDocument;
      _productCategoryController.text = product.categoryName;
      _unitMeasurementController.text = product.unitMeasurement;
      _minQuantityController.text = product.minQuantity.toString();
      _costValueController.text = product.costValue.toString();
      _saleValueController.text = product.saleValue.toString();
      _descriptionController.text = product.description;
    }
 */
    super.initState();
  }

  _saveUpdate() {
    Product product = Product(
        cod: _productCodeController.text,
        name: _productNameController.text,
        productProviderDocument: _productProviderController.text,
        brand: _productBrandController.text,
        categoryName: _productCategoryController.text,
        unitMeasurement: _unitMeasurementController.text,
        costValue: double.parse(_costValueController.text
            .replaceAll(RegExp(caseSensitive: false, r'[^0-9]\.?'), '.')),
        saleValue: double.parse(_saleValueController.text
            .replaceAll(RegExp(caseSensitive: false, r'[^0-9]\.?'), '.')),
        minQuantity: int.parse(
            _minQuantityController.text.replaceAll(RegExp(r'[^0-9]'), '')),
        description: _descriptionController.text);
    
      if (isUpdate) {
        product.id = widget.productkey!;
      }
    
/**
 * 
    if (companyBox.checkProductCode(product.cod) && !isUpdate) {
      showGeneralInformationDialogErrorMessage(
          'O código ja foi cadastrado, por favor, verifique!', context);
    } else {
      companyBox.insertProduct(product);
      Navigator.pop(context);
    }
 */
  }

  void _checkEmptyController() {
    _textFields['Código'] = _productCodeController.text.isNotEmpty;
    _textFields['Nome do Produto'] = _productNameController.text.isNotEmpty;
    _textFields['Fornecedor'] = _productProviderController.text.isNotEmpty;
    _textFields['Quantidade Mínima'] = _minQuantityController.text.isNotEmpty;
    _textFields['Valor de Custo'] = _costValueController.text.isNotEmpty;
    _textFields['Valor de Venda'] = _saleValueController.text.isNotEmpty;

    for (var value in _textFields.values.toList()) {
      if (!value) {
        setState(() => isSaveButtonEnabled = false);
        break;
      }
      setState(() => isSaveButtonEnabled = true);
    }
  }

  @override
  void dispose() {
    _productCodeController.dispose();
    _productNameController.dispose();
    _productProviderController.dispose();
    _productBrandController.dispose();
    _productCategoryController.dispose();
    _unitMeasurementController.dispose();
    _minQuantityController.dispose();
    _costValueController.dispose();
    _saleValueController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showGeneralConfirmationExitDialog(context);
        return shouldPop ?? false;
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: productBackgroundColor,
          appBar: CustomAppBar(
            heroAnimation: '',
            svgImage: kpathSvgProduct,
            callback: () async => showGeneralConfirmationExitDialog(context),
            backgroundColor: productBackgroundColor,
            title: 'Produtos',
          ),
          body: Container(
            color: productBackgroundColor,
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onChanged: () {
                _checkEmptyController();
              },
              child: ListView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                children: [
                  SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: CustomTextField(
                            isEnabled: !isUpdate,
                            prefixIcon: GestureDetector(
                                onTap: () async {
                                  if (Platform.isAndroid || Platform.isIOS) {
                                    var scannedQrCode = '';
                                    scannedQrCode = await Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => QrScanPage(),
                                    ));

                                    _productCodeController.text = scannedQrCode;
                                  } else {
                                    showGeneralInformationDialogErrorMessage(
                                        'Esse recurso funciona apenas em Android ou IOS',
                                        context);
                                  }
                                },
                                child: Icon(Icons.qr_code_scanner)),
                            controller: _productCodeController,
                            name: 'Código',
                            textInputAction: TextInputAction.next),
                      ),
                      ButtonRoundWithShadow(
                          borderColor: black,
                          shadowColor: black,
                          color: white,
                          iconPath: kpathSvgShuffle,
                          size: 50,
                          callback: () {
                            _productCodeController.text =
                                generateRandomString();
                          })
                    ],
                  ),
                  SizedBox(height: 5),
                  CustomTextField(
                      textInputFormatterList: [UpperCaseTextFormatter()],
                      textInputType: TextInputType.name,
                      controller: _productNameController,
                      name: 'Nome do Produto',
                      textInputAction: TextInputAction.next),
                  SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: CustomTextFieldWithData(
                          callback: () async => _productProviderController
                              .text = await showProviderChoiceDialog(context),
                          controller: _productProviderController,
                          name: 'Fornecedor',
                          items: Expanded(child: Text('data')),
                        ),
                      ),
                      ButtonRoundWithShadow(
                          borderColor: black,
                          shadowColor: black,
                          color: white,
                          iconPath: kpathSvgPlus,
                          size: 50,
                          callback: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CrudProviderScreen())))
                    ],
                  ),
                  SizedBox(height: 5),
                  CustomTextField(
                      textInputFormatterList: [UpperCaseTextFormatter()],
                      textInputType: TextInputType.name,
                      controller: _productBrandController,
                      name: 'Marca',
                      textInputAction: TextInputAction.next),
                  SizedBox(height: 5),
                  CustomTextField(
                      textInputFormatterList: [UpperCaseTextFormatter()],
                      textInputType: TextInputType.name,
                      controller: _productCategoryController,
                      name: 'Categoria',
                      textInputAction: TextInputAction.next),
                  SizedBox(height: 5),
                  CustomTextField(
                      textInputFormatterList: [UpperCaseTextFormatter()],
                      textInputType: TextInputType.name,
                      controller: _unitMeasurementController,
                      name: 'Unidade de Medição',
                      textInputAction: TextInputAction.next),
                  SizedBox(height: 5),
                  CustomTextField(
                      onChanged: () {},
                      textInputType: TextInputType.number,
                      textInputFormatterList: [
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      controller: _minQuantityController,
                      name: 'Quantidade Mínima',
                      textInputAction: TextInputAction.next),
                  SizedBox(height: 5),
                  CustomTextField(
                      textInputType: TextInputType.number,
                      textInputFormatterList: [
                        FilteringTextInputFormatter.digitsOnly,
                        TextInputMask(
                          mask: '9+,99',
                          placeholder: '0',
                          maxPlaceHolders: 3,
                          reverse: true,
                        )
                      ],
                      prefix: Text('R\$ '),
                      controller: _costValueController,
                      name: 'Valor de Custo',
                      textInputAction: TextInputAction.next),
                  SizedBox(height: 5),
                  CustomTextField(
                      textInputFormatterList: [
                        FilteringTextInputFormatter.digitsOnly,
                        TextInputMask(
                          mask: '9+,99',
                          placeholder: '0',
                          maxPlaceHolders: 3,
                          reverse: true,
                        )
                      ],
                      prefix: Text('R\$ '),
                      textInputType:
                          TextInputType.numberWithOptions(decimal: true),
                      controller: _saleValueController,
                      name: 'Valor de Venda',
                      textInputAction: TextInputAction.next),
                  SizedBox(height: 5),
                  CustomTextField(
                      minLines: 3,
                      maxLines: 6,
                      textInputFormatterList: [UpperCaseTextFormatter()],
                      controller: _descriptionController,
                      name: 'Descrição',
                      textInputAction: TextInputAction.next),
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
                              isEnabled: isSaveButtonEnabled,
                              text: 'Salvar',
                              onTap: isSaveButtonEnabled
                                  ? _saveUpdate
                                  : () {
                                      showGeneralInformationDialogErrorMessage(
                                          'Voce precisa preencher todos os campos obrigatórios!',
                                          context);
                                    }))
                    ],
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
