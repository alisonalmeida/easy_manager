// ignore_for_file: prefer_const_constructors

import 'package:easy_manager/consts.dart';
import 'package:easy_manager/custom_widgets/button_round_with_shadow.dart';
import 'package:easy_manager/custom_widgets/custom_app_bar.dart';
import 'package:easy_manager/custom_widgets/custom_button_confirm.dart';
import 'package:easy_manager/custom_widgets/custom_text_field.dart';
import 'package:easy_manager/models/address_model.dart';
import 'package:easy_manager/models/product_model.dart';
import 'package:easy_manager/models/product_provider_model.dart';
import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class CrudProductScreen extends StatefulWidget {
  const CrudProductScreen({Key? key}) : super(key: key);

  @override
  State<CrudProductScreen> createState() => _CrudProductScreenState();
}

class _CrudProductScreenState extends State<CrudProductScreen> {
  late Box _productBox;

  final _productNameController = TextEditingController();
  final _productCodeController = TextEditingController();
  final _productProviderController = TextEditingController();
  final _productBrandController = TextEditingController();
  final _productCategoryController = TextEditingController();
  final _unitMeasurementController = TextEditingController();
  final _costValueController = TextEditingController();
  final _saleValueController = TextEditingController();

  @override
  void initState() {
    _openBoxes();
    super.initState();
  }

  _saveProduct() async {}

  _openBoxes() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pastelPink,
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
                        'Cadastrar Produto',
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
        color: pastelPink,
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: [
            SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                      prefixIcon:
                          GestureDetector(child: Icon(Icons.qr_code_scanner)),
                      controller: _productCodeController,
                      name: 'Código',
                      textInputAction: TextInputAction.next),
                ),
                ButtonRoundWithShadow(
                    borderColor: black,
                    shadowColor: black,
                    color: white,
                    iconPath: 'lib/assets/svg/shuffle.svg',
                    size: 50,
                    callback: () {
                      //TODO random number based key box
                    })
              ],
            ),
            SizedBox(height: 5),
            CustomTextField(
                controller: _productNameController,
                name: 'Nome do Produto',
                textInputAction: TextInputAction.next),
            SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                      controller: _productProviderController,
                      name: 'Fornecedor',
                      textInputAction: TextInputAction.next),
                ),
                ButtonRoundWithShadow(
                    borderColor: black,
                    shadowColor: black,
                    color: white,
                    iconPath: 'lib/assets/svg/plus.svg',
                    size: 50,
                    callback: () {})
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                      controller: _productBrandController,
                      name: 'Marca',
                      textInputAction: TextInputAction.next),
                ),
                ButtonRoundWithShadow(
                    borderColor: black,
                    shadowColor: black,
                    color: white,
                    iconPath: 'lib/assets/svg/plus.svg',
                    size: 50,
                    callback: () {})
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                      controller: _productCategoryController,
                      name: 'Categoria',
                      textInputAction: TextInputAction.next),
                ),
                ButtonRoundWithShadow(
                    borderColor: black,
                    shadowColor: black,
                    color: white,
                    iconPath: 'lib/assets/svg/plus.svg',
                    size: 50,
                    callback: () {})
              ],
            ),
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
            CustomButtonConfirm(text: 'Salvar', onTap: () => _saveProduct()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        var v = _productBox.values.first as Product;
        print(v.brand);
      }),
    );
  }
}
