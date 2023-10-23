import 'package:flutter/material.dart';

import 'splash/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      //First page pop up
      title: "NewsToYou",
      home: SplashPage(),

      //Close debug tag
      debugShowCheckedModeBanner: false,
    );
  }
}
