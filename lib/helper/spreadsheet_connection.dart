import 'package:easy_manager/credentials.dart';
import 'package:gsheets/gsheets.dart';

class GSheetDb {
  late final GSheets gSheets;
  late final Spreadsheet ss;
  GSheetDb() {
    gSheets = GSheets(credential);
  }

  Future init() async {
    ss = await gSheets.spreadsheet(spreadsheetId);
  }

  Future<List<Map<String, String>>>? getUsers() async {
    Worksheet? sheet = ss.worksheetByTitle('usuarios');

    var users = await sheet!.values.map.allRows();

    return users!;
  }

  Future insertProvider() async {
Worksheet?  sheet;
sheet ??= await ss.addWorksheet('example');
  
  }
}
