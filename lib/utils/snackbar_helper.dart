import 'package:flutter/material.dart';

void showSuccessMessage(BuildContext context, {required String message}) {
  final snackBar = SnackBar(
    content: Text(message),
    backgroundColor: Colors.blue,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showErrorMessage(BuildContext context, {required String message}) {
  final snackBar = SnackBar(
    content: Text(
      message,
      style: TextStyle(color: Colors.white),
    ),
    backgroundColor: Colors.red,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
