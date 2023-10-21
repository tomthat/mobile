import 'package:flutter/material.dart';
import 'package:flutter_login/screen/order_list.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';

class Order_Card extends StatelessWidget {
  final int index;
  final Map item;
  final Function(Map) navigatePrint;
  final Function(Map) navigateEdit;
  final Function(String) deleteById;

  const Order_Card({
    super.key,
    required this.index,
    required this.item,
    required this.navigatePrint,
    required this.deleteById,
    required this.navigateEdit,
  });

  void onPrint(int index) async {
    await SunmiPrinter.initPrinter();
    await SunmiPrinter.startTransactionPrint(true);
    await SunmiPrinter.printText('bill  : ${item['bill_code'].toString()}');
    await SunmiPrinter.printText(
        'prod_name  : ${item['prod_name'].toString()}');
    await SunmiPrinter.printText('price : ${item['price'].toString()}');
    await SunmiPrinter.printText('last  : ${item['last_name'].toString()}');
    await SunmiPrinter.printText('nick  : ${item['nick_name'].toString()}');
    await SunmiPrinter.printText('email : ${item['email'].toString()}');
    await SunmiPrinter.printText('');
    await SunmiPrinter.printQRCode('${item['bill_code'].toString()}', size: 10);
    await SunmiPrinter.printText('');
    await SunmiPrinter.lineWrap(2);
    await SunmiPrinter.exitTransactionPrint(true);
  }

  @override
  Widget build(BuildContext context) {
    final id = item['order_id'].toString() as String;
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
          title: Text(item['prod_name'].toString()),
          subtitle: Text(item['price'].toString()),
          trailing: PopupMenuButton(
            onSelected: (value) {
              if (value == 'print') {
                onPrint(index);
              } else if (value == 'edit') {
                navigateEdit(item).toString();
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
                  child: Text('ແກ້ໄຂ'),
                  value: 'edit',
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
