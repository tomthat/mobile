import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class MembService {
  static Future<List?> fetchTodos() async {
    final url =
        'https://script.google.com/macros/s/AKfycbxKTpVSqg1IlEaz16cbag1LtWRGkqp5R4-bA810HSSbJyGKzHjJZdNpO0hY0PSb86M62A/exec?action=getUsers';
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
        'https://script.google.com/macros/s/AKfycbwI9u_m83qVTCirM2yG2X_Wzx1ZF_XQ3Bu7VIT5GDDbXL6zvdgqActPPnn-vv_8L5KhQw/exec?action=addUser';
    final uri = Uri.parse(url);
    final response = await http.post(uri,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});

    log(response.statusCode.toString());
    return response.statusCode == 302;
  }
}
