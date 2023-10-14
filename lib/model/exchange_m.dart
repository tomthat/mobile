import 'package:flutter_login/model/exchange_name_m.dart';

class Exc {
  final String gender;
  final String email;
  final String phone;
  final String cell;
  final String nat;
  final ExcName name;

  Exc({
    required this.gender,
    required this.email,
    required this.phone,
    required this.cell,
    required this.nat,
    required this.name,
  });

  String get fullName {
  return '${name.title} ${name.first} ${name.last}';
}

}


