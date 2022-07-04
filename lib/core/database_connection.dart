// ignore_for_file: depend_on_referenced_packages

import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

class DatabaseConnection {
  static final DatabaseConnection instance = DatabaseConnection._init();

  static Database? _database;

  DatabaseConnection._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('db_easy_manager.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  _createDB(Database db, int version) async {
    await db.execute('''
CREATE TABLE clients (
  cpf INTERGER PRIMARY KEY,
  name TEXT NOT NULL

)
''');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
