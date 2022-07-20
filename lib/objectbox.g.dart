// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_sync_flutter_libs/objectbox_sync_flutter_libs.dart';

import 'models/company_model.dart';
import 'models/customer_model.dart';
import 'models/product_model.dart';
import 'models/product_provider_model.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 7712454605906709043),
      name: 'CompanyModel',
      lastPropertyId: const IdUid(1, 4837122769183608203),
      flags: 2,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 4837122769183608203),
            name: 'id',
            type: 6,
            flags: 1)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[
        ModelBacklink(name: 'costumers', srcEntity: 'Customer', srcField: ''),
        ModelBacklink(name: 'products', srcEntity: 'Product', srcField: ''),
        ModelBacklink(
            name: 'providers', srcEntity: 'ProductProvider', srcField: '')
      ]),
  ModelEntity(
      id: const IdUid(2, 6947127485198892695),
      name: 'Customer',
      lastPropertyId: const IdUid(9, 6065652611473973595),
      flags: 2,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 7346815422642481421),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 5324133215930219323),
            name: 'name',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 6452756757136246026),
            name: 'cpf',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 766440764905954235),
            name: 'address',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 7356282252130642130),
            name: 'phoneNumber1',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 4918862023564284088),
            name: 'phoneNumber2',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 2826986636815428162),
            name: 'email',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(8, 5534679181252480553),
            name: 'observations',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(9, 6065652611473973595),
            name: 'dbModelId',
            type: 11,
            flags: 520,
            indexId: const IdUid(1, 3535543309078817657),
            relationTarget: 'CompanyModel')
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(3, 1417331802748432418),
      name: 'Product',
      lastPropertyId: const IdUid(12, 4673239780333028483),
      flags: 2,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 7519202524191541135),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 6194347705255070070),
            name: 'name',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 3068049518020053347),
            name: 'cod',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 5150336504733884372),
            name: 'productProviderDocument',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 4844834368023320536),
            name: 'costValue',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 9087161916612931886),
            name: 'saleValue',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 8642532962182705374),
            name: 'brand',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(8, 3565917986575397784),
            name: 'categoryName',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(9, 7972479611331192358),
            name: 'unitMeasurement',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(10, 7813980687870392854),
            name: 'minQuantity',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(11, 4424963682661795264),
            name: 'description',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(12, 4673239780333028483),
            name: 'dbModelId',
            type: 11,
            flags: 520,
            indexId: const IdUid(2, 704047497809199117),
            relationTarget: 'CompanyModel')
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(4, 8312430246112723313),
      name: 'ProductProvider',
      lastPropertyId: const IdUid(9, 3115366520109720853),
      flags: 2,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 6142255519184622672),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 3741500779267080310),
            name: 'name',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 1249755577209738841),
            name: 'document',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 2571568278575268592),
            name: 'phoneNumber1',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 5740368716558642822),
            name: 'phoneNumber2',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 609907450505783997),
            name: 'address',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 2485033206733926767),
            name: 'email',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(8, 9089605226220248182),
            name: 'observations',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(9, 3115366520109720853),
            name: 'dbModelId',
            type: 11,
            flags: 520,
            indexId: const IdUid(3, 2877116034213532020),
            relationTarget: 'CompanyModel')
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(4, 8312430246112723313),
      lastIndexId: const IdUid(3, 2877116034213532020),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    CompanyModel: EntityDefinition<CompanyModel>(
        model: _entities[0],
        toOneRelations: (CompanyModel object) => [],
        toManyRelations: (CompanyModel object) => {
              RelInfo<Customer>.toOneBacklink(
                      9, object.id, (Customer srcObject) => srcObject.dbModel):
                  object.costumers,
              RelInfo<Product>.toOneBacklink(
                      12, object.id, (Product srcObject) => srcObject.dbModel):
                  object.products,
              RelInfo<ProductProvider>.toOneBacklink(9, object.id,
                      (ProductProvider srcObject) => srcObject.dbModel):
                  object.providers
            },
        getId: (CompanyModel object) => object.id,
        setId: (CompanyModel object, int id) {
          object.id = id;
        },
        objectToFB: (CompanyModel object, fb.Builder fbb) {
          fbb.startTable(2);
          fbb.addInt64(0, object.id);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = CompanyModel(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0));
          InternalToManyAccess.setRelInfo(
              object.costumers,
              store,
              RelInfo<Customer>.toOneBacklink(
                  9, object.id, (Customer srcObject) => srcObject.dbModel),
              store.box<CompanyModel>());
          InternalToManyAccess.setRelInfo(
              object.products,
              store,
              RelInfo<Product>.toOneBacklink(
                  12, object.id, (Product srcObject) => srcObject.dbModel),
              store.box<CompanyModel>());
          InternalToManyAccess.setRelInfo(
              object.providers,
              store,
              RelInfo<ProductProvider>.toOneBacklink(9, object.id,
                  (ProductProvider srcObject) => srcObject.dbModel),
              store.box<CompanyModel>());
          return object;
        }),
    Customer: EntityDefinition<Customer>(
        model: _entities[1],
        toOneRelations: (Customer object) => [object.dbModel],
        toManyRelations: (Customer object) => {},
        getId: (Customer object) => object.id,
        setId: (Customer object, int id) {
          object.id = id;
        },
        objectToFB: (Customer object, fb.Builder fbb) {
          final nameOffset =
              object.name == null ? null : fbb.writeString(object.name!);
          final cpfOffset =
              object.cpf == null ? null : fbb.writeString(object.cpf!);
          final addressOffset =
              object.address == null ? null : fbb.writeString(object.address!);
          final phoneNumber1Offset = object.phoneNumber1 == null
              ? null
              : fbb.writeString(object.phoneNumber1!);
          final phoneNumber2Offset = object.phoneNumber2 == null
              ? null
              : fbb.writeString(object.phoneNumber2!);
          final emailOffset =
              object.email == null ? null : fbb.writeString(object.email!);
          final observationsOffset = object.observations == null
              ? null
              : fbb.writeString(object.observations!);
          fbb.startTable(10);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, nameOffset);
          fbb.addOffset(2, cpfOffset);
          fbb.addOffset(3, addressOffset);
          fbb.addOffset(4, phoneNumber1Offset);
          fbb.addOffset(5, phoneNumber2Offset);
          fbb.addOffset(6, emailOffset);
          fbb.addOffset(7, observationsOffset);
          fbb.addInt64(8, object.dbModel.targetId);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Customer(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              name: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 6),
              cpf: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 8),
              address: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 10),
              phoneNumber1: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 12),
              phoneNumber2: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 14),
              email: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 16),
              observations: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 18));
          object.dbModel.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 20, 0);
          object.dbModel.attach(store);
          return object;
        }),
    Product: EntityDefinition<Product>(
        model: _entities[2],
        toOneRelations: (Product object) => [object.dbModel],
        toManyRelations: (Product object) => {},
        getId: (Product object) => object.id,
        setId: (Product object, int id) {
          object.id = id;
        },
        objectToFB: (Product object, fb.Builder fbb) {
          final nameOffset = fbb.writeString(object.name);
          final codOffset = fbb.writeString(object.cod);
          final productProviderDocumentOffset =
              fbb.writeString(object.productProviderDocument);
          final brandOffset = fbb.writeString(object.brand);
          final categoryNameOffset = fbb.writeString(object.categoryName);
          final unitMeasurementOffset = fbb.writeString(object.unitMeasurement);
          final descriptionOffset = fbb.writeString(object.description);
          fbb.startTable(13);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, nameOffset);
          fbb.addOffset(2, codOffset);
          fbb.addOffset(3, productProviderDocumentOffset);
          fbb.addFloat64(4, object.costValue);
          fbb.addFloat64(5, object.saleValue);
          fbb.addOffset(6, brandOffset);
          fbb.addOffset(7, categoryNameOffset);
          fbb.addOffset(8, unitMeasurementOffset);
          fbb.addInt64(9, object.minQuantity);
          fbb.addOffset(10, descriptionOffset);
          fbb.addInt64(11, object.dbModel.targetId);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Product(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              cod: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 8, ''),
              name: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 6, ''),
              productProviderDocument:
                  const fb.StringReader(asciiOptimization: true)
                      .vTableGet(buffer, rootOffset, 10, ''),
              brand: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 16, ''),
              categoryName: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 18, ''),
              unitMeasurement: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 20, ''),
              costValue:
                  const fb.Float64Reader().vTableGet(buffer, rootOffset, 12, 0),
              saleValue:
                  const fb.Float64Reader().vTableGet(buffer, rootOffset, 14, 0),
              minQuantity: const fb.Int64Reader().vTableGet(buffer, rootOffset, 22, 0),
              description: const fb.StringReader(asciiOptimization: true).vTableGet(buffer, rootOffset, 24, ''));
          object.dbModel.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 26, 0);
          object.dbModel.attach(store);
          return object;
        }),
    ProductProvider: EntityDefinition<ProductProvider>(
        model: _entities[3],
        toOneRelations: (ProductProvider object) => [object.dbModel],
        toManyRelations: (ProductProvider object) => {},
        getId: (ProductProvider object) => object.id,
        setId: (ProductProvider object, int id) {
          object.id = id;
        },
        objectToFB: (ProductProvider object, fb.Builder fbb) {
          final nameOffset =
              object.name == null ? null : fbb.writeString(object.name!);
          final documentOffset = object.document == null
              ? null
              : fbb.writeString(object.document!);
          final phoneNumber1Offset = object.phoneNumber1 == null
              ? null
              : fbb.writeString(object.phoneNumber1!);
          final phoneNumber2Offset = object.phoneNumber2 == null
              ? null
              : fbb.writeString(object.phoneNumber2!);
          final addressOffset =
              object.address == null ? null : fbb.writeString(object.address!);
          final emailOffset =
              object.email == null ? null : fbb.writeString(object.email!);
          final observationsOffset = object.observations == null
              ? null
              : fbb.writeString(object.observations!);
          fbb.startTable(10);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, nameOffset);
          fbb.addOffset(2, documentOffset);
          fbb.addOffset(3, phoneNumber1Offset);
          fbb.addOffset(4, phoneNumber2Offset);
          fbb.addOffset(5, addressOffset);
          fbb.addOffset(6, emailOffset);
          fbb.addOffset(7, observationsOffset);
          fbb.addInt64(8, object.dbModel.targetId);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = ProductProvider(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              name: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 6),
              document: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 8),
              phoneNumber1: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 10),
              phoneNumber2: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 12),
              address: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 14),
              email: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 16),
              observations: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 18));
          object.dbModel.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 20, 0);
          object.dbModel.attach(store);
          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [CompanyModel] entity fields to define ObjectBox queries.
