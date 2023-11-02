import 'package:NewsToYou/customized/app_colors.dart';
import 'package:NewsToYou/customized/ourlogo.dart';
import 'package:NewsToYou/navigationmenu/navigationmenu.dart';
import 'package:NewsToYou/news_feed/news_feed.dart';
import 'package:NewsToYou/signup/signup.dart';
import 'package:flutter/material.dart';
import 'package:NewsToYou/customized/commonbtn.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String  _email, _password;
  final auth = FirebaseAuth.instance;
  bool obscureText = true;

  Widget _buildView(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),

            //Username
            Container(
              height: 55,
              padding: const EdgeInsets.only(top: 3, left: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 7,
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Email",
                  border: InputBorder.none,
                ),
                onChanged: (value){
                  setState(() {
                    _email = value.trim();
                  });
                },
              ),
            ),

            const SizedBox(height: 10),

            // Password
            Container(
              height: 55,
              padding: const EdgeInsets.only(top: 3, left: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 7,
                  ),
                ],
              ),
              child: TextField(
                obscureText: obscureText,
                decoration: InputDecoration(
                  suffix: IconButton(
                    icon: Icon(
                        obscureText ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                  ),
                  hintText: "Password",
                  border: InputBorder.none,
                ),
                  onChanged: (value){
                    setState(() {
                      _password = value.trim();
                    });
                  },
              ),
            ),

            const SizedBox(height: 30),


            CommonBtn(
              text: 'Login',
              onPressed: () {
                auth.signInWithEmailAndPassword(email: _email, password: _password).then((_){
                Navigator.push(context,MaterialPageRoute(builder: (context) => const NavigationMenu()));
                });
              },
              height: 60,
              width: double.infinity,
              radius: 6,
            ),

            const SizedBox(height: 16),

            //Sign up
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Sign up text
                const Text(
                  "You are new to us? ",
                  style: TextStyle(
                    fontSize: 15,
                    color: AppColors.defaultextcolor,
                    fontWeight: FontWeight.w300,
                  ),
                ),

                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpPage()));
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColors.defaultfunctionaltextcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            //if forgot username/password
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Sign up text
                Text(
                  "Forgot Username/Password? ",
                  style: TextStyle(
                    fontSize: 15,
                    color: AppColors.defaultextcolor,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                TextButton(
                  onPressed: null,
                  child: Text(
                    "Forgot",
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColors.defaultfunctionaltextcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 105,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Column(
          children: [
            OurLogo(),

            SizedBox(height: 5),

            //page hint
            Text(
              'Login to your account',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: _buildView(context),
      ),
    );
  }
}
