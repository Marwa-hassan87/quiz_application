import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String text;
  final bool isPassword;
  const CustomTextField({
    super.key,
    required this.controller,
    required this.text,
    required this.isPassword,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool isObscureText;
  @override
  void initState() {
    isObscureText = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: (value){
        if(value==null || value.isEmpty){
          return '${widget.text} Can\'t be Empty';
        }
        return null;
      },
      cursorColor: Colors.black,
      cursorHeight: 20,
      obscureText: isObscureText,
      decoration: InputDecoration(
        labelText: widget.text,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2),
        ),
        suffixIcon: widget.isPassword
            ? GestureDetector(
                onTap: () => setState(() {
                  isObscureText = !isObscureText;
                }),
                child: Icon(
                  isObscureText
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
              )
            : null,
      ),
    );
  }
}
