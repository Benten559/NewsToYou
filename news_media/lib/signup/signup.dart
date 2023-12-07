import 'package:NewsToYou/customized/ourlogo.dart';
import 'package:NewsToYou/navigationmenu/navigationmenu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:NewsToYou/customized/commonbtn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final auth = FirebaseAuth.instance;
  String errorstate="";

  List<String> selectedCategories = []; ///User selected categories
  List<String> allCategories = [        ///categories list
    'AutoMobiles',
    'Airplanes',
    'Finance',
    'Politics',
    'War',
    'Technology',
    'Music',
    'Movies',
    'Games',
    'Academics',
  ];

  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController cpasswordcontroller = TextEditingController();
  TextEditingController nicknamecontroller = TextEditingController();
  int _currentStep = 0;
  bool _emailistypiing = false;
  bool _emailcheck = false;
  bool _passwordistyping = false;
  bool _passwordcheck = false;
  bool _cpasswordistyping = false;
  bool _cpasswordmatch = false;
  bool obscureText = true;
  bool _nickcheck=false;
  bool _fcategorycheck=false;

  ///Check if the email satisfied the valid format
  bool isValidEmail(String email) {
    String emailPattern = r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$';
    RegExp regExp = RegExp(emailPattern);
    return regExp.hasMatch(email);
  }

  ///password obscuretext setting
  bool cobscureText = true;

  ///confirm password obscuretext setting

  Widget _buildView(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          children: [
            Expanded(
              child: Stepper(
                type: StepperType.horizontal,
                physics: const ScrollPhysics(),
                currentStep: _currentStep,
                onStepTapped: (step) {
                  setState(() => _currentStep = step);
                },
                onStepContinue: () {
                  _currentStep < 2 ? setState(() => _currentStep += 1) : null;
                },
                onStepCancel: () {
                  _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
                },
                controlsBuilder: (context, ControlsDetails details) {
                  return Column(
                    children: [
                      const SizedBox(height: 30),
                      if(_currentStep == 0)
                        CommonBtn(
                          text: 'Next',
                          ///this super long if statement indicates if all the requirements satisfied, then you can press register and go back to login page to login
                          onPressed:_emailcheck&&_passwordcheck&&_cpasswordmatch? details.onStepContinue : null,
                          height: 60,
                          width: double.infinity,
                          radius: 6,
                        ),

                      const SizedBox(height: 15),

                      if(_currentStep == 1 )
                      CommonBtn(
                        text: 'Next',
                        onPressed: _nickcheck&&_fcategorycheck?details.onStepContinue:null,
                        height: 60,
                        width: double.infinity,
                        radius: 6,
                      ),
                      const SizedBox(height: 10),

                      if (_currentStep == 2)
                        CommonBtn(
                          text: 'Register',
                          onPressed: () {
                            FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                email: usernamecontroller.text,
                                password: passwordcontroller.text)
                                .catchError((e){setState((){
                                      errorstate=e.code;
                                  });
                                  })
                                .then((value) {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => const NavigationMenu()));
                            });
                            FirebaseFirestore.instance
                                .collection('Users')
                                .doc(usernamecontroller.text)
                                .set({
                              'username':usernamecontroller.text,
                              'nickname':nicknamecontroller.text,
                              'categories': selectedCategories,
                                });
                          },
                          height: 60,
                          width: double.infinity,
                          radius: 6,
                        ),

                      const SizedBox(height: 16),
                      if (_currentStep != 0)
                        CommonBtn(
                          text: 'Back',
                          onPressed: details.onStepCancel,
                          height: 60,
                          width: double.infinity,
                          radius: 6,
                        ),


                    ],
                  );
                },
                steps: <Step>[
                  ///first step: create your account with username, password and confirm password.
                  ///if username length<6, you can't press the next button
                  ///if password length<6, you can't press the next button
                  ///If (password!=confirm password): you can't press the next button
                  Step(
                    title: Text('Account',
                                style: TextStyle(color: errorstate.isEmpty?null:Colors.red)),
                    content: Column(
                      children: [
                        ///Email
                        Container(
                          height: 60,
                          padding: const EdgeInsets.only(top: 3, left: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: errorstate.isEmpty?(_emailcheck?Colors.green:(_emailistypiing?Colors.red:Colors.white)):Colors.red,
                              width: 2.0,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 7,
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: usernamecontroller,
                            onChanged: (text) {
                              setState(() {
                                _emailistypiing = true;
                              });
                              if (isValidEmail(text)&&errorstate.isEmpty) {
                                setState(() {
                                  _emailcheck = true;
                                });
                              } else if (text.isEmpty) {
                                setState(() {
                                  _emailistypiing = false;
                                });
                              } else if(isValidEmail(text)&&errorstate.isNotEmpty){
                                setState(() {
                                  _emailcheck = true;
                                  errorstate="";
                                });
                              }else{
                                setState(() {
                                  _emailcheck = false;
                                });
                              }
                            },
                            decoration: InputDecoration(
                              labelText: errorstate.isEmpty?(_emailcheck?"Email requirements satisfied!":(_emailistypiing?"Invalid Email format":"Email")):errorstate,
                              labelStyle: TextStyle(
                                color: errorstate.isEmpty?(_emailcheck?Colors.green:(_emailistypiing?Colors.red:null)):Colors.red,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        /// Password
                        Container(
                          height: 60,
                          padding: const EdgeInsets.only(top: 3, left: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: _passwordistyping
                                  ? (_passwordcheck ? Colors.green : Colors.red)
                                  : Colors.white,
                              width: 2.0,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 7,
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: passwordcontroller,
                            onChanged: (text) {
                              setState(() {
                                _passwordistyping = true;
                              });
                              if (text.length >= 6) {
                                if (text == cpasswordcontroller.text) {
                                  _cpasswordmatch = true;
                                }
                                setState(() {
                                  _passwordcheck = true;
                                });
                              } else if (text.isEmpty) {
                                setState(() {
                                  _passwordistyping = false;
                                });
                              } else {
                                setState(() {
                                  if (text == cpasswordcontroller.text) {
                                    _cpasswordmatch = true;
                                  }
                                  _passwordcheck = false;
                                });
                              }
                            },
                            obscureText: obscureText,
                            decoration: InputDecoration(
                              suffix: IconButton(
                                icon: Icon(obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    obscureText = !obscureText;
                                  });
                                },
                              ),
                              labelText: _passwordistyping
                                  ? (_passwordcheck
                                      ? "Password requirement satisfied"
                                      : "Length of Password must be longer than or equal to 6 letters")
                                  : "Password",
                              labelStyle: TextStyle(
                                color: _passwordistyping
                                    ? (_passwordcheck
                                        ? Colors.green
                                        : Colors.red)
                                    : null,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        /// Confirm Password
                        Container(
                          height: 60,
                          padding: const EdgeInsets.only(top: 3, left: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: _cpasswordistyping
                                  ? (_cpasswordmatch
                                      ? (cpasswordcontroller.text.length >= 6
                                          ? Colors.green
                                          : Colors.red)
                                      : Colors.red)
                                  : Colors.white,
                              width: 2.0,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 7,
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: cpasswordcontroller,
                            onChanged: (text) {
                              setState(() {
                                _cpasswordistyping = true;
                              });
                              if (text.isEmpty) {
                                setState(() {
                                  _cpasswordmatch = false;
                                  _cpasswordistyping = false;
                                });
                              } else if (text == passwordcontroller.text) {
                                _cpasswordmatch = true;
                              } else {
                                setState(() {
                                  _cpasswordmatch = false;
                                });
                              }
                            },
                            obscureText: cobscureText,
                            decoration: InputDecoration(
                              suffix: IconButton(
                                icon: Icon(cobscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    cobscureText = !cobscureText;
                                  });
                                },
                              ),
                              labelText: _cpasswordistyping
                                  ? (_cpasswordmatch
                                      ? (cpasswordcontroller.text.length >= 6
                                          ? "Confirm Password requirement satisfied"
                                          : "Length of Password must be longer than or equal to 6 letters")
                                      : "Confirm password must be matched to your Password")
                                  : "Confirm Password",
                              labelStyle: TextStyle(
                                color: _cpasswordistyping
                                    ? (_cpasswordmatch
                                        ? (cpasswordcontroller.text.length >= 6
                                            ? Colors.green
                                            : Colors.red)
                                        : Colors.red)
                                    : null,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 0
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: const Text('Profile info'),
                    content: Column(
                      children: [
                        ///nickname
                        Container(
                          height: 60,
                          padding: const EdgeInsets.only(top: 3, left: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: _nickcheck ? Colors.green : Colors.white,
                              width: 2.0,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 7,
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: nicknamecontroller,
                            onChanged: (text) {
                              setState(() {
                                _nickcheck = true;
                              });
                              if (text.isEmpty) {
                                setState(() {
                                  _nickcheck = false;
                                });
                              }
                            },
                            decoration: InputDecoration(
                              labelText: "NickName",
                              labelStyle: TextStyle(
                                color: _nickcheck ? Colors.green : null,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        const Text("Please select at least 1 category you like:"),

                        ///favorite categories list
                        Column(
                          children: allCategories.map((category) {
                            return CheckboxListTile(
                              title: Text(category),
                              value: selectedCategories.contains(category),
                              onChanged: (bool? value) {
                                setState(() {
                                  if (value != null) {
                                    _fcategorycheck=true;
                                    if (value) {
                                      selectedCategories.add(category);
                                    } else {
                                      selectedCategories.remove(category);
                                    }
                                    if(selectedCategories.isEmpty){
                                      _fcategorycheck=false;
                                    }
                                  }
                                });
                              },
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 1
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: const Text('Done'),
                    content:  Column(
                      children: [
                        Text(
                            "You've successfully completed our register form, press the 'Register' button.$errorstate"),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 2
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                ],
              ),
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
              'Create an account to get started!',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        child: _buildView(context),
      ),
    );
  }
}
