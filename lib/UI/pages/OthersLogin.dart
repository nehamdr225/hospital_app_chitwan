import 'package:chitwan_hospital/UI/HospitalModule/HospitalModule.dart';
import 'package:chitwan_hospital/UI/LabModule/LabModule.dart';
import 'package:chitwan_hospital/UI/PharmacyModule/PharmacyModule.dart';
import 'package:chitwan_hospital/UI/Widget/Forms.dart';
import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:chitwan_hospital/UI/DoctorsModule/DoctorsModule.dart';
import 'package:chitwan_hospital/UI/pages/Home/HomeScreen.dart';
import 'package:chitwan_hospital/UI/pages/OthersSignUp.dart';
import 'package:chitwan_hospital/service/auth.dart';
import 'package:flutter/material.dart';

class OthersLogin extends StatefulWidget {
  final Function toggleView;
  OthersLogin({this.toggleView});
  @override
  _OthersLoginState createState() => _OthersLoginState();
}

class _OthersLoginState extends State<OthersLogin> {
  String _othersList;
  List _list = [
    "Doctor",
    "Ambulance",
    "Pharmacy",
    "Labratory",
    "Hospital",
    "Blood Bank",
  ];

  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;
  bool signedIn = false;
  bool obscure = true;

  // text field state
  String email = '';
  String password = '';
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: theme.background,
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.center,
            fit: BoxFit.cover,
            image: AssetImage("assets/images/img1.jpeg"),
          ),
        ),
        child: ListView(
          children: <Widget>[
            IconButton(
                alignment: Alignment.topLeft,
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: textDark_Yellow,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                }),
            Center(
              heightFactor: 1.4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
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
                                child: Container(
                                  height: 45.0,
                                  width: size.width * 0.83,
                                  alignment: Alignment.center,
                                  child: FancyText(
                                    text: value,
                                    color: blueGrey,
                                    fontWeight: FontWeight.w500,
                                  ),
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
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: theme.background,
                          ),
                          padding: EdgeInsets.only(top: 5.0),
                          width: size.width * 0.90,
                          //height: 165.0,
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                // SizedBox(height: 10.0),
                                FForms(
                                  borderColor: theme.background,
                                  formColor: Colors.white,
                                  text: "Email",
                                  textColor: blueGrey.withOpacity(0.7),
                                  width: size.width * 0.90,
                                  validator: (val) =>
                                      val.isEmpty ? 'Enter an email' : null,
                                  onChanged: (val) {
                                    setState(() => email = val);
                                  },
                                ),
                                FForms(
                                  borderColor: theme.background,
                                  formColor: Colors.white,
                                  text: "Password",
                                  obscure: obscure,
                                  trailingIcon: obscure == true
                                      ? IconButton(
                                          icon: Icon(
                                            Icons.visibility,
                                            color: theme.primary,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              obscure = false;
                                            });
                                          })
                                      : IconButton(
                                          icon: Icon(
                                            Icons.visibility_off,
                                            color: theme.primary,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              obscure = true;
                                            });
                                          }),
                                  textColor: blueGrey.withOpacity(0.7),
                                  width: size.width * 0.90,
                                  validator: (val) => val.length < 6
                                      ? 'Enter a password 6+ chars long'
                                      : null,
                                  onChanged: (val) {
                                    setState(() => password = val);
                                  },
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
                                        if (_formKey.currentState.validate()) {
                                          setState(() {
                                            loading = true;
                                          });
                                          // Scaffold.of(context).showSnackBar(
                                          //     SnackBar(
                                          //         content:
                                          //             Text('Processing Data')));
                                          _formKey.currentState.save();
                                          dynamic result = await _auth
                                              .signInWithEmailAndPassword(
                                                  email, password);
                                          if (result == null) {
                                            setState(() {
                                              loading = false;
                                              signedIn = false;
                                              error =
                                                  'Could not sign in with those credentials';
                                            });
                                          } else {
                                            //   setState(() {
                                            //   loading = false;
                                            //   signedIn = true;
                                            // });
                                            if (_othersList == 'Doctor') {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DoctorsModule()));
                                            } else if (_othersList ==
                                                'Pharmacy') {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          PharmacyModule()));
                                            } else if (_othersList ==
                                                'Labratory') {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          LabModule()));
                                            } else if (_othersList ==
                                                'Hospital') {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          HospitalModule()));
                                            }
                                          }
                                        }
                                      }),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FancyText(
                          text: "Don't have an account? ",
                          color: textDark_Yellow,
                          fontWeight: FontWeight.w600,
                          size: 14.0,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OthersSignUp()));
                          },
                          child: FancyText(
                            text: "Sign Up",
                            color: textLight_Red2,
                            fontWeight: FontWeight.w700,
                            size: 14.0,
                          ),
                        ),
                      ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
