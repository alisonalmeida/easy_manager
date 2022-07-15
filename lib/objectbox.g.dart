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
import 'models/db_model.dart';
import 'models/product_model.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 1399651156766670846),
      name: 'CustomerModel',
      lastPropertyId: const IdUid(9, 6566206054860769635),
      flags: 2,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 738306332474448156),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 4168192243499101408),
            name: 'name',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 5376071269721554467),
            name: 'cpf',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 3913787341413083196),
            name: 'address',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 7850642742363070500),
            name: 'phoneNumber1',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 3434417282956572904),
            name: 'phoneNumber2',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 5748268620982214667),
            name: 'email',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(8, 2556416742415726205),
            name: 'observations',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(9, 6566206054860769635),
            name: 'dbModelId',
            type: 11,
            flags: 520,
            indexId: const IdUid(1, 4060896562095469232),
            relationTarget: 'DbModelBox')
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(2, 2710106255024945083),
      name: 'DbModelBox',
      lastPropertyId: const IdUid(2, 7169493009711651190),
      flags: 2,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 4734107737592164032),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 7169493009711651190),
            name: 'name',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[
        ModelBacklink(
            name: 'costumers', srcEntity: 'CustomerModel', srcField: ''),
        ModelBacklink(name: 'products', srcEntity: 'Product', srcField: '')
      ]),
  ModelEntity(
      id: const IdUid(3, 1838691287266921897),
      name: 'Product',
      lastPropertyId: const IdUid(12, 7270855345971225577),
      flags: 2,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 753790713790212773),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 691724664658707299),
            name: 'name',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 427613546754370745),
            name: 'cod',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 7016646232445078794),
            name: 'productProviderDocument',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 3838245072502330342),
            name: 'costValue',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 9141532895154074082),
            name: 'saleValue',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 2608728835041020836),
            name: 'brand',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(8, 3059304262195738341),
            name: 'categoryName',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(9, 7079535850861730337),
            name: 'unitMeasurement',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(10, 6047007386077162034),
            name: 'minQuantity',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(11, 1894959835434290737),
            name: 'description',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(12, 7270855345971225577),
            name: 'dbModelId',
            type: 11,
            flags: 520,
            indexId: const IdUid(2, 8452940926833556567),
            relationTarget: 'DbModelBox')
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
      lastEntityId: const IdUid(3, 1838691287266921897),
      lastIndexId: const IdUid(2, 8452940926833556567),
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
        toOneRelations: (CustomerModel object) => [object.dbModel],
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

          final object = CustomerModel(
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
                  .vTableGetNullable(buffer, rootOffset, 18))
            ..id = const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          object.dbModel.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 20, 0);
          object.dbModel.attach(store);
          return object;
        }),
    DbModelBox: EntityDefinition<DbModelBox>(
        model: _entities[1],
        toOneRelations: (DbModelBox object) => [],
        toManyRelations: (DbModelBox object) => {
              RelInfo<CustomerModel>.toOneBacklink(9, object.id,
                      (CustomerModel srcObject) => srcObject.dbModel):
                  object.costumers,
              RelInfo<Product>.toOneBacklink(
                      12, object.id, (Product srcObject) => srcObject.dbModel):
                  object.products
            },
        getId: (DbModelBox object) => object.id,
        setId: (DbModelBox object, int id) {
          object.id = id;
        },
        objectToFB: (DbModelBox object, fb.Builder fbb) {
          final nameOffset =
              object.name == null ? null : fbb.writeString(object.name!);
          fbb.startTable(3);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, nameOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = DbModelBox()
            ..id = const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0)
            ..name = const fb.StringReader(asciiOptimization: true)
                .vTableGetNullable(buffer, rootOffset, 6);
          InternalToManyAccess.setRelInfo(
              object.costumers,
              store,
              RelInfo<CustomerModel>.toOneBacklink(
                  9, object.id, (CustomerModel srcObject) => srcObject.dbModel),
              store.box<DbModelBox>());
          InternalToManyAccess.setRelInfo(
              object.products,
              store,
              RelInfo<Product>.toOneBacklink(
                  12, object.id, (Product srcObject) => srcObject.dbModel),
              store.box<DbModelBox>());
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

  /// see [CustomerModel.address]
  static final address =
      QueryStringProperty<CustomerModel>(_entities[0].properties[3]);

  /// see [CustomerModel.phoneNumber1]
  static final phoneNumber1 =
      QueryStringProperty<CustomerModel>(_entities[0].properties[4]);

  /// see [CustomerModel.phoneNumber2]
  static final phoneNumber2 =
      QueryStringProperty<CustomerModel>(_entities[0].properties[5]);

  /// see [CustomerModel.email]
  static final email =
      QueryStringProperty<CustomerModel>(_entities[0].properties[6]);

  /// see [CustomerModel.observations]
  static final observations =
      QueryStringProperty<CustomerModel>(_entities[0].properties[7]);

  /// see [CustomerModel.dbModel]
  static final dbModel =
      QueryRelationToOne<CustomerModel, DbModelBox>(_entities[0].properties[8]);
}

/// [DbModelBox] entity fields to define ObjectBox queries.
class DbModelBox_ {
  /// see [DbModelBox.id]
  static final id =
      QueryIntegerProperty<DbModelBox>(_entities[1].properties[0]);

  /// see [DbModelBox.name]
  static final name =
      QueryStringProperty<DbModelBox>(_entities[1].properties[1]);
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
      QueryRelationToOne<Product, DbModelBox>(_entities[2].properties[11]);
}
