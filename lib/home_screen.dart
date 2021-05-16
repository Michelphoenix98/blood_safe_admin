import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'backend_services.dart';
import 'common.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Stream<QuerySnapshot> _firebaseStream;
  @override
  void initState() {
    super.initState();
  }

  List _isHovering = [false, false, false, false];
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
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
                SizedBox(
                  width: screenSize.width / 50,
                ),
                InkWell(
                  onTap: () {
                    Auth auth = new Auth();
                    auth.signOut();
                    Navigator.of(context).pop();
                  },
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
                            color: _isHovering[3] ? Colors.white : Colors.black,
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
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: RecordsPane(),
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
    );
  }
}

class RecordsPane extends StatefulWidget {
  @override
  _RecordsPaneState createState() => _RecordsPaneState();
}

class _RecordsPaneState extends State<RecordsPane> {
  //Future _firebaseStream;
  final _firebaseStream = FirebaseFirestore.instance
      .collection("unverifiedUsers")
      .where('status', isEqualTo: 'pending')
      .snapshots();
  DocumentSnapshot selectedRecord;
  Map<int, bool> showSelected;
  @override
  void initState() {
    super.initState();
    // _firebaseStream =
    /*FirebaseFirestore.instance
        .collection("unverifiedUsers")
        .where('status', isEqualTo: 'pending')
        .get();*/

    showSelected = Map<int, bool>();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topLeft,
        child: Scrollbar(
          showTrackOnHover: true,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: constraints.maxHeight),
                  child: IntrinsicWidth(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Scrollbar(
                          showTrackOnHover: true,
                          child: SingleChildScrollView(
                            child: StreamBuilder(
                                stream: _firebaseStream,
                                builder: (context, snapshot) {
                                  if (snapshot.hasError)
                                    print("${snapshot.error}");
                                  if (!snapshot.hasData)
                                    return Center(
                                        child: Text("No records pending"));

                                  print(snapshot.data.docs.length);
                                  return DataTable(
                                    sortAscending: true,
                                    sortColumnIndex: 0,
                                    columns: [
                                      DataColumn(label: Text("ID")),
                                      DataColumn(label: Text("First name")),
                                      DataColumn(label: Text("Last name")),
                                      DataColumn(label: Text("Blood Group")),
                                      // DataColumn(label: Text("Age")),
                                      DataColumn(
                                          label: Text("Date of Birth"),
                                          numeric: true),
                                    ],
                                    rows: _buildRows(snapshot.data.docs),
                                  );
                                }), /* FutureBuilder(
                                future: _firebaseStream,
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData ||
                                      snapshot.data.docs.length == 0)
                                    return Center(
                                        child: Text("No records pending"));
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    print(snapshot.data.docs.length);
                                    return DataTable(
                                      sortAscending: true,
                                      sortColumnIndex: 0,
                                      columns: [
                                        DataColumn(label: Text("ID")),
                                        DataColumn(label: Text("First name")),
                                        DataColumn(label: Text("Last name")),
                                        DataColumn(label: Text("Blood Group")),
                                        // DataColumn(label: Text("Age")),
                                        DataColumn(
                                            label: Text("Date of Birth"),
                                            numeric: true),
                                      ],
                                      rows: _buildRows(snapshot.data.docs),
                                    );
                                  } else
                                    return Center(
                                      child: Text("Loading records..."),
                                    );
                                }),*/
                          ),
                        ),
                        selectedRecord != null
                            ? Expanded(
                                child: Container(
                                  //width: MediaQuery.of(context).size.width / 2,
                                  constraints: BoxConstraints(
                                      minWidth:
                                          MediaQuery.of(context).size.width /
                                              2),
                                  height: MediaQuery.of(context).size.height,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey.shade500,
                                    ),
                                  ),
                                  child: selectedRecord != null
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                text: 'Application ID: ',
                                                style: TextStyle(fontSize: 20),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text:
                                                          ' #${selectedRecord["uid"]}',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20,
                                                      )),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              children: [
                                                RichText(
                                                  text: TextSpan(
                                                    text: 'First Name: ',
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text:
                                                            ' ${selectedRecord["firstName"]}',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                RichText(
                                                  text: TextSpan(
                                                    text: 'Last Name: ',
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text:
                                                            ' ${selectedRecord["lastName"]}',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: RichText(
                                                text: TextSpan(
                                                  text: 'Blood Group: ',
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text:
                                                          ' ${selectedRecord["bloodGroup"]}',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: RichText(
                                                text: TextSpan(
                                                  text: 'Date of Birth: ',
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text:
                                                          ' ${selectedRecord["dateOfBirth"]}',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 30,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                RawMaterialButton(
                                                  onPressed: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (_) =>
                                                          AlertDialog(
                                                        title: Text(
                                                            "Confirm action"),
                                                        content: Text(
                                                            "Are you sure?"),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () {
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'unverifiedUsers')
                                                                  .doc(
                                                                      "${selectedRecord["uid"]}")
                                                                  .update({
                                                                'status':
                                                                    'accepted'
                                                              });
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      "users")
                                                                  .doc(
                                                                      '${selectedRecord["uid"]}')
                                                                  .set({
                                                                'firstName':
                                                                    '${selectedRecord["firstName"]}',
                                                                'lastName':
                                                                    '${selectedRecord["lastName"]}',
                                                                'uid':
                                                                    '${selectedRecord["uid"]}',
                                                                'dateOfBirth':
                                                                    '${selectedRecord["dateOfBirth"]}',
                                                                'bloodGroup':
                                                                    '${selectedRecord["bloodGroup"]}',
                                                              });

                                                              setState(() {
                                                                selectedRecord =
                                                                    null;
                                                                showSelected
                                                                    .clear();
                                                              });

                                                              Navigator.of(_)
                                                                  .pop();
                                                            },
                                                            child:
                                                                Text("Proceed"),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.of(_)
                                                                  .pop();
                                                            },
                                                            child:
                                                                Text("Cancel"),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                  fillColor: Colors.lightBlue,
                                                  splashColor: Colors
                                                      .lightBlueAccent.shade200,
                                                  hoverColor:
                                                      Colors.lightBlueAccent,
                                                  child: Padding(
                                                    padding: EdgeInsets.all(10),
                                                    child: Container(
                                                      child: Text(
                                                        "Accept",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 30,
                                                ),
                                                RawMaterialButton(
                                                  onPressed: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (_) =>
                                                          AlertDialog(
                                                        title: Text(
                                                            "Confirm action"),
                                                        content: Text(
                                                            "Are you sure?"),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () {
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'unverifiedUsers')
                                                                  .doc(
                                                                      "${selectedRecord["uid"]}")
                                                                  .update({
                                                                'status':
                                                                    'rejected'
                                                              });

                                                              setState(() {
                                                                selectedRecord =
                                                                    null;
                                                                showSelected
                                                                    .clear();
                                                              });
                                                              Navigator.of(_)
                                                                  .pop();
                                                            },
                                                            child:
                                                                Text("Proceed"),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.of(_)
                                                                  .pop();
                                                            },
                                                            child:
                                                                Text("Cancel"),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                  fillColor: Colors.red,
                                                  splashColor:
                                                      Colors.redAccent.shade400,
                                                  hoverColor: Colors.redAccent,
                                                  child: Padding(
                                                    padding: EdgeInsets.all(10),
                                                    child: Container(
                                                      child: Text(
                                                        "Reject",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        )
                                      : null,
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _setSelected(
      List<QueryDocumentSnapshot> records, DocumentSnapshot document) {
    selectedRecord = document;
    showSelected.clear();
    showSelected[records.indexOf(document)] = true;

    print(selectedRecord);
    print(showSelected[records.indexOf(document)]);
  }

  List<DataRow> _buildRows(List<QueryDocumentSnapshot> records) {
    List<DataRow> rows = [];

    records.forEach((document) {
      rows.add(DataRow(
        selected: showSelected[rows.length] == null ? false : true,
        cells: [
          DataCell(Text("${document["uid"]}"), onTap: () {
            setState(() {
              _setSelected(records, document);
              // print("row.lenght=${counter - 1}");
            });
          }),
          DataCell(Text("${document["firstName"]}"), onTap: () {
            setState(() {
              _setSelected(records, document);
              // print("row.lenght=${counter - 1}");
            });
          }),
          DataCell(Text("${document["lastName"]}"), onTap: () {
            setState(() {
              _setSelected(records, document);
              // print("row.lenght=${counter - 1}");
            });
          }),
          DataCell(Text("${document["bloodGroup"]}"), onTap: () {
            setState(() {
              _setSelected(records, document);
              // print("row.lenght=${counter - 1}");
            });
          }),
          DataCell(Text("${document["dateOfBirth"]}"), onTap: () {
            setState(() {
              _setSelected(records, document);
              // print("row.lenght=${counter - 1}");
            });
          }),
        ],
      ));
    });
    return rows;
    //print(records[0]["firstName"]);
    /* return [
      DataRow(selected: true, cells: [
        DataCell(
          Text("12450693837"),
        ),
        DataCell(
          Text("Mike"),
        ),
        DataCell(
          Text("Wazowski"),
        ),
        DataCell(Text("A+")),
        DataCell(Text("13-11-1998"))
      ]),
      DataRow(selected: true, cells: [
        DataCell(
          Text("12450693837"),
        ),
        DataCell(
          Text("Mike"),
        ),
        DataCell(
          Text("Wazowski"),
        ),
        DataCell(Text("A+")),
        DataCell(Text("13-11-1998"))
      ]),
      DataRow(selected: true, cells: [
        DataCell(
          Text("12450693837"),
        ),
        DataCell(
          Text("Mike"),
        ),
        DataCell(
          Text("Wazowski"),
        ),
        DataCell(Text("A+")),
        DataCell(Text("13-11-1998"))
      ]),
    ];*/
  }
}
