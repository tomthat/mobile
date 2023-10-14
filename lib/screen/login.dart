import 'package:flutter/material.dart';
import 'package:flutter_login/screen/menu.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../model/profile.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile(email: '', password: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ເຂົ້າລະບົບ")),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    const Text("ອີເມວ", style: TextStyle(fontSize: 20)),
                    TextFormField(
                      validator: MultiValidator([
                        RequiredValidator(errorText: "ກະລູນາປອນອີເມວ"),
                        EmailValidator(
                            errorText: "ຮູບແບບອີເມວຜິດ! ກະລູນາກວດອີເມວ")
                      ]),
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (String? email) {
                        profile.email = email ?? '';
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text("ລະຫັດ", style: TextStyle(fontSize: 20)),
                    TextFormField(
                      validator:
                          RequiredValidator(errorText: "ກະລູນາປອນລະຫັດຜ່ານ"),
                      obscureText: true,
                      onSaved: (String? password) {
                        profile.password = password ?? '';
                      },
                    ),
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          child: const Text("ເຂົ້າສູລະບົບ",
                              style: TextStyle(fontSize: 20)),
                          onPressed: () {
                            // if (formKey.currentState!.validate()) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return menuScreen();
                            }));
                            // }
                          },
                        )),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
