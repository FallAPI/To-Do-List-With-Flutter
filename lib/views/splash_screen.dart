// ignore_for_file: file_names, prefer_const_constructors, unused_local_variable, prefer_const_literals_to_create_immutables
// own package
import 'package:productivity_app/widgets/color_widget.dart';
import 'package:productivity_app/widgets/button_widget.dart';
import 'package:productivity_app/views/main_screen.dart';

// flutter package
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Widget _loadSvgImage(BuildContext context, double width) {
    try {
      return SvgPicture.asset(
        'assets/images/undraw_scrum_board_re_wk7v.svg',
        width: width * 0.9,
      );
    } catch (e) {
      // Handle error when SVG doesn't load
      return Text(
        'Error loading SVG: $e',
        style: TextStyle(color: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _loadSvgImage(context, width),
                SizedBox(
                  height: height * 0.10,
                ),
                Text(
                  "Make your daily activity \n more productive with this app",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColor.white,
                    fontFamily: "Poppins",
                    fontSize: width * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: height * 0.11,
                ),
                CustomButton(
                  text: "Get Started",
                  onPress: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: ((context) => MainScreen())));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
