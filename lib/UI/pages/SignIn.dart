import 'package:chitwan_hospital/UI/Widget/Forms.dart';
import 'package:chitwan_hospital/UI/Widget/loading.dart';
import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:chitwan_hospital/UI/pages/Home/HomeScreen.dart';
import 'package:chitwan_hospital/UI/pages/LoginAs.dart';
import 'package:chitwan_hospital/UI/pages/SignUp.dart';
import 'package:chitwan_hospital/service/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;
  bool signedIn = false;
  bool obscure = true;

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
                      onPressed: signedIn == false
                          ? () {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        content: FancyText(
                                          text: "Please Sign In first!",
                                          defaultStyle: true,
                                          fontWeight: FontWeight.w700,
                                          size: 17.0,
                                          opacity: 1.0,
                                        ),
                                        actions: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: InkWell(
                                              child: FancyText(
                                                text: "OK",
                                                fontWeight: FontWeight.w900,
                                                color: Colors.green[800],
                                                size: 15.0,
                                              ),
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          )
                                        ],
                                      ));
                            }
                          : () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()));
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
                                  height: 60.0,
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
                                  height: 60.0,
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
                                        setState(() {
                                          loading = false;
                                          signedIn = true;
                                        });
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomeScreen()));

                                        if (result == null) {
                                          setState(() {
                                            loading = false;
                                            signedIn = false;
                                            error =
                                                'Could not sign in with those credentials';
                                          });
                                        }
                                      }
                                      //Navigator.pop(context);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
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
                                          builder: (context) => SignUp()));
                                },
                                child: FancyText(
                                  text: "Sign Up",
                                  color: textLight_Red2,
                                  fontWeight: FontWeight.w700,
                                  size: 14.0,
                                ),
                              ),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginAs()));
                                },
                                child: FancyText(
                                  text: "Login As ",
                                  color: textLight_Red2,
                                  fontWeight: FontWeight.w700,
                                  size: 14.0,
                                ),
                              ),
                              FancyText(
                                text: "others",
                                color: textDark_Yellow,
                                fontWeight: FontWeight.w600,
                                size: 14.0,
                              ),
                            ]),
                        Text(error),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
