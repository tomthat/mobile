import 'package:flutter/material.dart';

class Exch_Card extends StatelessWidget {
  final int index;
  final Map item;
  final Function(Map) navigateEdit;
  final Function(String) deleteById;
  const Exch_Card({
    super.key,
    required this.index,
    required this.item,
    required this.navigateEdit,
    required this.deleteById,
  });

  // void onPrint(int index) async {
  //   await SunmiPrinter.initPrinter();
  //   await SunmiPrinter.startTransactionPrint(true);
  //   // await SunmiPrinter.printText('ວັນທີ : ${item['bill_date'].toString()}');
  //   // await SunmiPrinter.printText('ລະຫັດ     : ${item['bill_id'].toString()}');
  //   // await SunmiPrinter.printText(
  //   //     'ເລັດເງິນ    : ${item['thb_rate'].toString()}');
  //   // await SunmiPrinter.printText('ລາຄາ(ບາດ) : ${item['total_thb'].toString()}');
  //   // await SunmiPrinter.printText(
  //   //     'ລາຄາ(ກິບ)  : ${item['total_lak'].toString()}');
  //   // await SunmiPrinter.printText(
  //   //     'ຜູ້ຂາຍ      : ${item['bill_user'].toString()}');

  //   await SunmiPrinter.lineWrap(2);
  //   await SunmiPrinter.exitTransactionPrint(true);
  // }

  @override
  Widget build(BuildContext context) {
    final id = item['ccy_id'] as String;
    return GestureDetector(
      onTap: () {
        // onPrint(index);
        // print('onTap');
      },
      child: Card(
        child: ListTile(
          leading: CircleAvatar(child: Text('${index + 1}')),
          title: Text(item['ccy code']),
          subtitle: Text(item['ccy_amt'].toString()),
          trailing: PopupMenuButton(
            onSelected: (value) {
              if (value == 'edit') {
                navigateEdit(item);
              } else if (value == 'delete') {
                deleteById(id);
              }
            },
            itemBuilder: (context) {
              return [
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
