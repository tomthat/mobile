import 'package:flutter/material.dart';
import 'package:flutter_login/screen/bill_list.dart';
import 'package:flutter_login/screen/jlot_list.dart';
import 'package:flutter_login/screen/memb_list.dart';
import 'package:flutter_login/screen/menusetup.dart';
import 'package:flutter_login/screen/noti_list.dart';
import 'package:flutter_login/screen/order_list.dart';

class menuScreen extends StatefulWidget {
  const menuScreen({super.key});

  @override
  State<menuScreen> createState() => _menuScreenState();
}

class _menuScreenState extends State<menuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ລາຍການ"),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: GridView.count(
          crossAxisCount: 3,
          children: <Widget>[
            Card(
              margin: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return BillListPage();
                  }));
                },
                splashColor: Colors.blue,
                child: Center(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Icon(
                      Icons.shopping_cart,
                      color: Colors.blue,
                      size: 70.0,
                    ),
                    Text("ຂາຍ", style: new TextStyle(fontSize: 17.0))
                  ],
                )),
              ),
            ),
            Card(
              margin: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {},
                splashColor: Colors.blue,
                child: Center(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Icon(
                      Icons.assessment,
                      color: Colors.blue,
                      size: 70.0,
                    ),
                    Text("ລາຍງານ", style: new TextStyle(fontSize: 17.0))
                  ],
                )),
              ),
            ),
            Card(
              // margin: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return MembListPage();
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
                    Text("ລູກຄ້າ", style: new TextStyle(fontSize: 17.0))
                  ],
                )),
              ),
            ),
            Card(
              // margin: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return menusetupScreen();
                  }));
                },
                splashColor: Colors.blue,
                child: Center(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Icon(
                      Icons.app_settings_alt,
                      color: Colors.blue,
                      size: 70.0,
                    ),
                    Text("ຕັ້ງຄ່າ", style: new TextStyle(fontSize: 17.0)),
                  ],
                )),
              ),
            ),
            Card(
              // margin: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return menusetupScreen();
                  }));
                },
                splashColor: Colors.blue,
                child: Center(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Icon(
                      Icons.military_tech,
                      color: Colors.blue,
                      size: 70.0,
                    ),
                    Text("ດາວ", style: new TextStyle(fontSize: 17.0)),
                  ],
                )),
              ),
            ),
            Card(
              // margin: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return JlotListPage();
                  }));
                },
                splashColor: Colors.blue,
                child: Center(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Icon(
                      Icons.eco,
                      color: Colors.blue,
                      size: 70.0,
                    ),
                    Text("JLOT", style: new TextStyle(fontSize: 17.0)),
                  ],
                )),
              ),
            ),
            Card(
              // margin: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return OrderListPage();
                  }));
                },
                splashColor: Colors.blue,
                child: Center(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Icon(
                      Icons.water_drop,
                      color: Colors.blue,
                      size: 70.0,
                    ),
                    Text("Order", style: new TextStyle(fontSize: 17.0)),
                  ],
                )),
              ),
            ),
            Card(
              // margin: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return NotiListPage();
                  }));
                },
                splashColor: Colors.blue,
                child: Center(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Icon(
                      Icons.notifications,
                      color: Colors.blue,
                      size: 70.0,
                    ),
                    Text("ແຈ້ງເຕືອນ",
                        selectionColor: Colors.blue,
                        style: new TextStyle(fontSize: 17.0))
                  ],
                )),
              ),
            ),
            Card(
              // margin: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return MembListPage();
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
                    Text("ລູກຄ້າ", style: new TextStyle(fontSize: 17.0))
                  ],
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
