import 'package:easy_manager/models/customer_model.dart';
import 'package:easy_manager/models/product_model.dart';
import 'package:path_provider/path_provider.dart';
import '../objectbox.g.dart';

class ObjectBox {
  late final Store _store;
  late final Box<CustomerModel> _customerBox;
  late final Box<Product> _productBox;

  ObjectBox._init(this._store) {
    _customerBox = Box<CustomerModel>(_store);
    _productBox = Box<Product>(_store);
  }

  static Future<ObjectBox> init() async {
    final store = await openStore();
    if (Sync.isAvailable()) {
      final syncClient =
          Sync.client(store, 'ws://10.0.2.2:9999', SyncCredentials.none());
      syncClient.start();
    }

    return ObjectBox._init(store);
  }

  CustomerModel? getCustomer(int id) => _customerBox.get(id);
  int insertCustomer(CustomerModel customer) => _customerBox.put(customer);
  bool deleteCustomer(int id) => _customerBox.remove(id);

  Stream<List<CustomerModel>> getCustomers() => _customerBox
      .query()
      .watch(triggerImmediately: true)
      .map((event) => event.find());

  Product? getProduct(int id) => _productBox.get(id);
  int insertProduct(Product product) => _productBox.put(product);
  bool deleteProduct(int id) => _productBox.remove(id);

  Stream<List<Product>> getProducts() => _productBox
      .query()
      .watch(triggerImmediately: true)
      .map((event) => event.find());
}
