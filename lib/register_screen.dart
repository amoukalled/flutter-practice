import 'package:flutter/material.dart';
import 'package:myapp/mytextfield.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registration')),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
                child: Column(
              children: [
                MyTextField(
                    controller: nameController,
                    label: 'Username',
                    icon: Icons.person,
                    isPass: false),
                MyTextField(
                    controller: passwordController,
                    label: 'Password',
                    icon: Icons.password,
                    isPass: true),
                MyTextField(
                    controller: confirmPassController,
                    label: 'Confirm Password',
                    icon: Icons.password,
                    isPass: true),
                ElevatedButton(
                    onPressed: () {
                      String name = nameController.text;
                      String pass = passwordController.text;
                      String confPass = confirmPassController.text;

                      debugPrint(name);
                      debugPrint(pass);
                      debugPrint(confPass);

                      validateFields(name, pass, confPass);
                    },
                    child: const Text('Register'))
              ],
            ))
          ],
        ),
      ),
    );
  }
}

bool validateFields(String name, String pass, String confPass) {
  if (name.isEmpty || pass.isEmpty || confPass.isEmpty) {
    showCustomToast("Please fill in all the fields!");
    return false;
  }
  if (pass != confPass) {
    showCustomToast("Password does not match!");
    return false;
  }

  return true;
}

void showCustomToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    backgroundColor: Colors.grey,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
