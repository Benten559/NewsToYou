import 'package:NewsToYou/customized/ourlogo.dart';
import 'package:flutter/material.dart';
import 'package:NewsToYou/customized/commonbtn.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../login/login.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signOut() async {
    await _auth.signOut();
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 105,
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {

              },
            ),
          ],
          title: const Column(
            children: [
              OurLogo(),

              SizedBox(height: 5),

              //page hint
              Text(
                'Profile',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      body: Container(
        child: Column(
          children: [
            CommonBtn(
              text: 'Logout',
              onPressed: () async {
                await _signOut();
              },
              height: 60,
              width: double.infinity,
              radius: 6,
            ),
          ],
        )
      ),
      // SingleChildScrollView(
      //   child: _buildView(context),
      // ),
    );
  }
}