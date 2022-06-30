import 'package:postgres/postgres.dart';
import 'package:path_provider/path_provider.dart';

ConectDb() async {
  var connection = PostgreSQLConnection('localhost', 8000, 'dart_test',
      username: 'dart', password: 'dart');

  await connection.open();
  await connection.execute('fmtString');
}
