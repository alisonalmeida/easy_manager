// ignore_for_file: prefer_const_constructors

import 'package:easy_manager/core/database_connection.dart';
import 'package:easy_manager/models/address_model.dart';
import 'package:easy_manager/models/product_model.dart';
import 'package:easy_manager/models/product_provider_model.dart';
import 'package:flutter/material.dart';

class CrudProductScreen extends StatefulWidget {
  const CrudProductScreen({Key? key}) : super(key: key);

  @override
  State<CrudProductScreen> createState() => _CrudProductScreenState();
}

class _CrudProductScreenState extends State<CrudProductScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nome do Produto',
                    hintText: 'Ex. Laço'),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Código',
                    hintText: 'Código'),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Fornecedor',
                    hintText: 'Fornecedor'),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Marca',
                    hintText: 'Marca'),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Categoria',
                    hintText: 'Categoria'),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Unidade de Medição',
                    hintText: 'Unidade de Medição'),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Valor de Custo',
                    hintText: 'Valor de Custo'),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Valor de Venda',
                    hintText: 'Valor de Venda'),
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: ElevatedButton(
                    onPressed: () {
                      List<String> _phoneList = [];
                      Address _address = Address(
                          id: '',
                          cep: 'cep',
                          logradouro: 'logradouro',
                          complemento: 'complemento',
                          bairro: 'bairro',
                          localidade: 'localidade',
                          uf: 'uf',
                          numero: 'numero');
                      ProductProvider _productProvider = ProductProvider(
                          name: 'name',
                          document: 'document',
                          phoneList: _phoneList,
                          address: _address,
                          email: 'email',
                          observations: 'observations');
                      Product _product = Product(
                          name: 'name',
                          cod: 'cod',
                          productProvider: _productProvider,
                          costValue: 1,
                          saleValue: 1,
                          brand: 'brand',
                          categoryName: 'categoryName',
                          unitMeasurement: 'unitMeasurement');
                    },
                    child: Text('Salvar')))
          ],
        ),
      ),
    );
  }
}
