import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'splash/splash.dart';

void main() async{
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
