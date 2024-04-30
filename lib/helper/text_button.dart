import 'package:flutter/material.dart';

class Text_Button extends StatelessWidget {
  Text_Button({required this.text1, required this.text2, required this.onTap});

  String text1;
  String text2;
  VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text1,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            text2,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
