import 'package:easy_manager/models/customer_model.dart';
import 'package:easy_manager/models/product_model.dart';
import 'package:easy_manager/objectbox.g.dart';

@Entity()
@Sync()
class DbModelBox {
  int id = 0;
  String? name;

  @Backlink()
  final costumers = ToMany<CustomerModel>();

  @Backlink()
  final products = ToMany<Product>();
}
