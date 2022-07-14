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

import 'models/customer_model.dart';
import 'models/product_model.dart';
import 'models/product_provider_model.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 6096745526676918888),
      name: 'CustomerModel',
      lastPropertyId: const IdUid(7, 4424223396678540934),
      flags: 2,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 2905278059935556278),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 4308255842695407164),
            name: 'name',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 7344863267148300617),
            name: 'cpf',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 7750797284928702639),
            name: 'phoneNumber1',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 3874780278597168301),
            name: 'phoneNumber2',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 3204309303499994684),
            name: 'email',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 4424223396678540934),
            name: 'observations',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(2, 8380036611178400582),
      name: 'Product',
      lastPropertyId: const IdUid(11, 909406185116227943),
      flags: 2,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 3634310660767420490),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 3161828027005894055),
            name: 'name',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 8795005333265386930),
            name: 'cod',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 4145531663805906188),
            name: 'productProviderDocument',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 7873407926317420495),
            name: 'costValue',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 2732359449565066400),
            name: 'saleValue',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 8693544200081200334),
            name: 'brand',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(8, 5292428172125119137),
            name: 'categoryName',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(9, 7889493180804346335),
            name: 'unitMeasurement',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(10, 3883613023539087749),
            name: 'minQuantity',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(11, 909406185116227943),
            name: 'description',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(3, 8938263830559719372),
      name: 'ProductProvider',
      lastPropertyId: const IdUid(7, 6026878383761691778),
      flags: 2,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 1466828455808098070),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 1637169941891762088),
            name: 'name',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 5541443896639696384),
            name: 'document',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 6235952779475568194),
            name: 'phoneNumber1',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 5270968492535395616),
            name: 'phoneNumber2',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 789607573461336477),
            name: 'email',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 6026878383761691778),
            name: 'observations',
            type: 9,
            flags: 0)
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
      lastEntityId: const IdUid(3, 8938263830559719372),
      lastIndexId: const IdUid(0, 0),
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
    CustomerModel: EntityDefinition<CustomerModel>(
        model: _entities[0],
        toOneRelations: (CustomerModel object) => [],
        toManyRelations: (CustomerModel object) => {},
        getId: (CustomerModel object) => object.id,
        setId: (CustomerModel object, int id) {
          object.id = id;
        },
        objectToFB: (CustomerModel object, fb.Builder fbb) {
          final nameOffset =
              object.name == null ? null : fbb.writeString(object.name!);
          final cpfOffset =
              object.cpf == null ? null : fbb.writeString(object.cpf!);
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
          fbb.startTable(8);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, nameOffset);
          fbb.addOffset(2, cpfOffset);
          fbb.addOffset(3, phoneNumber1Offset);
          fbb.addOffset(4, phoneNumber2Offset);
          fbb.addOffset(5, emailOffset);
          fbb.addOffset(6, observationsOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = CustomerModel(
              name: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 6),
              cpf: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 8),
              phoneNumber1: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 10),
              phoneNumber2: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 12),
              email: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 14),
              observations: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 16))
            ..id = const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);

          return object;
        }),
    Product: EntityDefinition<Product>(
        model: _entities[1],
        toOneRelations: (Product object) => [],
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
          fbb.startTable(12);
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

          return object;
        }),
    ProductProvider: EntityDefinition<ProductProvider>(
        model: _entities[2],
        toOneRelations: (ProductProvider object) => [],
        toManyRelations: (ProductProvider object) => {},
        getId: (ProductProvider object) => object.id,
        setId: (ProductProvider object, int id) {
          object.id = id;
        },
        objectToFB: (ProductProvider object, fb.Builder fbb) {
          final nameOffset = fbb.writeString(object.name);
          final documentOffset = fbb.writeString(object.document);
          final phoneNumber1Offset = fbb.writeString(object.phoneNumber1);
          final phoneNumber2Offset = fbb.writeString(object.phoneNumber2);
          final emailOffset = fbb.writeString(object.email);
          final observationsOffset = fbb.writeString(object.observations);
          fbb.startTable(8);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, nameOffset);
          fbb.addOffset(2, documentOffset);
          fbb.addOffset(3, phoneNumber1Offset);
          fbb.addOffset(4, phoneNumber2Offset);
          fbb.addOffset(5, emailOffset);
          fbb.addOffset(6, observationsOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = ProductProvider(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              name: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 6, ''),
              document: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 8, ''),
              phoneNumber1: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 10, ''),
              phoneNumber2: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 12, ''),
              email: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 14, ''),
              observations: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 16, ''));

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [CustomerModel] entity fields to define ObjectBox queries.
class CustomerModel_ {
  /// see [CustomerModel.id]
  static final id =
      QueryIntegerProperty<CustomerModel>(_entities[0].properties[0]);

