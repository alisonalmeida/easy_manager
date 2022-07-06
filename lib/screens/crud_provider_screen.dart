// ignore_for_file: prefer_const_constructors

import 'package:easy_manager/custom_widgets/button_round_with_shadow.dart';
import 'package:easy_manager/custom_widgets/custom_app_bar.dart';
import 'package:easy_manager/custom_widgets/custom_button_confirm.dart';
import 'package:easy_manager/custom_widgets/custom_text_field.dart';
import 'package:easy_manager/models/address_model.dart';
import 'package:easy_manager/models/product_model.dart';
import 'package:easy_manager/models/product_provider_model.dart';
import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';

class CrudProviderScreen extends StatefulWidget {
  const CrudProviderScreen({Key? key}) : super(key: key);

  @override
  State<CrudProviderScreen> createState() => _CrudProviderScreenState();
}

class _CrudProviderScreenState extends State<CrudProviderScreen> {
  final _productNameController = TextEditingController();
  final _productCodeController = TextEditingController();
  final _productProviderController = TextEditingController();
  final _productBrandController = TextEditingController();
  final _productCategoryController = TextEditingController();
  final _unitMeasurementController = TextEditingController();
  final _costValueController = TextEditingController();
  final _saleValueController = TextEditingController();

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
                controller: _productCodeController,
                name: 'Código',
                textInputAction: TextInputAction.next),
            SizedBox(height: 5),
            CustomTextField(
                controller: _productNameController,
                name: 'Nome do Produto',
                textInputAction: TextInputAction.next),
            SizedBox(height: 5),
            CustomTextField(
                controller: _productProviderController,
                name: 'Fornecedor',
                textInputAction: TextInputAction.next),
            SizedBox(height: 5),
            CustomTextField(
                controller: _productBrandController,
                name: 'Marca',
                textInputAction: TextInputAction.next),
            SizedBox(height: 5),
            CustomTextField(
                controller: _productCategoryController,
                name: 'Categoria',
                textInputAction: TextInputAction.next),
            SizedBox(height: 5),
            CustomTextField(
                controller: _unitMeasurementController,
                name: 'Unidade de Medição',
                textInputAction: TextInputAction.next),
            SizedBox(height: 5),
            CustomTextField(
                controller: _costValueController,
                name: 'Valor de Custo',
                textInputAction: TextInputAction.next),
            SizedBox(height: 5),
            CustomTextField(
                controller: _saleValueController,
                name: 'Valor de Venda',
                textInputAction: TextInputAction.next),
            SizedBox(height: 40),
            CursomButtonConfirm(text: 'Salvar', onTap: () {}),
          ],
        ),
      ),
    );
  }
}
