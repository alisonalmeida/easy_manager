import 'package:easy_manager/models/customer_model.dart';
import 'package:easy_manager/models/product_model.dart';
import 'package:easy_manager/models/product_provider_model.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
@Sync()
class CompanyModel {
  int id;

  @Backlink()
  final costumers = ToMany<Customer>();

  @Backlink()
  final products = ToMany<Product>();

  @Backlink()
  final providers = ToMany<ProductProvider>();

  CompanyModel({this.id = 0});
}
