import 'package:easy_manager/models/customer_model.dart';
import 'package:easy_manager/models/product_model.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
@Sync()
class CompanyModel {
  int id;

  @Backlink()
  final costumers = ToMany<CustomerModel>();

  @Backlink()
  final products = ToMany<Product>();

  CompanyModel({this.id = 0});

  void addCustomer(CustomerModel customer) {
    customer = CustomerModel(name: 'NAMEEEEE');
    costumers.add(customer);
  }

  void deleteCustomer() {}
  void updateCustomer() {}
}
