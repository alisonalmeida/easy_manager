import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/company_model.dart';
import '../objectbox.g.dart';

class ObjectBox {
  late final Store _store;
  late final Box<CompanyModel> _companyModel;

  ObjectBox._init(this._store) {
    _companyModel = Box<CompanyModel>(_store);
  }

  static Future<ObjectBox> init() async {
    final String syncServerIp;

    final Directory dir = await getApplicationDocumentsDirectory();
    final store = await openStore(directory: '${dir.path}/objectbox/');

    Platform.isAndroid ? syncServerIp = '10.0.2.2' : syncServerIp = '127.0.0.1';
    if (Sync.isAvailable()) {
      final syncClient = Sync.client(
          store, 'ws://$syncServerIp/objectbox/:9999', SyncCredentials.none());
      syncClient.start();
    }

    return ObjectBox._init(store);
  }

  void close() {
    _store.close();
  }

}

/**
  Customer? getCustomer(int id) => _customerBox.get(id);
  int insertCustomer(Customer customer) => _customerBox.put(customer);
  bool deleteCustomer(int id) => _customerBox.remove(id);

  Stream<List<Customer>> getCustomers() => _customerBox
      .query()
      .watch(triggerImmediately: true)
      .map((event) => event.find());

  Product? getProduct(int id) => _productBox.get(id);
  int insertProduct(Product product) => _productBox.put(product);
  bool deleteProduct(int id) => _productBox.remove(id);

  bool containsProductCod(String string) {
    List<Product> list = _productBox.getAll();
    for (var element in list) {
      if (element.cod == string) {
        return true;
      }
    }
    return false;
  }

  Stream<List<Product>> getProducts() => _productBox
      .query()
      .watch(triggerImmediately: true)
      .map((event) => event.find()); */



