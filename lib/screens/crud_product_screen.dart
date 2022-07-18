// ignore_for_file: prefer_const_constructors

import 'package:easy_manager/consts.dart';

import 'package:easy_manager/custom_widgets/button_round_with_shadow.dart';
import 'package:easy_manager/custom_widgets/custom_app_bar.dart';
import 'package:easy_manager/custom_widgets/custom_button_cancel.dart';
import 'package:easy_manager/custom_widgets/custom_button_confirm.dart';
import 'package:easy_manager/custom_widgets/custom_text_field.dart';
import 'package:easy_manager/custom_widgets/custom_text_field_with_data.dart';
import 'package:easy_manager/main.dart';
import 'package:easy_manager/models/product_model.dart';

import 'package:easy_manager/screens/crud_provider_screen.dart';
import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    if (widget.productkey != null) {
      final Product product = companyDB.getProduct(widget.productkey!)!;

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
        costValue: double.parse(_costValueController.text),
        saleValue: double.parse(_saleValueController.text),
        minQuantity: int.parse(_minQuantityController.text),
        description: _descriptionController.text);

    companyDB.insertProduct(product);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pastelPink,
      /**appBar: CustomAppBar(
        backgroundColor: pastelPink,
        title: 'Cadastrar Produto',
      ), */
      body: Container(
        color: pastelPink,
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                    iconPath: kpathSvgShuffle,
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
                  child: CustomTextFieldWithData(
                    controller: _productProviderController,
                    name: 'Fornecedor',
                    items: Expanded(
                        child: Text(
                            'data') /**ShowListItemsProductProvider(
                            box: _providerBox,
                            type: ProductProvider,
                            callback: (v) {
                              ProductProvider productProvider =
                                  _providerBox.get(v);
                              _productProviderController.text =
                                  productProvider.name;
                              choosedDocument = productProvider.document;
                            }) */
                        ),
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
                            builder: (context) =>
                                CrudProviderScreen(isUpdate: false))))
              ],
            ),
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
                controller: _minQuantityController,
                name: 'Quantidade Mínima',
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
            SizedBox(height: 5),
            CustomTextField(
                maxLines: 5,
                minLines: 2,
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
                        onTap: () {
                          Navigator.pop(context);
                        })),
                Spacer(flex: 1),
                Expanded(
                    flex: 4,
                    child: CustomButtonConfirm(
                        text: 'Salvar', onTap: () async => _saveUpdate()))
              ],
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
