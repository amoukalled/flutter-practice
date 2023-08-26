import 'package:flutter/material.dart';
import 'package:myapp/authservice.dart';
import 'package:myapp/main.dart';
import 'package:myapp/mytextfield.dart';
import 'package:myapp/customtoast.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
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
                    controller: emailController,
                    label: 'Email',
                    icon: Icons.email,
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
                    onPressed: () async {
                      String email = emailController.text;
                      String pass = passwordController.text;
                      String confPass = confirmPassController.text;

                      debugPrint(emailController.toString());
                      debugPrint(passwordController.toString());
                      debugPrint(confirmPassController.toString());

                      if (validateFields(email, pass, confPass)) {
                        final message = await AuthService()
                            .registration(email: email, password: pass);
                        showCustomToast(message.toString());
                        if (message!.contains('Success')) {
                          navigateToLoginPage();
                        }
                      }
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

bool validateFields(String email, String pass, String confPass) {
  final RegExp emailRegExp =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  if (email.isEmpty || pass.isEmpty || confPass.isEmpty) {
    showCustomToast("Please fill in all the fields!");
    return false;
  }
  if (!emailRegExp.hasMatch(email)) {
    showCustomToast("Please input a valid email!");
    return false;
  }
  if (pass != confPass) {
    showCustomToast("Password does not match!");
    return false;
  }

  return true;
}

void navigateToLoginPage() async {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  await navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginPage()));
}
