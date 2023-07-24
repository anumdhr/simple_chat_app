import 'package:flutter/material.dart';

class TextFields extends StatelessWidget {
  const TextFields({
    required this.hintText,
    required this.controller,
    required this.obscureText,
    super.key,
  });
final String hintText;
final TextEditingController controller;
final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return TextField(

      controller: controller,
      obscureText: obscureText,
      style: TextStyle(
        color: Colors.grey,
      ),
      decoration: InputDecoration(

        hintText: hintText,
     hintStyle: TextStyle(
       
     ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.shade200,
          )
        ),
        fillColor: Colors.grey[400],
        filled: true,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            )
        ),
      ),
    );
  }
}
