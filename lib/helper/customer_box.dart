import 'package:easy_manager/models/customer_model.dart';
import 'package:easy_manager/objectbox.g.dart';

class CustomerBox {
  late final Store _store;
  late final Box<Customer> _customerBox;

  CustomerBox._init(this._store) {
    _customerBox = Box<Customer>(_store);
  }

  static Future<CustomerBox> init() async {
    final store = await openStore();
    if (Sync.isAvailable()) {
      final syncClient =
          Sync.client(store, 'ws://0.0.0.0:9999', SyncCredentials.none());
      syncClient.start();
    }

    return CustomerBox._init(store);
  }

  Stream<List<Customer>> getCustomers() => _customerBox
      .query()
      .watch(triggerImmediately: true)
      .map((query) => query.find());
  Customer? getCustomer(int id) => _customerBox.get(id);
  int insertCustomer(Customer customer) => _customerBox.put(customer);
  bool deleteCustomer(int id) => _customerBox.remove(id);
  int clearAllCustomers() => _customerBox.removeAll();
}
