import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Material(
      
        // child: NotiListPage(),
        // theme: ThemeData.dark(),
        );
  }
}

class notisScreen extends StatefulWidget {
  const notisScreen({super.key});

  @override
  State<notisScreen> createState() => _notisScreenState();
}

class _notisScreenState extends State<notisScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
