// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:quiz_application/service/auth_service.dart';
import 'package:quiz_application/views/login_page.dart';
import 'package:quiz_application/widgets/my_button.dart';
import 'package:quiz_application/widgets/snakbar_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isHidden = true;
  bool isLoading = false;
  final AuthService authService = AuthService();
  void signUp() async {
    setState(() {
      isLoading = true;
    });
    final result = await authService.signUpUser(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
    );
    if (result == 'success') {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, 'Signup Successfully');
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            return LoginPage();
          },
        ),
      );
    } else {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, 'Signup failed $result');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: ListView(
            children: [
              Image.asset('images/signUp.jpg', height: 300),
              SizedBox(height: 20),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isHidden = !isHidden;
                      });
                    },
                    icon: Icon(
                      isHidden ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                ),
                obscureText: isHidden,
              ),
              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Container(
                      margin: EdgeInsets.only(top: 10),
                      width: double.infinity,
                      child: MyButton(onTap: signUp, buttonText: 'Signup'),
                    ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an acount ',
                    style: TextStyle(fontSize: 18),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) {
                            return LoginPage();
                          },
                        ),
                      );
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -1,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
