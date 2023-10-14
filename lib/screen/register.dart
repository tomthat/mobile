import 'package:flutter/material.dart';
import 'package:flutter_login/model/profile.dart';
import 'package:form_field_validator/form_field_validator.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile(email: '', password: '');

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ລົງທະບຽນ"),
      ),
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
                          child: const Text("ລົງທະບຽນ",
                              style: TextStyle(fontSize: 20)),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState?.save();
                              print(
                                  "email = ${profile.email} password = ${profile.password}");

                              formKey.currentState?.reset();
                            }
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
