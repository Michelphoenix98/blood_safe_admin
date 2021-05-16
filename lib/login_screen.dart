import 'package:blood_safe_admin/registration_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'backend_services.dart';
import 'home_screen.dart';

import 'common.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  List _isHovering = [false, false, false, false];
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: new Container(
        height: 40.0,
        color: Colors.blue.shade400,
        child: Center(
          child: Text(
            "(C) Copyright 2021 Michel Thomas",
            style: TextStyle(
              fontFamily: "Roboto",
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 1000),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(0.8),
                Colors.blue.shade900,
                Colors.blue.shade800,
                Colors.blue.shade400
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Image(
                    image: AssetImage("images/splash5.png"),
                    height: 60,
                    width: 60,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    "Blood Safe Admin",
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onHover: (value) {
                          setState(() {
                            _isHovering[0] = value;
                          });
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Register",
                              style: TextStyle(
                                  color: _isHovering[0]
                                      ? Colors.white
                                      : Colors.black),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Visibility(
                              maintainState: true,
                              maintainSize: true,
                              maintainAnimation: true,
                              visible: _isHovering[0],
                              child: Container(
                                height: 2,
                                width: 20,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                        onTap: () {},
                      ),
                      SizedBox(
                        width: screenSize.width / 20,
                      ),
                      InkWell(
                        onHover: (value) {
                          setState(() {
                            _isHovering[1] = value;
                          });
                        },
                        onTap: () {},
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Contact Us",
                              style: TextStyle(
                                  color: _isHovering[1]
                                      ? Colors.white
                                      : Colors.black),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Visibility(
                              maintainSize: true,
                              maintainState: true,
                              maintainAnimation: true,
                              visible: _isHovering[1],
                              child: Container(
                                height: 2,
                                width: 20,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                /* InkWell(
                  onHover: (value) {
                    setState(() {
                      _isHovering[2] = value;
                    });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Sign Up",
                        style: TextStyle(
                            color:
                                _isHovering[2] ? Colors.white : Colors.black),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Visibility(
                        maintainAnimation: true,
                        maintainSize: true,
                        maintainState: true,
                        visible: _isHovering[2],
                        child: Container(
                          height: 2,
                          width: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {},
                ),*/
                /*SizedBox(
                  width: screenSize.width / 50,
                ),*/
                /*  InkWell(
                    onTap: () {},
                    onHover: (value) {
                      setState(() {
                        _isHovering[3] = value;
                      });
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.logout,
                              color:
                                  _isHovering[3] ? Colors.white : Colors.black,
                            ),
                            Text(
                              "Log Out",
                              style: TextStyle(
                                  color: _isHovering[3]
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Visibility(
                          maintainAnimation: true,
                          maintainState: true,
                          maintainSize: true,
                          visible: _isHovering[3],
                          child: Container(
                            height: 2,
                            width: 20,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),),*/
              ],
            ),
          ),
        ),
      ),
      /* AppBar(
        centerTitle: true,
        title: Text(
          "Blood Safe",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: MediaQuery.of(context).platformBrightness == Brightness.dark
                ? Colors.white
                : Colors.black38,
          ),
        ),
        backgroundColor:
            MediaQuery.of(context).platformBrightness == Brightness.dark
                ? Colors.grey.shade900
                : Colors.white,
      ),*/
      body: CustomForm(),
    );
  }
}

class CustomForm extends StatefulWidget {
  @override
  _CustomFormState createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  static final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    print("width:${screenSize.width}");
    double a = 500 * MediaQueryData().devicePixelRatio;
    print(a);
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: screenSize.width,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 345 / MediaQueryData().devicePixelRatio,
                  /*screenSize.width * MediaQueryData().devicePixelRatio <=
                              1036
                          ? 345 / MediaQueryData().devicePixelRatio
                          : screenSize.width / 3,*/
                  //    minWidth: 223 / MediaQueryData().devicePixelRatio

                  // maxWidth: screenSize.width / 3,
                  //  minWidth: (screenSize.width < 500) ? screenSize.width : 0,
                ),
                child: TextBox(
                  textController: _emailController,
                  validationFunction: (String string) {
                    if (string.isEmpty)
                      return "Field empty";
                    else
                      return EmailValidator(errorText: '').isValid(string) !=
                              true
                          ? 'Enter a valid email address'
                          : null;
                  },
                  hintText: "Email ID: eg Mike@gmail.com",
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: 345 / MediaQueryData().devicePixelRatio,
                      /*screenSize.width * MediaQueryData().devicePixelRatio <=
                                  1036
                              ? 345 / MediaQueryData().devicePixelRatio
                              : screenSize.width / 3, */
                      //    minWidth: 223 / MediaQueryData().devicePixelRatio

                      // maxWidth: screenSize.width / 3,
                      //  minWidth: (screenSize.width < 500) ? screenSize.width : 0,
                    ),
                    child: TextBox(
                      textController: _passwordController,
                      validationFunction: MultiValidator([
                        RequiredValidator(errorText: 'password is required'),
                        MinLengthValidator(8,
                            errorText:
                                'password must be at least 8 digits long'),
                        PatternValidator(r'(?=.*?[#?!@$%^&*-])',
                            errorText:
                                'passwords must have at least one special character')
                      ]),
                      hintText: "Password",
                      obscureText: true,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () async {},
                child: Container(
                  margin: EdgeInsets.only(top: 5, bottom: 15),
                  child: Text(
                    "Forgot password?",
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10),
            child: Button(
              text: "Login",
              onPressed: () async {
                UserRec user;
                if (_formKey.currentState.validate()) {
                  Auth auth = new Auth();
                  await auth
                      .signIn(_emailController.text, _passwordController.text)
                      .then((value) {
                    print("in here!");
                    user = value;
                    //  print("DATA ${user.emailID}");
                  }).whenComplete(() {
                    print("hello");
                    // print("DATA  ${user.userName} ${user.emailID}");
                    if (auth.state == STATE.ERROR)
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text("Sign in failed"),
                          content: Text("${user.message}"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(_).pop();
                              },
                              child: Text("OK"),
                            ),
                          ],
                        ),
                      );
                    /*    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        action: auth.state == STATE.SUCCESS &&
                                user.message ==
                                    "Please check your mail for the verification link"
                            ? SnackBarAction(
                                label: "Resend",
                                onPressed: () {
                                  auth.sendVerficationLink(user.user);
                                },
                              )
                            : null,
                        content: Text(
                          "${user.message}",
                        ),
                      ),
                    );*/
                    if (auth.state ==
                            STATE
                                .SUCCESS /* &&
                        user.message !=
                            "Please check your mail for the verification link"*/
                        ) {
                      print("verifying...");
                      FirebaseFirestore.instance
                          .collection('private')
                          .doc('admins')
                          .get()
                          .then((DocumentSnapshot doc) {
                        Map<dynamic, dynamic> roles = doc["roles"];
                        if (roles.containsKey("${auth.getUser().user.uid}")) {
                          print("Contains key");
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(builder: (_) => HomePage()),
                          );
                        } else {
                          Auth().signOut();

                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) => Scaffold(
                                body: Center(
                                  child: Text(
                                      "You are not authorized to access this site"),
                                ),
                              ),
                            ),
                          );
                        }
                      });
                    }
                    /*   else if (auth.state == STATE.SUCCESS &&
                        user.message ==
                            "Please check your mail for the verification link")
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text("Verification Pending"),
                          content: Text("${user.message}"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(_).pop();
                              },
                              child: Text("OK"),
                            ),
                            TextButton(
                              onPressed: () {
                                auth.sendVerficationLink(auth.getUser().user);
                                Navigator.of(_).pop();
                              },
                              child: Text("Resend"),
                            ),
                          ],
                        ),
                      );*/
                  });
                } else
                  FocusScope.of(context).requestFocus(FocusNode());
              },
            ),
          ),
          GestureDetector(
            onTap: () async {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => RegistrationScreen(),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.all(20),
              child: Text(
                "Create new account",
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
