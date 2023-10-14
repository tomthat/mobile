import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class OrderService {
  static Future<List?> fetchTodos() async {
    final url =
        'https://script.google.com/macros/s/AKfycbzWRnuNAlLyCJ1bNS-qrZMBaotHNwz0WFVdizQ0kgmzS4mD3HxcUus-yPSpXDd4pgnc/exec?action=getorders';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map;
      final result = json['orders'] as List;
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
        'https://script.google.com/macros/s/AKfycbyDE9M3dHFTrovMwTcsSJC3t3VQcMW8uPQNowskV-5oZA3lIN_uuaeZYstls1FDqSy0cg/exec?action=addOrder';
    final uri = Uri.parse(url);
    final response = await http.post(uri,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});

    log(response.statusCode.toString());
    return response.statusCode == 302;
  }

  static Future<Map?> fetchGetRate() async {
    final url =
        'https://script.google.com/macros/s/AKfycbyIhxsAeQQzLiKZ3jXPGTya74pQaqWEA7OIVkMNomAqnk-XbrMrfIlsZXi4kwB63gbSSA/exec?action=getRates';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map;
      final rateList = json['rate'] as List;
      final fromStringList = List<Map<String, dynamic>>.from(rateList);

      final result =
          fromStringList.firstWhere((element) => element['ccy_code'] == 'THB');

      return result;
    } else {
      return null;
    }
  }
}