class CompanyModel_ {
  /// see [CompanyModel.id]
  static final id =
      QueryIntegerProperty<CompanyModel>(_entities[0].properties[0]);
}

/// [Customer] entity fields to define ObjectBox queries.
class Customer_ {
  /// see [Customer.id]
  static final id = QueryIntegerProperty<Customer>(_entities[1].properties[0]);

  /// see [Customer.name]
  static final name = QueryStringProperty<Customer>(_entities[1].properties[1]);

  /// see [Customer.cpf]
  static final cpf = QueryStringProperty<Customer>(_entities[1].properties[2]);

  /// see [Customer.address]
  static final address =
      QueryStringProperty<Customer>(_entities[1].properties[3]);

  /// see [Customer.phoneNumber1]
  static final phoneNumber1 =
      QueryStringProperty<Customer>(_entities[1].properties[4]);

  /// see [Customer.phoneNumber2]
  static final phoneNumber2 =
      QueryStringProperty<Customer>(_entities[1].properties[5]);

  /// see [Customer.email]
  static final email =
      QueryStringProperty<Customer>(_entities[1].properties[6]);

  /// see [Customer.observations]
  static final observations =
      QueryStringProperty<Customer>(_entities[1].properties[7]);

  /// see [Customer.dbModel]
  static final dbModel =
      QueryRelationToOne<Customer, CompanyModel>(_entities[1].properties[8]);
}

