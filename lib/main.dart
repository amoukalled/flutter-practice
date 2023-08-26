import 'package:flutter/material.dart';
import 'package:myapp/authservice.dart';
import 'mytextfield.dart';
import 'register_screen.dart';
import 'customtoast.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
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
                    icon: Icons.person,
                    isPass: false,
                  ),
                  MyTextField(
                      controller: passwordController,
                      label: 'Password',
                      icon: Icons.password,
                      isPass: true),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextButton(
                        onPressed: () {
                          // Forgot Password Screen
                        },
                        child: const Text('Forgot Password.'),
                      ),
                    ],
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        String email = emailController.text;
                        String pass = passwordController.text;

                        debugPrint(emailController.toString());
                        debugPrint(passwordController.toString());
                        if (validateFields(email, pass)) {
                          final message = await AuthService()
                              .login(email: email, password: pass);
                          showCustomToast(message.toString());
                          if (message!.contains("Success")) {
                            // Navigate to homepage.
                          }
                        }
                      },
                      child: const Text('Login')),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('Do not have an account?'),
                      TextButton(
                        onPressed: () {
                          // Sign Up Screen
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterPage()));
                        },
                        child: const Text('Register now.'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

bool validateFields(String email, String pass) {
  final RegExp emailRegExp =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  if (email.isEmpty || pass.isEmpty) {
    showCustomToast("Please fill in all the fields!");
    return false;
  }
  if (!emailRegExp.hasMatch(email)) {
    showCustomToast("Please input a valid email!");
    return false;
  }

  return true;
}
