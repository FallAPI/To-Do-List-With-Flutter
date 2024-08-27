// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:productivity_app/widgets/color_widget.dart';

Widget noTaskFound(double width, double heigth) {
  // Implement your widget with SVG and text indicating no tasks here
  return Container(
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/images/undraw_learning_re_32qv.svg",
            width: width * 0.9,
          ),
          SizedBox(
            height: heigth * 0.10,
          ),
          Text(
            "You don't have \n any task",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.white,
              fontFamily: 'Poppins-Bold',
              fontWeight: FontWeight.bold,
              fontSize: heigth * 0.037,
            ),
          ),
        ],
      ),
    ),
  );
}
