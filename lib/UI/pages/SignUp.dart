import 'package:chitwan_hospital/UI/Widget/Forms.dart';
import 'package:chitwan_hospital/UI/Widget/loading.dart';
import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:chitwan_hospital/UI/pages/Home/HomeScreen.dart';
import 'package:chitwan_hospital/UI/pages/Signin/SignIn.dart';
import 'package:chitwan_hospital/service/auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final AuthService _auth = AuthService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email = "", _password = "";
  String error = '';
  bool loading = false;
  bool obscure = true;
  String _name, uid;
  String _phone;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    return loading
        ? Loading()
        : SafeArea(
            child: Scaffold(
              backgroundColor: theme.background,
              body: Stack(
                children: <Widget>[
                  Container(
                      height: size.height,
                      child: Image.asset(
                        "assets/images/img1.jpeg",
                        fit: BoxFit.cover,
                      )),
                  IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: textDark_Yellow,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      }),
                  Center(
                    child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: theme.background,
                              ),
                              width: size.width * 0.90,
                              //height: 110.0,
                              child: Column(children: <Widget>[
                                FForms(
                                  validator: (val) => val.length < 6
                                      ? 'Enter your email'
                                      : null,
                                  onChanged: (val) {
                                    setState(() => _email = val);
                                  },
                                  borderColor: theme.background,
                                  formColor: Colors.white,
                                  text: "Email",
                                  textColor: blueGrey.withOpacity(0.7),
                                  width: size.width * 0.90,
                                ),
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
                                  borderColor: theme.background,
                                  formColor: Colors.white,
                                  text: "Password",
                                  width: size.width * 0.90,
                                ),
                              ]),
                            ),
                            SizedBox(height: 10.0),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: theme.background,
                              ),
                              width: size.width * 0.90,
                              //height: 155.0,
                              child: Column(
                                children: <Widget>[
                                  // SizedBox(height: 10.0),
                                  FForms(
                                    validator: (val) => val.length < 6
                                        ? 'Enter full name'
                                        : null,
                                    onChanged: (val) {
                                      setState(() => _name = val);
                                    },
                                    borderColor: theme.background,
                                    formColor: Colors.white,
                                    text: "Full Name",
                                    textColor: blueGrey.withOpacity(0.7),
                                    width: size.width * 0.90,
                                  ),
                                  FForms(
                                    validator: (val) => val.length < 9
                                        ? 'Enter phone number'
                                        : null,
                                    onChanged: (val) {
                                      setState(() => _phone = val);
                                    },
                                    borderColor: theme.background,
                                    formColor: Colors.white,
                                    text: "Phone Number",
                                    textColor: blueGrey.withOpacity(0.7),
                                    width: size.width * 0.90,
                                  ),
                                  SizedBox(
                                    height: 45.0,
                                    width: size.width * 0.90,
                                    child: RaisedButton(
                                      onPressed: () async {
                                        if (_formKey.currentState.validate()) {
                                          setState(() => loading = true);
                                          dynamic result = await _auth
                                              .registerWithEmailAndPassword(
                                                  _email,
                                                  _password,
                                                  _name,
                                                  _phone);
                                          setState(() => loading = false);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomeScreen()));

                                          if (result == null) {
                                            setState(() {
                                              loading = false;
                                              error =
                                                  'Please supply a valid email';
                                            });
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
                                ],
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  FancyText(
                                    text: "Already have an account? ",
                                    color: textDark_Yellow,
                                    fontWeight: FontWeight.w600,
                                    size: 14.0,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => SignIn()));
                                    },
                                    child: FancyText(
                                      text: "Sign In",
                                      color: textLight_Red2,
                                      fontWeight: FontWeight.w700,
                                      size: 14.0,
                                    ),
                                  ),
                                ]),
                            Text(error),
                          ],
                        )),
                  )
                ],
              ),
            ),
          );
  }
}
