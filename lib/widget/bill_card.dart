import 'package:flutter/material.dart';
import 'package:flutter_login/screen/order_list.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';

class Bill_Card extends StatelessWidget {
  final int index;
  final Map item;
  final Function(Map) navigatePrint;
  final Function(Map) navigateEdit;
  final Function(String) deleteById;

  const Bill_Card({
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
    await SunmiPrinter.printText('date  : ${item['date_mod'].toString()}');
    await SunmiPrinter.printText('ລາຍການ');
    await SunmiPrinter.printText('${item['detail'].toString()}');
    await SunmiPrinter.printText('ລວມ: ${item['total_price'].toString()}');
    await SunmiPrinter.printText('ຊຳລະ  : ${item['pay_price'].toString()}');

    await SunmiPrinter.printText('');
    await SunmiPrinter.printQRCode('${item['bill_code'].toString()}', size: 10);
    await SunmiPrinter.printText('');
    await SunmiPrinter.lineWrap(2);
    await SunmiPrinter.exitTransactionPrint(true);
  }

  @override
  Widget build(BuildContext context) {
    final id = item['bill_id'].toString() as String;
    final billCode = item['bill_code'].toString() as String;
    return GestureDetector(
      onTap: () {
        // OrderListPage();
        // onPrint(index);
        // print('onTap');
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return OrderListPage(billCode: billCode);
        }));
      },
      child: Card(
        child: ListTile(
          leading: CircleAvatar(child: Text('${index + 1}')),
          title: Text(item['bill_time'].toString()),
          subtitle: Text(item['total_price'].toString()),
          trailing: PopupMenuButton(
            onSelected: (value) {
              if (value == 'print') {
                navigateEdit(item).toString();
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
                  child: Text('ຊຳລະເງິນ'),
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
