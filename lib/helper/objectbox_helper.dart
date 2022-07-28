import 'dart:io';
import 'package:easy_manager/models/product_model.dart';
import 'package:easy_manager/models/product_provider_model.dart';
import 'package:path_provider/path_provider.dart';
import '../models/customer_model.dart';
import '../objectbox.g.dart';

class ObjectBox {
  late final Store _store;
  late final Box<Customer> _customerBox;
  late final Box<Product> _productBox;
  late final Box<ProductProvider> _providerBox;

  ObjectBox._init(this._store) {
    _customerBox = Box<Customer>(_store);
    _productBox = Box<Product>(_store);
    _providerBox = Box<ProductProvider>(_store);
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

  void close() => _store.close();
  bool isClosed() => _store.isClosed();
//Customers
  int insertCustomer(Customer customer) => _customerBox.put(customer);
  Customer? getCustomer(int id) => _customerBox.get(id);
  bool deleteCustomer(int id) => _customerBox.remove(id);

  Stream<List<Customer>> getCustomers() => _customerBox
      .query()
      .watch(triggerImmediately: true)
      .map((event) => event.find());
  bool checkCustomerCpf(String cpf) {
    for (var element in _customerBox.getAll()) {
      if (element.cpf == cpf) {
        return true;
      }
    }

    return false;
  }

//Products
  int insertProduct(Product product) => _productBox.put(product);
  Product? getProduct(int id) => _productBox.get(id);
  bool deleteProduct(int id) => _productBox.remove(id);

  Stream<List<Product>> getProducts() => _productBox
      .query()
      .watch(triggerImmediately: true)
      .map((event) => event.find());
  bool checkProductCode(String cod) {
    for (var element in _productBox.getAll()) {
      if (element.cod == cod) {
        return true;
      }
    }

    return false;
  }

//Providers
  int insertProvider(ProductProvider provider) => _providerBox.put(provider);
  ProductProvider? getProvider(int id) => _providerBox.get(id);
  bool deleteProvider(int id) => _providerBox.remove(id);

  Stream<List<ProductProvider>> getProviders() => _providerBox
      .query()
      .watch(triggerImmediately: true)
      .map((event) => event.find());

  bool checkProviderDocument(String doc) {
    for (var element in _providerBox.getAll()) {
      if (element.document == doc) {
        return true;
      }
    }

    return false;
  }
}
