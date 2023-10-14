import 'package:flutter/material.dart';
import 'package:flutter_login/screen/branchs.dart';
import 'package:flutter_login/screen/exch_list.dart';
import 'package:flutter_login/screen/user_list.dart';

class menusetupScreen extends StatefulWidget {
  const menusetupScreen({super.key});

  @override
  State<menusetupScreen> createState() => _menusetupScreenState();
}

class _menusetupScreenState extends State<menusetupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ຕັ້ງຄ່າ"),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: GridView.count(
          crossAxisCount: 3,
          children: <Widget>[
            Card(
              // margin: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return UserListPage();
                  }));
                },
                splashColor: Colors.blue,
                child: Center(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Icon(
                      Icons.face,
                      color: Colors.blue,
                      size: 70.0,
                    ),
                    Text("ຜູ້ໃຊ້", style: new TextStyle(fontSize: 17.0))
                  ],
                )),
              ),
            ),
            Card(
              // margin: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return branchsScreen();
                  }));
                },
                splashColor: Colors.blue,
                child: Center(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Icon(
                      Icons.pin_drop,
                      color: Colors.blue,
                      size: 70.0,
                    ),
                    Text("ສາຂາ", style: new TextStyle(fontSize: 17.0))
                  ],
                )),
              ),
            ),
            Card(
              // margin: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ExchListPage();
                  }));
                },
                splashColor: Colors.blue,
                child: Center(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Icon(
                      Icons.currency_exchange,
                      color: Colors.blue,
                      size: 70.0,
                    ),
                    Text("ອັດຕາ", style: new TextStyle(fontSize: 17.0))
                  ],
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
