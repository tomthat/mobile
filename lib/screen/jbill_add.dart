import 'package:flutter/material.dart';
import 'package:flutter_login/screen/order_list.dart';
import 'package:flutter_login/services/jbill_service.dart';
import 'package:flutter_login/utils/snackbar_helper.dart';

class AddTodoPage extends StatefulWidget {
  final Map? todo;
  const AddTodoPage({
    super.key,
    this.todo,
  });

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController ccy_rateController = TextEditingController();
  TextEditingController total_priceController = TextEditingController();

  bool isEdit = false;

  @override
  void initState() {
    ccy_rateController.text = "650";
    // total_priceController.text = "Franck";
    // last_nameController.text = "Lampard";
    // nick_nameController.text = "Messi";
    // brith_dateController.text = "2023-10-06";
    super.initState();

    final todo = widget.todo;
    if (todo != null) {
      isEdit = true;

      final ccy_rate = todo['ccy_rate'];
      final total_price = todo['call_price'];

      ccy_rateController.text = ccy_rate;
      total_priceController.text = total_price;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'ແກ້ໄຂ' : 'ເພີມລາຍການ'),
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
      // Navigator.push(context, MaterialPageRoute(builder: (context) {
      //     return BillListPage();
      //   }));
    } else {
      print('Update Failed');
      showErrorMessage(context, message: 'ແກ້ໄຂບໍ່ສຳເລັດ');
    }
  }

  Future<void> submitData() async {
    final isSuccess = await JbillService.addTodo(body);

    if (isSuccess) {
      print('Creation Success');
      showSuccessMessage(context, message: 'ເພີມສຳເລັດ');
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return OrderListPage();
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
