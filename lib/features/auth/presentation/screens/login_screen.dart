import 'package:flutter/material.dart';
import 'package:quiz_application/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:quiz_application/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:quiz_application/widgets/my_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey=GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  Image.asset('images/Login.jpg', height: 300),
                  SizedBox(height: 20),
                  CustomTextField(
                    controller: emailController,
                    text: 'Email',
                    isPassword: false,
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    controller: passwordController,
                    text: 'Password',
                    isPassword: true,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    width: double.infinity,
                    child: MyButton(onTap: () {
                      if(formKey.currentState!.validate()){

                      }
                    }, buttonText: 'Login'),
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
                                return SignUpScreen();
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
        ),
      ),
    );
  }
}
