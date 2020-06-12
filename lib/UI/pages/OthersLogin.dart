import 'package:chitwan_hospital/UI/Widget/Forms.dart';
import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:chitwan_hospital/UI/pages/DoctorsModule/DoctorsModule.dart';
import 'package:chitwan_hospital/UI/pages/Home/HomeScreen.dart';
//import 'package:chitwan_hospital/service/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OthersLogin extends StatefulWidget {
  final Function toggleView;
  OthersLogin({this.toggleView});
  @override
  _OthersLoginState createState() => _OthersLoginState();
}

class _OthersLoginState extends State<OthersLogin> {
  //final AuthService _auth = AuthService();

  String _othersList;
  List _list = [
    "Doctor",
    "Ambulance",
    "Pharmacy",
    "Labratory",
    "Hospital",
    "Blood Bank",
  ];

  int _id;

  Future _checkDoctorID(context, int id) async {
    return StreamBuilder(
      stream: Firestore.instance.collection("doctors").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Text("Loading");
        return ListView.builder(
            itemCount: snapshot.data.documents.length - 1,
            itemBuilder: (BuildContext context, int index) {
              if (id = snapshot.data.documents[index][id]) {
                return snapshot.data.documents[index]["name"];
              }
              return null;
            });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.background,
        body: Stack(
          children: <Widget>[
            Container(
                height: size.height,
                child: Image.asset(
                  "assets/images/img1.jpeg",
                  fit: BoxFit.fitHeight,
                )),
            IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: textDark_Yellow,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                }),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: theme.background,
                    ),
                    width: size.width * 0.90,
                    //height: 148.0,
                    child: Column(
                      children: <Widget>[
                        // SizedBox(height: 10.0),
                        Container(
                          color: Colors.white,
                          width: size.width * 0.90,
                          child: DropdownButton(
                            underline: SizedBox(),
                            hint: Container(
                                height: 45.0,
                                width: size.width * 0.83,
                                alignment: Alignment.center,
                                child: FancyText(
                                  text: "Department",
                                  color: blueGrey,
                                  fontWeight: FontWeight.w500,
                                )),
                            value: _othersList,
                            items: _list.map((value) {
                              return DropdownMenuItem(
                                child: FancyText(
                                  text: value,
                                  color: blueGrey,
                                  fontWeight: FontWeight.w500,
                                ),
                                value: value,
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _othersList = value;
                              });
                            },
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          child: FForms(
                            borderColor: theme.background,
                            formColor: Colors.white,
                            text: "Your ID",
                            textColor: blueGrey.withOpacity(0.7),
                            height: 55.0,
                            width: size.width * 0.90,
                            validator: (val) => val.length < 6
                                ? 'Enter ID given to you by the hospital.'
                                : null,
                            onChanged: (val) {
                              setState(() => _id = val);
                            },
                          ),
                        ),
                        SizedBox(
                          height: 45.0,
                          width: size.width * 0.90,
                          child: RaisedButton(
                            color: theme.primary,
                            child: FancyText(
                              text: "SUBMIT",
                              size: 16.0,
                              color: textDark_Yellow,
                              fontWeight: FontWeight.w600,
                            ),
                            onPressed: () async {
                              _checkDoctorID(context, _id);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DoctorsModule(
                                          name: _checkDoctorID(context, _id)
                                          //data = snapshot.data
                                          )));
                              //Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
