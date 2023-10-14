import 'package:flutter/material.dart';
import 'package:flutter_login/services/memb_service.dart';
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
  TextEditingController birthdateController = TextEditingController();
  TextEditingController fristnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController nicknameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  bool isEdit = false;

  @override
  void initState() {
    birthdateController.text = "";
    super.initState();
    final todo = widget.todo;
    if (todo != null) {
      isEdit = true;

      final fristname = todo['fristname'];
      final lastname = todo['lastname'];
      final nickname = todo['nickname'];
      final email = todo['email'];
      final phone = todo['phone'];
      final birthdate = todo['birthdate'];

      fristnameController.text = fristname;
      lastnameController.text = lastname;
      nicknameController.text = nickname;
      emailController.text = email;
      phoneController.text = phone;
      birthdateController.text = birthdate;
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
            controller: fristnameController,
            decoration: InputDecoration(hintText: 'fristname'),
          ),
          Text(''),
          TextField(
            controller: lastnameController,
            decoration: InputDecoration(hintText: 'lastname'),
          ),
          Text(''),
          TextField(
            controller: nicknameController,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(hintText: 'nickname'),
          ),
          Text(''),
          TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(hintText: 'email'),
          ),
          Text(''),
          TextField(
            controller: phoneController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'phone'),
          ),
          Text(''),
          TextField(
            controller: birthdateController,
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
                  birthdateController.text = formattedDate;
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
    final id = todo['member_id'];

    final isSuccess = await MembService.updateTodo(id, body);

    if (isSuccess) {
      print('Update Success');
      showSuccessMessage(context, message: 'ແກ້ໄຂສຳເລັດ');
    } else {
      print('Update Failed');
      showErrorMessage(context, message: 'ແກ້ໄຂບໍ່ສຳເລັດ');
    }
  }

  Future<void> submitData() async {
    final isSuccess = await MembService.addTodo(body);

    if (isSuccess) {
      print('Creation Success');
      showSuccessMessage(context, message: 'ເພີມສຳເລັດ');
    } else {
      print('Creation Failed');
      showErrorMessage(context, message: 'ເພີມບໍ່ສຳເລັດ');
    }
  }

  Map get body {
    final fristname = fristnameController.text;
    final lastname = lastnameController.text;
    final nickname = nicknameController.text;
    final email = emailController.text;
    final phone = phoneController.text;
    final birthdate = birthdateController.text;
    return {
      "code": 201,
      "success": true,
      "timestamp": 1695349150125,
      "message": "success",
      'data': {
        "fristname": fristname,
        "lastname": lastname,
        "nickname": nickname,
        "email": email,
        "phone": phone,
        "birthdate": birthdate,
        "is_completed": false,
      }
    };
  }
}
