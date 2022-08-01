// ignore_for_file: prefer_const_constructors, sort_child_properties_last

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
import 'package:easy_manager/screens/qr_Scan_screen.dart';
import 'package:easy_manager/utils/colors.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../core/upper_case_text_formatter.dart';
import '../models/product_provider_model.dart';

class CrudProductScreen extends StatefulWidget {
  const CrudProductScreen({Key? key, this.productkey}) : super(key: key);
  final int? productkey;

  @override
  State<CrudProductScreen> createState() => _CrudProductScreenState();
}

class _CrudProductScreenState extends State<CrudProductScreen> {
  final _qrController = TextEditingController();
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
  final Map<String, bool> _checkTextFields = {
    'Código': false,
    'Fornecedor': false,
    'Quantidade Mínima': false,
    'Valor de Custo': false,
    'Valor de Venda': false
  };
  final formKey = GlobalKey<FormState>();
  late Stream<List<ProductProvider>> streamProviders;

  @override
  void initState() {
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
        costValue: double.parse(
            _costValueController.text.replaceAll(RegExp(r'[^0-9\.]'), '')),
        saleValue: double.parse(
            _saleValueController.text.replaceAll(RegExp(r'[^0-9\.]'), '')),
        minQuantity: int.parse(
            _minQuantityController.text.replaceAll(RegExp(r'[^0-9\.]'), '')),
        description: _descriptionController.text);
    if (isUpdate) {
      product.id = widget.productkey!;
    }

    if (companyBox.checkProductCode(product.cod) && !isUpdate) {
      showGeneralInformationDialogErrorMessage(
          'O código ja foi cadastrado, por favor, verifique!', context);
    } else {
      companyBox.insertProduct(product);
      Navigator.pop(context);
    }
  }

  String? validatorEmpty(String? s, String message) {
    if (s!.isEmpty) {
      return '$message não pode estar vazio';
    }

    if (_checkTextFields.keys.contains(message)) {
      _checkTextFields.update(message, (value) => value = true);
    }
    var list = [];
    _checkTextFields.forEach((key, value) {
      list.add(value);
    });
    for (var element in list) {
      if (!element) {
        isSaveButtonEnabled = false;
        break;
      }
      isSaveButtonEnabled = true;
    }

    return null;
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
    NumberFormat formatter = NumberFormat.simpleCurrency(locale: 'pt_BR');

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
                            validator: (String? s) =>
                                validatorEmpty(s, 'Código'),
                            prefixIcon: GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return QrScanPage();
                                    },
                                  ));
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
                          validator: (String? s) =>
                              validatorEmpty(s, 'Fornecedor'),
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
                      onChanged: () {
                        print(formatter.format(_minQuantityController.text
                            .replaceAll(RegExp(r'[^0-9\.]'), '')));
                      },
                      textInputType: TextInputType.number,
                      textInputFormatterList: [
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      validator: (String? s) =>
                          validatorEmpty(s, 'Quantidade Mínima'),
                      controller: _minQuantityController,
                      name: 'Quantidade Mínima',
                      textInputAction: TextInputAction.next),
                  SizedBox(height: 5),
                  CustomTextField(
                      textInputType: TextInputType.number,
                      textInputFormatterList: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      validator: (String? s) =>
                          validatorEmpty(s, 'Valor de Custo'),
                      controller: _costValueController,
                      name: 'Valor de Custo',
                      textInputAction: TextInputAction.next),
                  SizedBox(height: 5),
                  CustomTextField(
                      textInputType: TextInputType.number,
                      textInputFormatterList: [
                        FilteringTextInputFormatter.digitsOnly,
                        TextInputMask(
                            mask: ['R!\$! !999,99', 'R!\$! 999.999,99'])
                      ],
                      validator: (String? s) =>
                          validatorEmpty(s, 'Valor de Venda'),
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
