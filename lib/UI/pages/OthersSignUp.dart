import 'package:chitwan_hospital/UI/DoctorsModule/DoctorsModule.dart';
import 'package:chitwan_hospital/UI/HospitalModule/HospitalModule.dart';
import 'package:chitwan_hospital/UI/LabModule/LabModule.dart';
import 'package:chitwan_hospital/UI/PharmacyModule/PharmacyModule.dart';
import 'package:chitwan_hospital/UI/Widget/Forms.dart';
import 'package:chitwan_hospital/UI/Widget/loading.dart';
import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:chitwan_hospital/UI/pages/OthersLogin.dart';
import 'package:chitwan_hospital/service/auth.dart';
import 'package:chitwan_hospital/state/app.dart';
import 'package:flutter/material.dart';

class OthersSignUp extends StatefulWidget {
  @override
  _OthersSignUpState createState() => _OthersSignUpState();
}

class _OthersSignUpState extends State<OthersSignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email = "", _password = "";
  String error = '';
  bool loading = false;
  bool obscure = true;
  String _name, uid;
  String _phone;
  String _othersList;
  List _list = [
    "Doctor",
    //"Ambulance",
    "Pharmacy",
    "Laboratory",
    // "Hospital",
    //"Blood Bank",
  ];
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();

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
              body: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                              child: ListView(shrinkWrap: true, children: <Widget>[
                  Container(
                    height: 70.0,
                    child: Image.asset("assets/images/caduceus.png"),
                  ),
                  SizedBox(height: 20.0),
                  Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5.0),
                                  topRight: Radius.circular(5.0)),
                              color: theme.background,
                            ),
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
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 11.0),
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
                          Column(children: <Widget>[
                            FForms(
                              validator: (val) =>
                                  val.length < 6 ? 'Enter your email' : null,
                              onChanged: (val) {
                                setState(() => _email = val);
                              },
                              textInputAction: TextInputAction.next,
                              currentFocus: _emailFocus,
                              nextFocus: _passwordFocus,
                              underline: true,
                              formColor: Colors.white,
                              text: "Email",
                              textColor: blueGrey.withOpacity(0.7),
                              width: size.width * 0.90,
                            ),
                            SizedBox(height: 5.0),
                            FForms(
                              validator: (val) => val.length < 6
                                  ? 'Enter a password 6+ chars long'
                                  : null,
                              onChanged: (val) {
                                setState(() => _password = val);
                              },
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
                              textInputAction: TextInputAction.next,
                              currentFocus: _passwordFocus,
                              nextFocus: _nameFocus,
                              underline: true,
                              formColor: Colors.white,
                              textColor: blueGrey.withOpacity(0.7),
                              text: "Password",
                              width: size.width * 0.90,
                            ),
                            SizedBox(height: 5.0),
                            FForms(
                              textInputAction: TextInputAction.next,
                              currentFocus: _nameFocus,
                              nextFocus: _phoneFocus,
                              validator: (val) =>
                                  val.length < 6 ? 'Enter full name' : null,
                              onChanged: (val) {
                                setState(() => _name = val);
                              },
                              underline: true,
                              formColor: Colors.white,
                              text: "Full Name",
                              textColor: blueGrey.withOpacity(0.7),
                              width: size.width * 0.90,
                            ),
                            SizedBox(height: 5.0),
                            FForms(
                              textInputAction: TextInputAction.done,
                              type: TextInputType.number,
                              currentFocus: _phoneFocus,
                              validator: (val) =>
                                  val.length < 9 ? 'Enter phone number' : null,
                              onChanged: (val) {
                                setState(() => _phone = val);
                              },
                              underline: true,
                              formColor: Colors.white,
                              text: "Phone Number",
                              textColor: blueGrey.withOpacity(0.7),
                              width: size.width * 0.90,
                            ),
                            SizedBox(height:5.0),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical:18.0),
                              child: SizedBox(
                                height: 45.0,
                                width: size.width * 0.90,
                                child: RaisedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      setState(() => loading = true);
                                      print(_othersList);
                                      dynamic result;
                                      if (_othersList == 'Hospital') {
                                        result =
                                            await AuthService.registerHospital(
                                                email: _email,
                                                password: _password,
                                                name: _name,
                                                phone: _phone);
                                        if (result != null) {
                                          setLocalUserData(
                                              'userType', 'hospital');
                                          setState(() => loading = false);
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HospitalModule()),
                                              (Route<dynamic> route) => false);
                                        } else {
                                          setState(() {
                                            loading = false;
                                            error = 'Please supply a valid email';
                                          });
                                        }
                                      } else if (_othersList == 'Doctor') {
                                        result = await AuthService.registerDoctor(
                                            email: _email,
                                            password: _password,
                                            name: _name,
                                            phone: _phone);
                                        if (result != null) {
                                          setLocalUserData('userType', 'doctor');
                                          setState(() => loading = false);
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DoctorsModule()),
                                              (Route<dynamic> route) => false);
                                        } else {
                                          setState(() {
                                            loading = false;
                                            error = 'Please supply a valid email';
                                          });
                                        }
                                      } else if (_othersList == 'Pharmacy') {
                                        result =
                                            await AuthService.registerPharmacy(
                                                email: _email,
                                                password: _password,
                                                name: _name,
                                                phone: _phone);
                                        if (result != null) {
                                          setLocalUserData(
                                              'userType', 'pharmacy');
                                          setState(() => loading = false);
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PharmacyModule()),
                                              (Route<dynamic> route) => false);
                                        } else {
                                          setState(() {
                                            loading = false;
                                            error = 'Please supply a valid email';
                                          });
                                        }
                                      } else if (_othersList == 'Laboratory') {
                                        result = await AuthService.registerLab(
                                            email: _email,
                                            password: _password,
                                            name: _name,
                                            phone: _phone);
                                        if (result != null) {
                                          setLocalUserData('userType', 'lab');
                                          setState(() => loading = false);
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LabModule()),
                                              (Route<dynamic> route) => false);
                                        } else {
                                          setState(() {
                                            loading = false;
                                            error = 'Please supply a valid email';
                                          });
                                        }
                                      }
                                    }
                                  },
                                  color: theme.primary,
                                  child: FancyText(
                                    text: "SUBMIT",
                                    size: 16.0,
                                    color: textDark_Yellow,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OthersLogin()));
                            },
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  FancyText(
                                    text: "Already have an account? ",
                                    color: Colors.black38,
                                    fontWeight: FontWeight.w600,
                                    size: 14.0,
                                  ),
                                  FancyText(
                                    text: "Sign In",
                                    color: blueGrey,
                                    fontWeight: FontWeight.w700,
                                    size: 14.0,
                                  ),
                                ]),
                          ),
                          error == ''
                              ? Text(" ")
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      padding: EdgeInsets.all(8.0),
                                      color: theme.secondary,
                                      child: FancyText(
                                          text: error, color: Colors.white)),
                                ),
                        ],
                      ))
                ]),
              ),
            ),
          );
  }
}
