import 'package:flutter/material.dart';

class ButtonFields extends StatelessWidget {
  const ButtonFields({
    required this.text,
    required this.onPressed,
    super.key,
  });
  final String text;
  final  void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        // padding: EdgeInsets.symmetric(horizontal: 140,vertical: 10),
        backgroundColor: Colors.black,
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
           text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
