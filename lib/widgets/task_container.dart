// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:productivity_app/widgets/color_widget.dart';

class CustomContainer extends StatelessWidget {
  final String text;
  final String time;
  final String date;
  const CustomContainer(
      {super.key, required this.text, required this.time, required this.date});
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: AppColor.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
              color: AppColor.green,
            ),
            height: 30,
          ),
          ListTile(
            title: Text(
              text,
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: height * 0.030,
                fontWeight: FontWeight.w500,
                color: Color(0xFF333333),
              ),
            ),
          ),
          Divider(
            color: Color(0xffE0E5ED),
            thickness: 0.5,
          ),
          Container(
            padding: EdgeInsets.only(
              left: height * 0.015,
              top: height * 0.01,
              bottom: height * 0.01,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.access_time_outlined,
                        color: AppColor.warning,
                        size: width * 0.04,
                      ),
                      SizedBox(width: 6),
                      Text(
                        time,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w400,
                          fontSize: width * 0.04,
                          color: AppColor.warning,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Text(
                    date,
                    style: TextStyle(
                        color: Color(0xff767E8C),
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.normal,
                        fontSize: width * 0.04),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
