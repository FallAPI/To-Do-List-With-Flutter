// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:productivity_app/widgets/color_widget.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPress;
  final Color color;
  final Color textColor;
  const CustomButton({
    super.key,
    required this.text,
    required this.onPress,
    this.color = Colors.blue,
    this.textColor = AppColor.white,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: height * 0.02,
          horizontal: width * 0.10,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontFamily: "Poppins",
            fontWeight: FontWeight.bold,
            fontSize: width * 0.05,
          ),
        ),
      ),
    );
  }
}
