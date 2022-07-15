


/**import 'package:easy_manager/models/customer_model.dart';
import 'package:objectbox/objectbox.dart';

class CustomerBox {
  late final Store _store;
  late final Box<CustomerModel> _customerBox;

  CustomerBox._init(this._store) {
    _customerBox = Box<CustomerModel>(_store);
  }

  static Future<CustomerBox> init() async {
    final store = await openStore();
    if (Sync.isAvailable()) {
      final syncClient = //'ws://0.0.0.0:9999'
          Sync.client(store, '', SyncCredentials.none());
      syncClient.start();
    }

    return CustomerBox._init(store);
  }

  Stream<List<CustomerModel>> getCustomers() => _customerBox
      .query()
      .watch(triggerImmediately: true)
      .map((query) => query.find());
  CustomerModel? getCustomer(int id) => _customerBox.get(id);
  int insertCustomer(CustomerModel customer) => _customerBox.put(customer);
  bool deleteCustomer(int id) => _customerBox.remove(id);
  int clearAllCustomers() => _customerBox.removeAll();
}
 */