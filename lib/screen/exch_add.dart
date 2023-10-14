import 'package:flutter/material.dart';
import 'package:flutter_login/services/bill_service.dart';
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
  TextEditingController bill_dateController = TextEditingController();
  TextEditingController thb_rateController = TextEditingController();
  TextEditingController total_thbController = TextEditingController();
  TextEditingController total_lakController = TextEditingController();
  TextEditingController bill_userController = TextEditingController();

  bool isEdit = false;

  @override
  void initState() {
    bill_dateController.text = "";
    super.initState();
    final todo = widget.todo;
    if (todo != null) {
      isEdit = true;

      final thb_rate = todo['thb_rate'];
      final total_thb = todo['total_thb'];
      final total_lak = todo['total_lak'];
      final bill_user = todo['bill_user'];
      final bill_date = todo['bill_date'];

      thb_rateController.text = thb_rate;
      total_thbController.text = total_thb;
      total_lakController.text = total_lak;
      bill_userController.text = bill_user;
      bill_dateController.text = bill_date;
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
            controller: thb_rateController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'thb_rate'),
          ),
          Text(''),
          TextField(
            controller: total_thbController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'total_thb'),
          ),
          Text(''),
          TextField(
            controller: total_lakController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'total_lak'),
          ),
          Text(''),
          TextField(
            controller: bill_userController,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(hintText: 'bill_user'),
          ),
          Text(''),
          TextField(
            controller: bill_dateController,
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
                  bill_dateController.text = formattedDate;
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

    final isSuccess = await BillService.updateTodo(id, body);

    if (isSuccess) {
      print('Update Success');
      showSuccessMessage(context, message: 'ແກ້ໄຂສຳເລັດ');
    } else {
      print('Update Failed');
      showErrorMessage(context, message: 'ແກ້ໄຂບໍ່ສຳເລັດ');
    }
  }

  Future<void> submitData() async {
    final isSuccess = await BillService.addTodo(body);

    if (isSuccess) {
      print('Creation Success');
      showSuccessMessage(context, message: 'ເພີມສຳເລັດ');
    } else {
      print('Creation Failed');
      showErrorMessage(context, message: 'ເພີມບໍ່ສຳເລັດ');
    }
  }

  Map get body {
    final thb_rate = thb_rateController.text;
    final total_thb = total_thbController.text;
    final total_lak = total_lakController.text;
    final bill_user = bill_userController.text;
    final bill_date = bill_dateController.text;
    return {
      "code": 201,
      "success": true,
      "timestamp": 1695349150125,
      "message": "success",
      'data': {
        "thb_rate": thb_rate,
        "total_thb": total_thb,
        "total_lak": total_lak,
        "bill_user": bill_user,
        "bill_date": bill_date,
        "is_completed": false,
      }
    };
  }
}
