import 'package:flutter/material.dart';
import 'mytextfield.dart';
import 'register_screen.dart';

void main() {
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
  TextEditingController nameController = TextEditingController();
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
                    controller: nameController,
                    label: 'Username',
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
                      onPressed: () {
                        debugPrint(nameController.toString());
                        debugPrint(passwordController.toString());
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
