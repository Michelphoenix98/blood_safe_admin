import 'package:flutter/material.dart';
import 'common.dart';
import 'dart:ui';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController _firstNameController = new TextEditingController();
  TextEditingController _lastNameController = new TextEditingController();
  TextEditingController _emailIDController = new TextEditingController();
  List _isHovering = [false, false, false, false];
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 1000),
        child: Container(
          color: Colors.blue.shade800,
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
                    style: TextStyle(fontSize: 20, color: Colors.white),
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
      bottomNavigationBar: new Container(
        height: 40.0,
        color: Colors.blue,
        child: Center(
          child: Text(
            "(C) Copyright 2021 Michel Thomas",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: screenSize.width / 5,
                child: TextBox(
                  textController: _firstNameController,
                  hintText: "First name",
                  validationFunction: (field) {
                    if (field.isEmpty) return "Field empty";
                    return null;
                  },
                ),
              ),
              SizedBox(
                width: screenSize.width / 5,
                child: TextBox(
                  textController: _lastNameController,
                  hintText: "Last name",
                  validationFunction: (field) {
                    if (field.isEmpty) return "Field empty";
                    return null;
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            width: screenSize.width / 5,
            child: TextBox(
              textController: _emailIDController,
              hintText: "Email ID",
              validationFunction: (field) {
                if (field.isEmpty) return "Field empty";
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
