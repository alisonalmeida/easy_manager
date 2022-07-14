import 'package:http/http.dart' as http;
import 'dart:convert';

class CepHelper {
  static Future getData(String cep) async {
    http.Response response =
        await http.get(Uri.parse('https://viacep.com.br/ws/$cep/json/'));

    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);

      return map;
    } else {
      return null;
    }
  }
}
