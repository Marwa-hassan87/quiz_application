import 'package:flutter/material.dart';
import 'package:quiz_application/features/auth/presentation/screens/login_screen.dart';
import 'package:quiz_application/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:quiz_application/widgets/my_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                Image.asset('images/signUp.jpg', height: 300),
                SizedBox(height: 20),
                CustomTextField(
                  controller: nameController,
                  text: 'Name',
                  isPassword: false,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  controller: nameController,
                  text: 'Email',
                  isPassword: false,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  controller: nameController,
                  text: 'Password',
                  isPassword: true,
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  width: double.infinity,
                  child: MyButton(onTap: () {
                    if(formKey.currentState!.validate()){

                    }
                  }, buttonText: 'Signup'),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account ',
                      style: TextStyle(fontSize: 18),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) {
                              return LoginScreen();
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
      ),
    );
  }
}
