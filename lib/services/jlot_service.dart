import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class JlotService {
  static Future<List?> fetchTodos() async {
    final url =
        'https://script.google.com/macros/s/AKfycbwn5Yj19vmi_rBEPFXE_n_GyDnF4xi9clv8vzUXqFz4q-UY2ehE0WLuTxVfKF62B2Vrow/exec?action=getBills';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map;
      final result = json['bill'] as List;
      return result;
    } else {
      return null;
    }
  }

  static Future<bool> deleteById(String id) async {
    final url = 'https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    return response.statusCode == 200;
  }

  static Future<bool> updateTodo(String id, Map body) async {
    final url = 'https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final response = await http.put(uri,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});
    return response.statusCode == 200;
  }

  static Future<bool> addTodo(Map body) async {
    log(jsonEncode(body));
    final url =
        'https://script.google.com/macros/s/AKfycbxdG7cmUp6ROWfHkyJemJXx6EiK5A4Yu6TzTbWEPZXFVgz6k_xSwz1TEVTFMl94t4XpYg/exec?action=addBill';
    final uri = Uri.parse(url);
    final response = await http.post(uri,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});

    log(response.statusCode.toString());
    return response.statusCode == 302;
  }
  
}
