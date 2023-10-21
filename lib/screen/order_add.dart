import 'package:flutter/material.dart';
import 'package:flutter_login/screen/order_list.dart';
import 'package:flutter_login/services/order_service.dart';
import 'package:flutter_login/utils/snackbar_helper.dart';

class AddTodoPage extends StatefulWidget {
  final Map? todo;
  final String? billCode;

  const AddTodoPage({
    super.key,
    this.todo,
    this.billCode,
  });

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController bill_idController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController prod_nameController = TextEditingController();

  bool isEdit = false;

  @override
  void initState() {
    bill_idController.text = widget.billCode ?? '';
    amountController.text = '1';

    super.initState();

    final todo = widget.todo;
    if (todo != null) {
      isEdit = true;

      final prod_name = todo['prod_name'];
      final bill_id = todo['bill_id'];
      final amount = todo['amount'];
      final price = todo['price'];

      bill_idController.text = bill_id;
      amountController.text = amount;
      priceController.text = price;
      prod_nameController.text = prod_name;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'ແກ້ໄຂ' : 'orderadd'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Text(''),
          TextField(
            controller: prod_nameController,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(hintText: 'ຊື່ສິນຄ້າ'),
          ),
          Text(''),
          TextField(
            controller: priceController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'ລາຄາ'),
          ),
          Text(''),
          TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'ຈຳນວນ'),
          ),
          Text(''),
          TextField(
            controller: bill_idController,
            enabled: false,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'ເລກບິນ'),
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

    final isSuccess = await OrderService.updateTodo(id.toString(), body);

    if (isSuccess) {
      print('Update Success');
      showSuccessMessage(context, message: 'ແກ້ໄຂສຳເລັດ');
    } else {
      print('Update Failed');
      showErrorMessage(context, message: 'ແກ້ໄຂບໍ່ສຳເລັດ');
    }
  }

  Future<void> submitData() async {
    final isSuccess = await OrderService.addTodo(body);

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
    final bill_id = bill_idController.text;
    final amount = amountController.text;
    final price = priceController.text;
    final prod_name = prod_nameController.text;
    return {
      "bill_id": bill_id,
      "amount": amount,
      "price": price,
      "prod_id": "5464",
      "prod_name": prod_name,
      "ccy_rate": "640"
    };
  }
}
