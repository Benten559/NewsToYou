import 'package:NewsToYou/customized/app_colors.dart';
import 'package:NewsToYou/customized/ourlogo.dart';
import 'package:NewsToYou/login/login.dart';
import 'package:flutter/material.dart';
import 'package:NewsToYou/customized/commonbtn.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController usernamecontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();
  TextEditingController cpasswordcontroller=TextEditingController();
  int _currentStep = 0;
  bool _useristyping=false;
  bool _usercheck=false;
  bool _passwordistyping=false;
  bool _passwordcheck=false;
  bool _cpasswordistyping=false;
  bool _cpasswordmatch=false;
  bool obscureText = true;       ///password obscuretext setting
  bool cobscureText = true;      ///confirm password obscuretext setting

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
                onStepTapped: (step){
                  setState(() => _currentStep = step);
                },
                onStepContinue:  (){_currentStep < 2 ? setState(() => _currentStep += 1): null;},
                onStepCancel: (){_currentStep > 0 ? setState(() => _currentStep -= 1) : null;},
                controlsBuilder: (context, ControlsDetails details) {
                  return Column(
                    children: [
                      const SizedBox(height: 46),
                      CommonBtn(
                        text: _currentStep<2?'Next':'Register',
                        ///this super long if statement indicates if all the requirements satisfied, then you can press register and go back to login page to login
                        onPressed: _currentStep<2? (_usercheck&&_passwordcheck&&_cpasswordmatch? details.onStepContinue : null):() {Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginPage()));},
                        height: 60,
                        width: double.infinity,
                        radius: 6,
                      ),
                      const SizedBox(height: 16),
                      if(_currentStep!=0)
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
                    title: const Text('Account'),
                    content: Column(
                      children: [

                        ///username
                        Container(
                          height: 60,
                          padding: const EdgeInsets.only(top: 3, left: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: _useristyping? (_usercheck? Colors.green : Colors.red) : Colors.white,
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
                            onChanged: (text){
                              setState(() {
                                _useristyping=true;
                              });
                              if(text.length >= 6) {
                                setState(() {
                                  _usercheck=true;
                                });
                              } else if(text.isEmpty){
                                setState(() {
                                  _useristyping=false;
                                });
                              } else {
                                setState(() {
                                  _usercheck = false;
                                });
                              }
                            },
                            decoration: InputDecoration(
                              labelText: _useristyping? (_usercheck? "Username requirement satisfied" : "Length of Username must be longer than or equal to 6 letters") : "Username",
                              labelStyle: TextStyle(
                                color: _useristyping? (_usercheck? Colors.green : Colors.red) : null,
                              ),
                              hintText: "Username",
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
                              color: _passwordistyping? (_passwordcheck? Colors.green : Colors.red) : Colors.white,
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
                            onChanged: (text){
                              setState(() {
                                _passwordistyping=true;
                              });
                              if(text.length >= 6) {
                                if(text==cpasswordcontroller.text){
                                  _cpasswordmatch=true;
                                }
                                setState(() {
                                  _passwordcheck=true;
                                });
                              } else if(text.isEmpty){
                                setState(() {
                                  _passwordistyping=false;
                                });
                              } else {
                                setState(() {
                                  if(text==cpasswordcontroller.text){
                                    _cpasswordmatch=true;
                                  }
                                  _passwordcheck = false;
                                });
                              }
                            },
                            obscureText: obscureText,
                            decoration: InputDecoration(
                              suffix: IconButton(
                                icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    obscureText = !obscureText;
                                  });
                                },
                              ),
                              labelText: _passwordistyping? (_passwordcheck? "Password requirement satisfied" : "Length of Password must be longer than or equal to 6 letters") : "Password",
                              labelStyle: TextStyle(
                                color: _passwordistyping? (_passwordcheck? Colors.green : Colors.red) : null,
                              ),
                              hintText: "Password",
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
                              color: _cpasswordistyping? (_cpasswordmatch? (cpasswordcontroller.text.length>=6? Colors.green : Colors.red) : Colors.red) : Colors.white,
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
                            onChanged: (text){
                              setState(() {
                                _cpasswordistyping=true;
                              });
                              if(text.isEmpty){
                                setState(() {
                                  _cpasswordmatch=false;
                                  _cpasswordistyping=false;
                                });
                              } else if(text==passwordcontroller.text){
                                _cpasswordmatch=true;
                              } else {
                                setState(() {
                                  _cpasswordmatch = false;
                                });
                              }
                            },
                            obscureText: cobscureText,
                            decoration: InputDecoration(
                              suffix: IconButton(
                                icon: Icon(cobscureText ? Icons.visibility : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    cobscureText = !cobscureText;
                                  });
                                },
                              ),
                              labelText: _cpasswordistyping? (_cpasswordmatch? (cpasswordcontroller.text.length>=6? "Confirm Password requirement satisfied" : "Length of Password must be longer than or equal to 6 letters") : "Confirm password must be matched to your Password") : "Confirm Password",
                              labelStyle: TextStyle(
                                color: _cpasswordistyping? (_cpasswordmatch? (cpasswordcontroller.text.length>=6? Colors.green : Colors.red) : Colors.red) : null,
                              ),
                              hintText: "Confirm Password",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 0 ?
                    StepState.complete : StepState.disabled,
                  ),
                  Step(
                    title: Text('Other info'),
                    content: const Column(
                      children: [
                        Text('SKIP THIS!!!')
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 1 ?
                    StepState.complete : StepState.disabled,
                  ),
                  Step(
                    title: Text('Done'),
                    content: const Column(
                      children: [
                        Text("You've successfully completed our register form, press the 'Register' button."),
                        Text("You will be redirected to the login page.")
                      ],
                    ),
                    isActive:_currentStep >= 0,
                    state: _currentStep >= 2 ?
                    StepState.complete : StepState.disabled,
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