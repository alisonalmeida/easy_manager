import 'package:easy_manager/models/customer_model.dart';
import 'package:easy_manager/objectbox.g.dart';

class ObjectBox {
  late final Store _store;
  late final Box<Customer> _customerBox;

  ObjectBox._init(this._store) {
    _customerBox = Box<Customer>(_store);
  }

  static Future<ObjectBox> init() async {
    final store = await openStore();
    return ObjectBox._init(store);
  }

  Stream<List<Customer>> getCustomers() => _customerBox
      .query()
      .watch(triggerImmediately: true)
      .map((query) => query.find());
  Customer? getCustomer(int id) => _customerBox.get(id);
  int insertCustomer(Customer customer) => _customerBox.put(customer);
  bool deleteCustomer(int id) => _customerBox.remove(id);
}
