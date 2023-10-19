import 'package:flutter/material.dart';
import 'package:social_media_dashboards/customized/commonbtn.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);
  Widget _buildView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //our logo
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  'NEWS',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'ToYou',
                  style: TextStyle(
                    color: Colors.black38,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),

        const SizedBox(height: 10),

        const Text(
          'Login to your account',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 15,
          ),
        ),

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
          child: const TextField(
            decoration: InputDecoration(
              hintText: "Username",
              border: InputBorder.none,
            ),
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
          child: const TextField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: "Password",
              border: InputBorder.none,
            ),
          ),
        ),

        const SizedBox(height: 30),

        const SizedBox(height: 16),

        CommonBtn(
          text: 'Login',
          onPressed: () {},
          height: 60,
          width: double.infinity,
          radius: 6,
        ),

        const SizedBox(height: 16),

        //Sign up
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Sign up text
            Text(
              "You are new to us? ",
              style: TextStyle(
                fontSize: 15,
                color: Color(0xff171717),
                fontWeight: FontWeight.w300,
              ),
            ),

            TextButton(
              onPressed: null,
              child: Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xff0274bc),
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
                color: Color(0xff171717),
                fontWeight: FontWeight.w300,
              ),
            ),
            TextButton(
              onPressed: null,
              child: Text(
                "Forgot",
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xff0274bc),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15.0),
            child: _buildView(),
          ),
        ),
      ),
    );
  }
}