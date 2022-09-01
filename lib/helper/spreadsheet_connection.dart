import 'package:easy_manager/credentials.dart';
import 'package:easy_manager/models/product_provider_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:gsheets/gsheets.dart';

class GSheetDb {
  late final GSheets gSheets;
  late final Spreadsheet ss;
  GSheetDb() {
    gSheets = GSheets(credential);
  }

  Future init() async {
    ss = await gSheets.spreadsheet(spreadsheetId);
  }

  Future<List<Map<String, String>>>? getUsers() async {
    Worksheet? sheet = ss.worksheetByTitle('usuarios');
    var users = await sheet!.values.map.allRows();
    return users!;
  }

  Future insertProvider(ProductProvider productProvider) async {
    Worksheet? sheet = ss.worksheetByTitle('fornecedores');

    await sheet!.values.appendRow([
      productProvider.nome,
      productProvider.documento,
      productProvider.telefone1,
      productProvider.telefone2,
      productProvider.email,
      productProvider.address!.cep,
      productProvider.address!.uf,
      productProvider.address!.localidade,
      productProvider.address!.logradouro,
      productProvider.address!.bairro,
      productProvider.address!.numero,
      productProvider.address!.complemento,
      productProvider.observacoes
    ]);
  }

  Stream<List<Map<String, String>>?> getAllProviders() {
    Worksheet? sheet = ss.worksheetByTitle('fornecedores');
    var providers = sheet!.values.map.allRows().asStream(  );
    return providers;
  }
}
