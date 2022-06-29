import 'package:postgres/postgres.dart';

ConectDb() async {
  var connection = PostgreSQLConnection("localhost", 5432, "dart_test",
      username: "dart", password: "dart");
  await connection.open();
}
