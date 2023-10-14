import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/branchm.dart';

class branchsScreen extends StatefulWidget {
  const branchsScreen({super.key});

  @override
  State<branchsScreen> createState() => _branchsScreenState();
}

class _branchsScreenState extends State<branchsScreen> {
  List<User> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ສາຂາ'),
      ),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            final color = user.gender == 'male' ? Colors.blue : Colors.green;
            return ListTile(
              title: Text(user.name.first),
              subtitle: Text(user.phone),
              tileColor: color,
            );
          }),
      floatingActionButton: FloatingActionButton.large(
          onPressed: fetchUsers, child: Icon(Icons.refresh)),
    );
  }

  Future<void> fetchUsers() async {
    print('fetchUsers called');
    const url = 'https://randomuser.me/api/?results=100';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final results = json['results'] as List<dynamic>;
    final transformed = results.map((e) {
      final name = UserName(
        title: e['name']['title'],
        first: e['name']['first'],
        last: e['name']['last'],
      );
      return User(
          cell: e['cell'],
          email: e['email'],
          gender: e['gender'],
          nat: e['nat'],
          phone: e['phone'],
          name: name);
    }).toList();
    setState(() {
      users = transformed;
    });
    print('fetchUser completed');
  }
}

// child: Icon(Icons.ac_unit),
