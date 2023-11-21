import 'package:NewsToYou/customized/app_colors.dart';
import 'package:NewsToYou/customized/ourlogo.dart';
import 'package:NewsToYou/login/login.dart';
import 'package:flutter/material.dart';
import 'package:NewsToYou/customized/commonbtn.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Sign_UpPage extends StatefulWidget {
  const Sign_UpPage({Key? key}) : super(key: key);

  @override
  State<Sign_UpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<Sign_UpPage> {
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController cpasswordcontroller = TextEditingController();
  final int _currentStep = 0;
  final bool _useristyping = false;
  final bool _usercheck = false;
  final bool _passwordistyping = false;
  final bool _passwordcheck = false;
  final bool _cpasswordistyping = false;
  final bool _cpasswordmatch = false;
  bool obscureText = true;

  ///password obscuretext setting
  bool cobscureText = true;

  late String  _email, _password;
  final auth = FirebaseAuth.instance;

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
                decoration: const InputDecoration(
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
                  text: 'Sign Up',
                  onPressed:(){
              auth.signInWithEmailAndPassword(email: _email, password: _password).then((_){
              Navigator.push(context,MaterialPageRoute(builder: (context) => const LoginPage()));
              });
              },
              height: 60,
              width: double.infinity,
              radius: 6,
              ),

              const SizedBox(height:16),

            //Sign up
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Sign up text
                const Text(
                  "Have an account?",
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
                            builder: (context) => const LoginPage()));
                  },
                  child: const Text(
                    "Login Here",
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
              'Create an Account',
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