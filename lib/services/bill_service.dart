import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class BillService {
  static Future<List?> fetchTodos() async {
    final url =
        'https://script.google.com/macros/s/AKfycbyUeASq6YFrmvqPq6fVrt3l3RQloqzpJ484smpwH6lc8YzQoFG5Ti6uT84a0P-aQ1u19g/exec?action=getBills';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map;
      final result = json['member'] as List;
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
        'https://script.google.com/macros/s/AKfycbzieSlgWtStX5qiMVV4YtTPgenDdWuduPZ6pciogzdkAwmxUhw2u6Yub3ESvjZqsgebVw/exec?action=addBill';
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