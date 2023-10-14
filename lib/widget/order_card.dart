import 'package:flutter/material.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';

class Order_Card extends StatelessWidget {
  final int index;
  final Map item;
  final Function(Map) navigatePrint;
  final Function(String) deleteById;
  const Order_Card({
    super.key,
    required this.index,
    required this.item,
    required this.navigatePrint,
    required this.deleteById,
  });

  void onPrint(int index) async {
    await SunmiPrinter.initPrinter();
    await SunmiPrinter.startTransactionPrint(true);
    await SunmiPrinter.printText('ໃບບິນ : ${item['bill_id'].toString()}');
    await SunmiPrinter.printText('ລະຫັດ : ${item['barcode'].toString()}');
    await SunmiPrinter.printText('ຈຳນວນ: ${item['order_amt'].toString()}');
    await SunmiPrinter.printText('ລາຄາ  : ${item['order_price'].toString()}');
    await SunmiPrinter.printText('ຜູ້ຂາຍ : ${item['order_user'].toString()}');

    await SunmiPrinter.lineWrap(2);
    await SunmiPrinter.exitTransactionPrint(true);
  }

  @override
  Widget build(BuildContext context) {
    // final id = item['order_id'] as String;
    return GestureDetector(
      onTap: () {
        //onPrint(index);
        print('onTap');
      },
      child: Card(
        child: ListTile(
          leading: CircleAvatar(child: Text('${index + 1}')),
          title: Text(item['bill_id'].toString()),
          subtitle: Text(item['detail'].toString()),
          //trailing: PopupMenuButton(
          // onSelected: (value) {
          //   if (value == 'edit') {
          //     navigatePrint(item);
          //   } else if (value == 'delete') {
          //     deleteById(id);
          //   }
          // },
          //itemBuilder: (context) {
          // return [
          //   PopupMenuItem(
          //     child: Text('ພິມ'),
          //     value: 'edit',
          //   ),
          //   PopupMenuItem(
          //     child: Text('ລືບ'),
          //     value: 'delete',
          //   ),
          // ];
          //},
          //),
        ),
      ),
    );
  }
}