  /// see [CustomerModel.name]
  static final name =
      QueryStringProperty<CustomerModel>(_entities[0].properties[1]);

  /// see [CustomerModel.cpf]
  static final cpf =
      QueryStringProperty<CustomerModel>(_entities[0].properties[2]);

  /// see [CustomerModel.phoneNumber1]
  static final phoneNumber1 =
      QueryStringProperty<CustomerModel>(_entities[0].properties[3]);

  /// see [CustomerModel.phoneNumber2]
  static final phoneNumber2 =
      QueryStringProperty<CustomerModel>(_entities[0].properties[4]);

  /// see [CustomerModel.email]
  static final email =
      QueryStringProperty<CustomerModel>(_entities[0].properties[5]);

  /// see [CustomerModel.observations]
  static final observations =
      QueryStringProperty<CustomerModel>(_entities[0].properties[6]);
}

/// [Product] entity fields to define ObjectBox queries.
class Product_ {
  /// see [Product.id]
  static final id = QueryIntegerProperty<Product>(_entities[1].properties[0]);

  /// see [Product.name]
  static final name = QueryStringProperty<Product>(_entities[1].properties[1]);

  /// see [Product.cod]
  static final cod = QueryStringProperty<Product>(_entities[1].properties[2]);

  /// see [Product.productProviderDocument]
  static final productProviderDocument =
      QueryStringProperty<Product>(_entities[1].properties[3]);

  /// see [Product.costValue]
  static final costValue =
      QueryDoubleProperty<Product>(_entities[1].properties[4]);

  /// see [Product.saleValue]
  static final saleValue =
      QueryDoubleProperty<Product>(_entities[1].properties[5]);

  /// see [Product.brand]
  static final brand = QueryStringProperty<Product>(_entities[1].properties[6]);

  /// see [Product.categoryName]
  static final categoryName =
      QueryStringProperty<Product>(_entities[1].properties[7]);

  /// see [Product.unitMeasurement]
  static final unitMeasurement =
      QueryStringProperty<Product>(_entities[1].properties[8]);

  /// see [Product.minQuantity]
  static final minQuantity =
      QueryIntegerProperty<Product>(_entities[1].properties[9]);

  /// see [Product.description]
  static final description =
      QueryStringProperty<Product>(_entities[1].properties[10]);
}

/// [ProductProvider] entity fields to define ObjectBox queries.
class ProductProvider_ {
  /// see [ProductProvider.id]
  static final id =
      QueryIntegerProperty<ProductProvider>(_entities[2].properties[0]);

  /// see [ProductProvider.name]
  static final name =
      QueryStringProperty<ProductProvider>(_entities[2].properties[1]);

  /// see [ProductProvider.document]
  static final document =
      QueryStringProperty<ProductProvider>(_entities[2].properties[2]);

  /// see [ProductProvider.phoneNumber1]
  static final phoneNumber1 =
      QueryStringProperty<ProductProvider>(_entities[2].properties[3]);

  /// see [ProductProvider.phoneNumber2]
  static final phoneNumber2 =
      QueryStringProperty<ProductProvider>(_entities[2].properties[4]);

  /// see [ProductProvider.email]
  static final email =
      QueryStringProperty<ProductProvider>(_entities[2].properties[5]);

  /// see [ProductProvider.observations]
  static final observations =
      QueryStringProperty<ProductProvider>(_entities[2].properties[6]);
}
