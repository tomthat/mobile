import 'package:flutter/material.dart';
import 'package:flutter_login/screen/order_list.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';

class Bill_Card extends StatelessWidget {
  final int index;
  final Map item;
  final Function(Map) navigatePrint;
  final Function(String) deleteById;
  const Bill_Card({
    super.key,
    required this.index,
    required this.item,
    required this.navigatePrint,
    required this.deleteById,
  });

  void onPrint(int index) async {
    await SunmiPrinter.initPrinter();
    await SunmiPrinter.startTransactionPrint(true);
    await SunmiPrinter.printText('ວັນທີ : ${item['bill_date'].toString()}');
    await SunmiPrinter.printText('ລະຫັດ     : ${item['bill_id'].toString()}');
    await SunmiPrinter.printText(
        'ເລັດເງິນ    : ${item['thb_rate'].toString()}');
    await SunmiPrinter.printText('ລາຄາ(ບາດ) : ${item['total_thb'].toString()}');
    await SunmiPrinter.printText(
        'ລາຄາ(ກິບ)  : ${item['total_lak'].toString()}');
    await SunmiPrinter.printText(
        'ຜູ້ຂາຍ      : ${item['bill_user'].toString()}');
    await SunmiPrinter.printText('');
    await SunmiPrinter.printQRCode('${item['bill_id'].toString()}', size: 10);
    await SunmiPrinter.printText('');

    await SunmiPrinter.lineWrap(2);
    await SunmiPrinter.exitTransactionPrint(true);
  }

  @override
  Widget build(BuildContext context) {
    final id = item['bill_id'] as String;
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
          title: Text(item['bill_id']),
          subtitle: Text(item['total_lak'].toString()),
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
