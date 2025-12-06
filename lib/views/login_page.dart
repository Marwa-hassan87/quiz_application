// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:quiz_application/service/auth_service.dart';
import 'package:quiz_application/views/navbar_category_page.dart';
import 'package:quiz_application/views/sign_up_page.dart';
import 'package:quiz_application/widgets/my_button.dart';
import 'package:quiz_application/widgets/snakbar_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool ishidden = true;
  bool isLoading = false;
  final AuthService authService = AuthService();
  void _login() async {
    setState(() {
      isLoading = true;
    });
    final result = await authService.loginUser(
      email: emailController.text,
      password: passwordController.text,
    );
    if (result == 'success') {
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            return NavbarCategoryPage(initialIndex: 0);
          },
        ),
      );
    } else {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, 'Login failed $result');
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
              Image.asset('images/Login.jpg', height: 300),
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
                        ishidden = !ishidden;
                      });
                    },
                    icon: Icon(
                      ishidden ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                ),
                obscureText: ishidden,
              ),
              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Container(
                      margin: EdgeInsets.only(top: 10),
                      width: double.infinity,
                      child: MyButton(onTap: _login, buttonText: 'Login'),
                    ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account? ',
                    style: TextStyle(fontSize: 18),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) {
                            return SignUpPage();
                          },
                        ),
                      );
                    },
                    child: Text(
                      'Sign up',
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
