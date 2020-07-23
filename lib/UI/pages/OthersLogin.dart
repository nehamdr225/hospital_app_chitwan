import 'package:chitwan_hospital/UI/HospitalModule/HospitalModule.dart';
import 'package:chitwan_hospital/UI/LabModule/LabModule.dart';
import 'package:chitwan_hospital/UI/PharmacyModule/PharmacyModule.dart';
import 'package:chitwan_hospital/UI/Widget/Forms.dart';
import 'package:chitwan_hospital/UI/Widget/loading.dart';
import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:chitwan_hospital/UI/DoctorsModule/DoctorsModule.dart';
import 'package:chitwan_hospital/UI/pages/OthersSignUp.dart';
import 'package:chitwan_hospital/service/auth.dart';
import 'package:chitwan_hospital/state/app.dart';
import 'package:flutter/material.dart';

import '../resetPassword.dart';

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
    // "Ambulance",
    "Pharmacy",
    "Laboratory",
    "Hospital",
    //"Blood Bank",
  ];

  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;
  bool signedIn = false;
  bool obscure = true;
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    return loading
        ? Loading()
        : SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: theme.background,
              appBar: PreferredSize(
                  child: WhiteAppBar(), preferredSize: Size.fromHeight(50.0)),
              body: Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 70.0,
                      width: 70.0,
                      child: Image.asset("assets/images/caduceus.png"),
                    ),
                    SizedBox(height: 15.0),
                    Container(
                      color: theme.background,
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
                            FForms(
                              textInputAction: TextInputAction.next,
                              // borderColor: theme.background,
                              underline: true,
                              formColor: Colors.white,
                              text: "Email",
                              currentFocus: _emailFocus,
                              nextFocus: _passwordFocus,
                              textColor: blueGrey.withOpacity(0.7),
                              width: size.width * 0.90,
                              validator: (val) =>
                                  val.isEmpty ? 'Enter an email' : null,
                              onChanged: (val) {
                                setState(() => email = val);
                              },
                            ),
                            SizedBox(height: 10.0),
                            FForms(
                              textInputAction: TextInputAction.done,
                              // borderColor: theme.background,
                              underline: true,
                              formColor: Colors.white,
                              text: "Password",
                              currentFocus: _passwordFocus,
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
                            Container(
                              alignment: Alignment.centerRight,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 18.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ResetPassword()));
                                },
                                child: FancyText(
                                  text: "Forgot Password?",
                                  color: Colors.black38,
                                  fontWeight: FontWeight.w800,
                                  size: 14.0,
                                ),
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
                                    if (_formKey.currentState.validate()) {
                                      setState(() {
                                        loading = true;
                                      });
                                      // Scaffold.of(context).showSnackBar(
                                      //     SnackBar(
                                      //         content:
                                      //             Text('Processing Data')));
                                      _formKey.currentState.save();
                                      dynamic result = await AuthService
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
                                          setLocalUserData(
                                              'userType', 'doctor');
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DoctorsModule()),
                                              (Route<dynamic> route) => false);
                                        } else if (_othersList == 'Pharmacy') {
                                          setLocalUserData(
                                              'userType', 'pharmacy');
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PharmacyModule()),
                                              (Route<dynamic> route) => false);
                                        } else if (_othersList ==
                                            'Laboratory') {
                                          setLocalUserData('userType', 'lab');
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LabModule()),
                                              (Route<dynamic> route) => false);
                                        } else if (_othersList == 'Hospital') {
                                          setLocalUserData(
                                              'userType', 'hospital');
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HospitalModule()),
                                              (Route<dynamic> route) => false);
                                        } else if (_othersList == null) {
                                          setState(() {
                                            loading = false;
                                            signedIn = false;
                                            error = 'Select your department';
                                          });
                                        }
                                      }
                                    }
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FancyText(
                              text: "New User?  ",
                              color: Colors.black38,
                              fontWeight: FontWeight.w800,
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
                                text: "Register",
                                color: blueGrey,
                                fontWeight: FontWeight.w700,
                                size: 14.0,
                              ),
                            ),
                          ]),
                    ),
                    error == ''
                        ? Container(child: Text(" "))
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                padding: EdgeInsets.all(8.0),
                                color: theme.secondary,
                                child: FancyText(
                                    text: error, color: Colors.white)),
                          ),
                  ],
                ),
              ),
            ),
          );
  }
}
