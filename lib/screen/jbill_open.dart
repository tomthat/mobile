import 'package:flutter/material.dart';
import 'package:flutter_login/screen/jorder_list.dart';
import 'package:flutter_login/services/jbill_service.dart';
import 'package:flutter_login/utils/snackbar_helper.dart';

class OpenTodoPage extends StatefulWidget {
  final Map? todo;

  const OpenTodoPage({
    super.key,
    this.todo,
  });

  @override
  State<OpenTodoPage> createState() => _OpenTodoPageState();
}

class _OpenTodoPageState extends State<OpenTodoPage> {
  TextEditingController ccy_rateController = TextEditingController();
  TextEditingController total_priceController = TextEditingController();

  bool isEdit = false;

  get item => null;

  @override
  void initState() {
    ccy_rateController.text = "650";
    total_priceController.text = "0";
    // last_nameController.text = "Lampard";
    // nick_nameController.text = "Messi";
    // brith_dateController.text = "2023-10-06";
    super.initState();
    //-------------------------------------------------inser auto
    submitData();
    // Navigator.push(context, MaterialPageRoute(builder: (context) {
    //   return Order_listmaxPage();
    // }));

    final todo = widget.todo;
    if (todo != null) {
      isEdit = true;

      final ccy_rate = todo['ccy_rate'];
      final total_price = todo['total_price'];

      ccy_rateController.text = ccy_rate.toString();
      total_priceController.text = total_price.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'ແກ້ໄຂ' : 'Jbill open'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Text(''),
          TextField(
            controller: ccy_rateController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'ເລັດ'),
          ),
          Text(''),
          TextField(
            controller: total_priceController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'ລາຄາລວມ'),
          ),
          Text(''),
          SizedBox(height: 20),
          ElevatedButton(
              onPressed: isEdit ? updateData : submitData,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(isEdit ? 'ແກ້ໄຂ' : 'ບັນທືກ'),
              ))
        ],
      ),
    );
  }

  Future<void> updateData() async {
    final todo = widget.todo;
    if (todo == null) {
      print('can not update api ');
      return;
    }
    final id = todo['bill_id'];

    final isSuccess = await JbillService.updateTodo(id.toString(), body);

    if (isSuccess) {
      print('Update Success');
      showSuccessMessage(context, message: 'ແກ້ໄຂສຳເລັດ');
    } else {
      print('Update Failed');
      showErrorMessage(context, message: 'ແກ້ໄຂບໍ່ສຳເລັດ');
    }
  }

  Future<void> submitData() async {
    final isSuccess = await JbillService.addTodo(body);
    // final billCode = item['bill_code'].toString() as String;

    if (isSuccess) {
      print('Creation Success2');

      showSuccessMessage(context, message: 'ເພີມສຳເລັດ');
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return JOrderListPage();
      }));
    } else {
      print('Creation Failed');
      showErrorMessage(context, message: 'ເພີມບໍ່ສຳເລັດ');
    }
  }

  Map get body {
    final ccy_rate = ccy_rateController.text;
    final total_price = total_priceController.text;
    return {"ccy_rate": ccy_rate, "total_price": total_price};
  }
}
