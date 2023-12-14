import 'package:NewsToYou/customized/ourlogo.dart';
import 'package:flutter/material.dart';
import 'package:NewsToYou/customized/commonbtn.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../customized/app_colors.dart';

class ForgotPage extends StatefulWidget {
  const ForgotPage({Key? key}) : super(key: key);

  @override
  State<ForgotPage> createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
  late String _email;
  final auth = FirebaseAuth.instance;
  String errorstate="";

  Future<void> resetPassword(String email) async {
    await auth.sendPasswordResetEmail(email: email).catchError((e) {
      setState(() {
        errorstate = e.code;
      });
    });
  }

  Widget _buildView(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),

            const Text("Please enter your email address. We will email you a link to reset your password."),

            const SizedBox(height: 10),

            //Username
            TextField(
              decoration: InputDecoration(
                labelText: errorstate.isEmpty?"Email":errorstate,
                floatingLabelStyle: TextStyle(
                  color: errorstate.isEmpty?AppColors.defaulttextcolor:Colors.red,
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: errorstate.isEmpty?1.0:2.0,
                      color: errorstate.isEmpty?AppColors.defaulttextcolor:Colors.red,
                    )
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 2.0,
                      color: errorstate.isEmpty?AppColors.defaulttextcolor:Colors.red
                  ),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _email = value.trim();
                });
              },
            ),

            const SizedBox(height: 10),



            CommonBtn(
              text: 'Send',
              onPressed: () async{
                errorstate="";
                await resetPassword(_email);
                if(errorstate.isEmpty) {
                  Navigator.pop(context);
                }
              },
              height: 60,
              width: double.infinity,
              radius: 6,
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
        iconTheme: const IconThemeData(
          color: Colors.black54,
        ),
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
              'Reset your password',
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