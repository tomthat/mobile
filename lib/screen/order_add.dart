import 'package:flutter/material.dart';
import 'package:flutter_login/services/order_service.dart';
import 'package:flutter_login/utils/snackbar_helper.dart';
import 'package:intl/intl.dart';

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
  TextEditingController bill_idController = TextEditingController();
  TextEditingController pro_idController = TextEditingController();
  TextEditingController pro_nameController = TextEditingController();
  TextEditingController order_dateController = TextEditingController();
  TextEditingController barcodeController = TextEditingController();
  TextEditingController order_amtController = TextEditingController();
  TextEditingController order_priceController = TextEditingController();
  TextEditingController order_userController = TextEditingController();

  bool isEdit = false;

  @override
  void initState() {
    // order_dateController.text = "";
    bill_idController.text = "5e524fb6";
    pro_idController.text = "a4f9bcdd";
    pro_nameController.text = "ເຕົ້າຮູ້";
    order_amtController.text = "1";
    order_priceController.text = "20000";
    order_userController.text = "athatsady";
    order_dateController.text = "2023-10-06";
    super.initState();

    final todo = widget.todo;
    if (todo != null) {
      isEdit = true;
      final bill_id = todo['bill_id'];
      final pro_id = todo['pro_id'];
      final pro_name = todo['pro_name'];
      final barcode = todo['barcode'];
      final order_amt = todo['order_amt'];
      final order_price = todo['order_price'];
      final order_user = todo['order_user'];
      final order_date = todo['order_date'];

      bill_idController.text = bill_id;
      pro_idController.text = pro_id;
      pro_nameController.text = pro_name;
      barcodeController.text = barcode;
      order_amtController.text = order_amt;
      order_priceController.text = order_price;
      order_userController.text = order_user;
      order_dateController.text = order_date;
    }

    Future.microtask(() async {
      final response = await OrderService.fetchGetRate();
      barcodeController.text = response?['ccy_amt'].toString() ?? '';
      setState(() {});
    });
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
            controller: bill_idController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'bill_id'),
          ),
          Text(''),
          TextField(
            controller: pro_idController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'pro_id'),
          ),
          Text(''),
          TextField(
            controller: pro_nameController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'pro_name'),
          ),
          Text(''),
          TextField(
            controller: barcodeController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'barcode'),
          ),
          Text(''),
          TextField(
            controller: order_amtController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'order_amt'),
          ),
          Text(''),
          TextField(
            controller: order_priceController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'order_price'),
          ),
          Text(''),
          TextField(
            controller: order_userController,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(hintText: 'order_user'),
          ),
          Text(''),
          TextField(
            controller: order_dateController,
            decoration: InputDecoration(
                icon: Icon(Icons.calendar_today), labelText: "ວັນເກິດ"),
            readOnly: true,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1980),
                  lastDate: DateTime(2101));

              if (pickedDate != null) {
                print(pickedDate);
                String formattedDate =
                    DateFormat('yyyy-MM-dd').format(pickedDate);
                print(formattedDate);

                setState(() {
                  order_dateController.text = formattedDate;
                });
              } else {
                print("Date is not selected");
              }
            },
          ),
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
    final id = todo['biller_id'];

    final isSuccess = await OrderService.updateTodo(id, body);

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
    } else {
      print('Creation Failed');
      showErrorMessage(context, message: 'ເພີມບໍ່ສຳເລັດ');
    }
  }

  Map get body {
    final bill_id = bill_idController.text;
    final pro_id = pro_idController.text;
    final pro_name = pro_nameController.text;
    final barcode = barcodeController.text;
    final order_amt = order_amtController.text;
    final order_price = order_priceController.text;
    final order_user = order_userController.text;
    final order_date = order_dateController.text;
    return {
      "code": 201,
      "success": true,
      "timestamp": 1695349150125,
      "message": "success",
      'data': {
        "bill_id": bill_id,
        "pro_id": pro_id,
        "pro_name": pro_name,
        "barcode": barcode,
        "order_amt": order_amt,
        "order_price": order_price,
        "order_user": order_user,
        "order_date": order_date,
        "is_completed": false,
      }
    };
  }
}
