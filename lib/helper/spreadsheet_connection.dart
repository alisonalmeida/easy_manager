import 'package:easy_manager/credentials.dart';
import 'package:easy_manager/helper/world_time.dart';
import 'package:easy_manager/models/customer_model.dart';
import 'package:easy_manager/models/product_provider_model.dart';
import 'package:gsheets/gsheets.dart';

class GSheetDb {
  late final GSheets gSheets;
  late final Spreadsheet ss;
  final int _delaySecondsUpdate = 2;
  final String _usersSheetTitle = 'usuarios';
  final String _providersSheetTitle = 'fornecedores';
  final String _customersSheetTitle = 'clientes';

  GSheetDb() {
    gSheets = GSheets(credential);
  }

  Future init() async {
    ss = await gSheets.spreadsheet(spreadsheetId);
  }

//USERS
  Future<List<Map<String, String>>>? getUsers() async {
    Worksheet? sheet = ss.worksheetByTitle(_usersSheetTitle);
    var users = await sheet!.values.map.allRows();
    return users!;
  }

//PROVIDERS
  Future putProvider(ProductProvider productProvider) async {
    Worksheet? sheet = ss.worksheetByTitle(_providersSheetTitle);

    if (productProvider.id!.isEmpty) {
      String newId = await WorldTime.getDateFormatted();
      await sheet!.values.appendRow([
        newId,
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
    } else {
      var list = await sheet!.values.map.allRows();

      for (var i = 0; i < list!.toList().length; i++) {
        ProductProvider testeProvider =
            ProductProvider.fromMap(list.toList()[i]);

        if (testeProvider.id == productProvider.id) {
          await sheet.deleteRow(i + 2);

          await sheet.values.appendRow([
            productProvider.id,
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
          break;
        }
      }
    }
  }

  Stream<List<Map<String, String>>?> getAllProviders() async* {
    Worksheet? sheet = ss.worksheetByTitle(_providersSheetTitle);
    while (true) {
      await Future.delayed(Duration(seconds: _delaySecondsUpdate));
      Stream<List<Map<String, String>>?> providers =
          sheet!.values.map.allRows().asStream();
      yield* providers;
    }
  }

  deleteProvider(String id) async {
    Worksheet? sheet = ss.worksheetByTitle(_providersSheetTitle);
    var list = await sheet!.values.map.allRows();

    for (var i = 0; i < list!.toList().length; i++) {
      if (list.toList()[i]['id'] == id) {
        await sheet.deleteRow(i + 2);
        break;
      }
    }
  }

  Future<ProductProvider?> getProvider(String id) async {
    Worksheet? sheet = ss.worksheetByTitle(_providersSheetTitle);
    var list = await sheet!.values.map.allRows();

    for (var i = 0; i < list!.toList().length; i++) {
      if (list.toList()[i]['id'] == id) {
        ProductProvider productProvider = ProductProvider(
          id: list.toList()[i]['id'],
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

  //CUSTOMERS

  Future putCustomer(Customer customer) async {
    Worksheet? sheet = ss.worksheetByTitle(_customersSheetTitle);

    if (customer.id!.isEmpty) {
      String newId = await WorldTime.getDateFormatted();
      await sheet!.values.appendRow([
        newId,
        customer.nome,
        customer.documento,
        customer.telefone1,
        customer.telefone2,
        customer.email,
        customer.cep,
        customer.uf,
        customer.localidade,
        customer.logradouro,
        customer.bairro,
        customer.numero,
        customer.complemento,
        customer.observacoes
      ]);
    } else {
      var list = await sheet!.values.map.allRows();

      for (var i = 0; i < list!.toList().length; i++) {
        Customer testCustomer = Customer.fromMap(list.toList()[i]);

        if (testCustomer.id == customer.id) {
          await sheet.deleteRow(i + 2);

          await sheet.values.appendRow([
            customer.id,
            customer.nome,
            customer.documento,
            customer.telefone1,
            customer.telefone2,
            customer.email,
            customer.cep,
            customer.uf,
            customer.localidade,
            customer.logradouro,
            customer.bairro,
            customer.numero,
            customer.complemento,
            customer.observacoes
          ]);
          break;
        }
      }
    }
  }

  Stream<List<Map<String, String>>?> getAllCustomers() async* {
    Worksheet? sheet = ss.worksheetByTitle(_customersSheetTitle);
    while (true) {
      await Future.delayed(Duration(seconds: _delaySecondsUpdate));
      Stream<List<Map<String, String>>?> customers =
          sheet!.values.map.allRows().asStream();
      yield* customers;
    }
  }

  deleteCustomer(String id) async {
    Worksheet? sheet = ss.worksheetByTitle(_customersSheetTitle);
    var list = await sheet!.values.map.allRows();

    for (var i = 0; i < list!.toList().length; i++) {
      if (list.toList()[i]['id'] == id) {
        await sheet.deleteRow(i + 2);
        break;
      }
    }
  }

  Future<Customer?> getCustomer(String id) async {
    Worksheet? sheet = ss.worksheetByTitle(_customersSheetTitle);
    var list = await sheet!.values.map.allRows();

    for (var i = 0; i < list!.toList().length; i++) {
      if (list.toList()[i]['id'] == id) {
        Customer customer = Customer(
          id: list.toList()[i]['id'],
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
        return customer;
      }
    }
    return null;
  }
}
