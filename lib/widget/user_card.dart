import 'package:flutter/material.dart';
import 'package:flutter_login/screen/order_list.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';

class User_Card extends StatelessWidget {
  final int index;
  final Map item;
  final Function(Map) navigatePrint;
  final Function(String) deleteById;
  const User_Card({
    super.key,
    required this.index,
    required this.item,
    required this.navigatePrint,
    required this.deleteById,
  });

  void onPrint(int index) async {
    await SunmiPrinter.initPrinter();
    await SunmiPrinter.startTransactionPrint(true);
    await SunmiPrinter.printText('phone : ${item['phone'].toString()}');
    await SunmiPrinter.printText('gens  : ${item['gens'].toString()}');
    await SunmiPrinter.printText('first : ${item['first_name'].toString()}');
    await SunmiPrinter.printText('last  : ${item['last_name'].toString()}');
    await SunmiPrinter.printText('nick  : ${item['nick_name'].toString()}');
    await SunmiPrinter.printText('email : ${item['email'].toString()}');
    await SunmiPrinter.printText('');
    await SunmiPrinter.printQRCode('${item['user_id'].toString()}', size: 10);
    await SunmiPrinter.printText('');

    await SunmiPrinter.lineWrap(2);
    await SunmiPrinter.exitTransactionPrint(true);
  }

  @override
  Widget build(BuildContext context) {
    final id = item['user_id'] as String;
    return GestureDetector(
      onTap: () {
        // OrderListPage();
        // onPrint(index);
        // print('onTap');
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return OrderListPage();
        }));
      },
      child: Card(
        child: ListTile(
          leading: CircleAvatar(child: Text('${index + 1}')),
          title: Text(item['user_id'].toString()),
          subtitle: Text(item['nick_name'].toString()),
          trailing: PopupMenuButton(
            onSelected: (value) {
              if (value == 'print') {
                // navigatePrint(item);
                onPrint(index);
              } else if (value == 'delete') {
                deleteById(id);
              }
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: Text('ພິມ'),
                  value: 'print',
                ),
                PopupMenuItem(
                  child: Text('ລືບ'),
                  value: 'delete',
                ),
              ];
            },
          ),
        ),
      ),
    );
  }
}
