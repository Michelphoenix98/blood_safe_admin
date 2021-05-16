import 'package:blood_safe_admin/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'backend_services.dart';
import 'home_screen.dart';

void main() {
  runApp(Main());
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  Stream<DocumentSnapshot> firebaseStream;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blood Safe Admin',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder(
        future: Auth().getFirebaseUser(),
        builder: (context, snapShot) {
          if (snapShot.connectionState == ConnectionState.done) {
            return (snapShot.data != null)
                ? FutureBuilder(
                    future:
                        FirebaseFirestore.instance.collection('private').get(),
                    builder: (BuildContext context, snapShot2) {
                      print("connecting to private...");
                      if (snapShot2.connectionState == ConnectionState.done) {
                        print("checking role...");
                        print("${snapShot2.hasData}");
                        print("snapshotData" + snapShot2.data.toString());
                        List<QueryDocumentSnapshot> temp = snapShot2.data.docs;
                        DocumentSnapshot doc = temp[0];
                        Map<dynamic, dynamic> roles = doc["roles"];
                        if (roles.containsKey("${snapShot.data.uid}")) {
                          print("Contains key");
                          return HomePage();
                        } else {
                          Auth().signOut();
                          return Scaffold(
                            body: Center(
                              child: Text(
                                  "You are not authorized to access this site"),
                            ),
                          );
                        }
                      } else {
                        return Scaffold(
                          body: Center(
                            child: Text("Loading..."),
                          ),
                        );
                      }
                    })
                : LoginScreen();
          } else {
            return Scaffold(
              body: Center(
                child: Text("Please wait..."),
              ),
            );
          }
        },
      ),
    );
  }
}
