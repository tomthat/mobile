import 'package:flutter/material.dart';
import 'package:flutter_login/services/user_service.dart';
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
  TextEditingController phoneController = TextEditingController();
  TextEditingController first_nameController = TextEditingController();
  TextEditingController last_nameController = TextEditingController();
  TextEditingController nick_nameController = TextEditingController();
  TextEditingController commissionController = TextEditingController();
  TextEditingController brith_dateController = TextEditingController();

  bool isEdit = false;

  @override
  void initState() {
    //phoneController.text = "20";
    // first_nameController.text = "Franck";
    // last_nameController.text = "Lampard";
    // nick_nameController.text = "Messi";
    // brith_dateController.text = "2023-10-06";
    super.initState();

    final todo = widget.todo;
    if (todo != null) {
      isEdit = true;

      final phone = todo['phone'];
      final first_name = todo['first_name'];
      final last_name = todo['last_name'];
      final nick_name = todo['nick_name'];
      final commission = todo['commission'];
      final brith_date = todo['brith_date'];

      phoneController.text = phone.toString();
      first_nameController.text = first_name.toString();
      last_nameController.text = last_name.toString();
      nick_nameController.text = nick_name.toString();
      commissionController.text = commission.toString();
      brith_dateController.text = brith_date.toString();
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
            controller: phoneController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: '20 ເບີໂທ'),
          ),
          Text(''),
          TextField(
            controller: first_nameController,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(hintText: 'ຊື້'),
          ),
          Text(''),
          TextField(
            controller: last_nameController,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(hintText: 'ນາມສະກຸນ'),
          ),
          Text(''),
          TextField(
            controller: nick_nameController,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(hintText: 'ຊື້ເລັນ'),
          ),
          Text(''),
          TextField(
            controller: commissionController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'ເປີເຊັນ %'),
          ),
          Text(''),
          TextField(
            controller: brith_dateController,
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
                  brith_dateController.text = formattedDate;
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
    final id = todo['user_id'];

    final isSuccess = await UserService.updateTodo(id.toString(), body);

    if (isSuccess) {
      print('Update Success');
      showSuccessMessage(context, message: 'ແກ້ໄຂສຳເລັດ');
    } else {
      print('Update Failed');
      showErrorMessage(context, message: 'ແກ້ໄຂບໍ່ສຳເລັດ');
    }
  }

  Future<void> submitData() async {
    final isSuccess = await UserService.addTodo(body);

    if (isSuccess) {
      print('Creation Success');
      showSuccessMessage(context, message: 'ເພີມສຳເລັດ');
    } else {
      print('Creation Failed');
      showErrorMessage(context, message: 'ເພີມບໍ່ສຳເລັດ');
    }
  }

  Map get body {
    final last_name = last_nameController.text;
    final phone = phoneController.text;
    final nick_name = nick_nameController.text;
    final first_name = first_nameController.text;

    final commission = commissionController.text;
    final brith_date = brith_dateController.text;
    return {
      "email": "nija@gmail.com",
      "password": "r54646",
      "phone": phone,
      "gens": "M",
      "first_name": first_name,
      "last_name": last_name,
      "nick_name": nick_name,
      "address": "address",
      "brith_date": brith_date,
      "user_status": "ACTIVE",
      "commission": "35"
    };
  }
}