/// [Product] entity fields to define ObjectBox queries.
class Product_ {
  /// see [Product.id]
  static final id = QueryIntegerProperty<Product>(_entities[2].properties[0]);

  /// see [Product.name]
  static final name = QueryStringProperty<Product>(_entities[2].properties[1]);

  /// see [Product.cod]
  static final cod = QueryStringProperty<Product>(_entities[2].properties[2]);

  /// see [Product.productProviderDocument]
  static final productProviderDocument =
      QueryStringProperty<Product>(_entities[2].properties[3]);

  /// see [Product.costValue]
  static final costValue =
      QueryDoubleProperty<Product>(_entities[2].properties[4]);

  /// see [Product.saleValue]
  static final saleValue =
      QueryDoubleProperty<Product>(_entities[2].properties[5]);

  /// see [Product.brand]
  static final brand = QueryStringProperty<Product>(_entities[2].properties[6]);

  /// see [Product.categoryName]
  static final categoryName =
      QueryStringProperty<Product>(_entities[2].properties[7]);

  /// see [Product.unitMeasurement]
  static final unitMeasurement =
      QueryStringProperty<Product>(_entities[2].properties[8]);

  /// see [Product.minQuantity]
  static final minQuantity =
      QueryIntegerProperty<Product>(_entities[2].properties[9]);

  /// see [Product.description]
  static final description =
      QueryStringProperty<Product>(_entities[2].properties[10]);

  /// see [Product.dbModel]
  static final dbModel =
      QueryRelationToOne<Product, CompanyModel>(_entities[2].properties[11]);
}

/// [ProductProvider] entity fields to define ObjectBox queries.
class ProductProvider_ {
  /// see [ProductProvider.id]
  static final id =
      QueryIntegerProperty<ProductProvider>(_entities[3].properties[0]);

  /// see [ProductProvider.name]
  static final name =
      QueryStringProperty<ProductProvider>(_entities[3].properties[1]);

  /// see [ProductProvider.document]
  static final document =
      QueryStringProperty<ProductProvider>(_entities[3].properties[2]);

  /// see [ProductProvider.phoneNumber1]
  static final phoneNumber1 =
      QueryStringProperty<ProductProvider>(_entities[3].properties[3]);

  /// see [ProductProvider.phoneNumber2]
  static final phoneNumber2 =
      QueryStringProperty<ProductProvider>(_entities[3].properties[4]);

  /// see [ProductProvider.address]
  static final address =
      QueryStringProperty<ProductProvider>(_entities[3].properties[5]);

  /// see [ProductProvider.email]
  static final email =
      QueryStringProperty<ProductProvider>(_entities[3].properties[6]);

  /// see [ProductProvider.observations]
  static final observations =
      QueryStringProperty<ProductProvider>(_entities[3].properties[7]);

  /// see [ProductProvider.dbModel]
  static final dbModel = QueryRelationToOne<ProductProvider, CompanyModel>(
      _entities[3].properties[8]);
}