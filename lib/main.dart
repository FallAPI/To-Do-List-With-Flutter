import 'package:flutter/material.dart';
import 'package:productivity_app/views/splash_Screen.dart';

main() {   
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen());
  }
}
