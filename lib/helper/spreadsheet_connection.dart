import 'package:easy_manager/credentials.dart';
import 'package:easy_manager/models/product_provider_model.dart';
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

  Future addProvider(ProductProvider productProvider) async {
    Worksheet? sheet = ss.worksheetByTitle('fornecedores');
    await sheet!.values.appendRow([
      productProvider.nome,
      productProvider.documento,
      productProvider.telefone1,
      productProvider.telefone2,
      productProvider.email,
      productProvider.cep,
      productProvider.uf,
      productProvider.localidade,
      productProvider.logradouro,
      productProvider.bairro,
      productProvider.numero,
      productProvider.complemento,
      productProvider.observacoes
    ]);
  }

  Future updateProvider(ProductProvider productProvider) async {
    Worksheet? sheet = ss.worksheetByTitle('fornecedores');

    var list = await sheet!.values.map.allRows();
    for (var i = 0; i < list!.toList().length; i++) {
      ProductProvider newProvider = ProductProvider.fromMap(list.toList()[i]);

      if (newProvider.documento == productProvider.documento) {
        
        await sheet.values.insertRow(i + 2, [
          newProvider.nome,
          newProvider.documento,
          newProvider.telefone1,
          newProvider.telefone2,
          newProvider.email,
          newProvider.cep,
          newProvider.uf,
          newProvider.localidade,
          newProvider.logradouro,
          newProvider.bairro,
          newProvider.numero,
          newProvider.complemento,
          newProvider.observacoes
        ]);
        break;
      }
    }
  }

  Stream<List<Map<String, String>>?> getAllProviders() async* {
    Worksheet? sheet = ss.worksheetByTitle('fornecedores');
    while (true) {
      await Future.delayed(const Duration(seconds: 3));
      Stream<List<Map<String, String>>?> providers =
          sheet!.values.map.allRows().asStream();
      yield* providers;
    }
  }

  deleteProvider(String document) async {
    Worksheet? sheet = ss.worksheetByTitle('fornecedores');
    var list = await sheet!.values.map.allRows();

    for (var i = 0; i < list!.toList().length; i++) {
      if (list.toList()[i]['documento'] == document) {
        await sheet.clearRow(i + 2);
        await sheet.deleteRow(i + 2);
        break;
      }
    }
  }

  Future<ProductProvider?> getProvider(String document) async {
    Worksheet? sheet = ss.worksheetByTitle('fornecedores');
    var list = await sheet!.values.map.allRows();

    for (var i = 0; i < list!.toList().length; i++) {
      if (list.toList()[i]['documento'] == document) {
        ProductProvider productProvider = ProductProvider(
          nome: list.toList()[i]['nome'],
          documento: list.toList()[i]['documento'],
          telefone1: list.toList()[i]['telefone1'],
          telefone2: list.toList()[i]['telefone2'],
          email: list.toList()[i]['email'],
          cep: list.toList()[i]['cep'],
          uf: list.toList()[i]['uf'],
          localidade: list.toList()[i]['localidade'],
          logradouro: list.toList()[i]['logradouro'],
          bairro: list.toList()[i]['bairro'],
          numero: list.toList()[i]['numero'],
          complemento: list.toList()[i]['complemento'],
          observacoes: list.toList()[i]['observacoes'],
        );
        return productProvider;
      }
    }
    return null;
  }
}
