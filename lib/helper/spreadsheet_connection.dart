import 'package:easy_manager/credentials.dart';
import 'package:easy_manager/models/budget.dart';
import 'package:easy_manager/models/customer_model.dart';
import 'package:easy_manager/models/product.dart';
import 'package:easy_manager/models/product_provider_model.dart';
import 'package:gsheets/gsheets.dart';
import 'package:intl/intl.dart';

class GSheetDb {
  late final GSheets gSheets;
  late final Spreadsheet ss;

  final String _usersSheetTitle = 'usuarios';
  final String _providersSheetTitle = 'fornecedores';
  final String _customersSheetTitle = 'clientes';
  final String _productsSheetTitle = 'produtos';
  final String _budgetsSheetTitle = 'orçamentos';

  GSheetDb() {
    gSheets = GSheets(credential);
  }

  Future init() async {
    ss = await gSheets.spreadsheet(spreadsheetId);
  }

//USERS
  Future<List<Map<String, String>>> getUsers() async {
    Worksheet? sheet = ss.worksheetByTitle(_usersSheetTitle);
    var users = await sheet!.values.map.allRows();
    return users ?? [];
  }

//PROVIDERS
  Future putProvider(ProductProvider productProvider) async {
    Worksheet? sheet = ss.worksheetByTitle(_providersSheetTitle);

    if (productProvider.id!.isEmpty) {
      final DateTime now = DateTime.now();
      String newId = DateFormat('yyyyMMddhhmms').format(now);

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
          await sheet.clearRow(i + 2);

          await sheet.values.insertRow(i + 2, [
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

  Future<List<Map<String, String>>> getProviders() async {
    Worksheet? sheet = ss.worksheetByTitle(_providersSheetTitle);
    var providers = await sheet!.values.map.allRows();
    return providers ?? [];
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
        ProductProvider productProvider =
            ProductProvider.fromMap(list.toList()[i]);
        return productProvider;
      }
    }
    return null;
  }

  //CUSTOMERS

  Future putCustomer(Customer customer) async {
    Worksheet? sheet = ss.worksheetByTitle(_customersSheetTitle);

    if (customer.id!.isEmpty) {
      final DateTime now = DateTime.now();
      String newId = DateFormat('yyyyMMddhhmms').format(now);
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
          await sheet.clearRow(i + 2);

          await sheet.values.insertRow(i + 2, [
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

  Future<List<Map<String, String>>> getCustomers() async {
    Worksheet? sheet = ss.worksheetByTitle(_customersSheetTitle);
    var customers = await sheet!.values.map.allRows();
    return customers ?? [];
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
        Customer customer = Customer.fromMap(list.toList()[i]);
        return customer;
      }
    }
    return null;
  }

//PRODUCTS
  Future<List<Map<String, String>>> getProducts() async {
    Worksheet? sheet = ss.worksheetByTitle(_productsSheetTitle);
    var products = await sheet!.values.map.allRows();
    return products ?? [];
  }

  Future putProduct(Product product) async {
    Worksheet? sheet = ss.worksheetByTitle(_productsSheetTitle);

    if (product.id!.isEmpty) {
      final DateTime now = DateTime.now();
      String newId = DateFormat('yyyyMMddhhmms').format(now);
      await sheet!.values.appendRow([
        newId,
        product.codigo,
        product.nome,
        product.fornecedorDocumento,
        product.valorCusto,
        product.valorVenda,
        product.marca,
        product.categoria,
        product.unidadeMedida,
        product.quantidadeMinima,
        product.descricao,
      ]);
    } else {
      var list = await sheet!.values.map.allRows();

      for (var i = 0; i < list!.toList().length; i++) {
        Product testProduct = Product.fromJson(list.toList()[i]);

        if (testProduct.id == product.id) {
          await sheet.clearRow(i + 2);

          await sheet.values.insertRow(i + 2, [
            product.id,
            product.codigo,
            product.nome,
            product.fornecedorDocumento,
            product.valorCusto,
            product.valorVenda,
            product.marca,
            product.categoria,
            product.unidadeMedida,
            product.quantidadeMinima,
            product.descricao,
          ]);
          break;
        }
      }
    }
  }

  deleteProduct(String id) async {
    Worksheet? sheet = ss.worksheetByTitle(_productsSheetTitle);
    var list = await sheet!.values.map.allRows();

    for (var i = 0; i < list!.toList().length; i++) {
      if (list.toList()[i]['id'] == id) {
        await sheet.deleteRow(i + 2);

        break;
      }
    }
  }

  Future<Product?> getProduct(String id) async {
    Worksheet? sheet = ss.worksheetByTitle(_productsSheetTitle);
    var list = await sheet!.values.map.allRows();

    for (var i = 0; i < list!.toList().length; i++) {
      if (list.toList()[i]['id'] == id) {
        Product product = Product.fromJson(list.toList()[i]);
        return product;
      }
    }
    return null;
  }

  //BUDGETS

  Future<List<Map<String, String>>> getBudgets() async {
    Worksheet? sheet = ss.worksheetByTitle(_budgetsSheetTitle);
    var budgets = await sheet!.values.map.allRows();
    return budgets ?? [];
  }

  Future putBudget(Budget budget) async {
    Worksheet? sheet = ss.worksheetByTitle(_budgetsSheetTitle);
    budget.id ??= '';
    if (budget.id!.isNotEmpty) {
      var list = await sheet!.values.map.allRows();

      for (var i = 0; i < list!.toList().length; i++) {
        Budget testBudget = Budget.fromJson(list.toList()[i]);

        if (testBudget.id == budget.id) {
          await sheet.clearRow(i + 2);
          List<String> list = [];
          for (var item in budget.itens!) {
            list.add(
                '''{"idProduct":${item.idProduct},"produtoNome":${item.produtoNome},"produtoValor":${item.produtoValor},"quantidade":${item.quantidade}''');
            list.last += "}";
          }

          await sheet.values.insertRow(i + 2, [
            testBudget.id,
            budget.nomeCliente,
            budget.data,
            budget.itens!.isEmpty ? "[]" : "$list",
            budget.valorTotal,
            budget.status,
          ]);
          return testBudget.id;
        }
      }
    } else {
      final DateTime now = DateTime.now();
      String newId = DateFormat('yyyyMMddhhmms').format(now);
      await sheet!.values.appendRow([
        newId,
        budget.nomeCliente,
        budget.data,
        "[]",
        budget.valorTotal,
        budget.status,
      ]);

      return newId;
    }
  }

  deleteBudget(String id) async {
    Worksheet? sheet = ss.worksheetByTitle(_budgetsSheetTitle);
    var list = await sheet!.values.map.allRows();

    for (var i = 0; i < list!.toList().length; i++) {
      if (list.toList()[i]['id'] == id) {
        await sheet.deleteRow(i + 2);
        break;
      }
    }
  }

  Future<Budget?> getBudget(String id) async {
    Worksheet? sheet = ss.worksheetByTitle(_budgetsSheetTitle);
    var list = await sheet!.values.map.allRows();

    for (var i = 0; i < list!.toList().length; i++) {
      if (list.toList()[i]['id'] == id) {
        Budget budget = Budget.fromJson(list.toList()[i]);
        return budget;
      }
    }
    return null;
  }
}
