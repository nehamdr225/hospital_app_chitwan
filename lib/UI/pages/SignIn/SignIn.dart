import 'package:chitwan_hospital/UI/Widget/Forms.dart';
import 'package:chitwan_hospital/UI/Widget/loading.dart';
import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:chitwan_hospital/UI/pages/Home/HomeScreen.dart';
import 'package:chitwan_hospital/UI/pages/OthersLogin.dart';
import 'package:chitwan_hospital/UI/pages/SignUp.dart';
import 'package:chitwan_hospital/UI/resetPassword.dart';
import 'package:chitwan_hospital/service/auth.dart';
import 'package:chitwan_hospital/state/app.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  bool obscure = true;
  String email = '';
  String password = '';
  String error = '';
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;

    handleSignIn() async {
      try {
        if (_formKey.currentState.validate()) {
          setState(() {
            loading = true;
          });
          _formKey.currentState.save();
          dynamic result =
              await AuthService.signInWithEmailAndPassword(email, password);
          // setState(() {
          // loading = false;
          // });
          if (result == null) {
            setState(() {
              loading = false;
              error = 'Could not sign in with those credentials';
            });
          } else {
            // userDataStore.fetchUserData(result.uid);
            setLocalUserData('userType', 'user');
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
                (Route<dynamic> route) => false);
          }
        }
      } catch (e) {
        setState(() {
          loading = false;
          error = 'Could not sign in with those credentials';
        });
      }
    }

    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: theme.background,
            appBar: PreferredSize(
                child: WhiteAppBar(
                  color: theme.background,
                ),
                preferredSize: Size.fromHeight(50.0)),
            body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: theme.background,
                ),
                child: ListView(
                  children: <Widget>[
                    Container(
                      height: 70.0,
                      width: 70.0,
                      child: Image.asset("assets/images/caduceus.png"),
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
                            SizedBox(height: 10.0),
                            FForms(
                              textInputAction: TextInputAction.next,
                              currentFocus: _emailFocus,
                              nextFocus: _passwordFocus,
                              underline: true,
                              // borderColor: theme.primary,
                              formColor: Colors.white,
                              text: "Email",
                              textColor: Colors.black38,
                              width: size.width * 0.90,
                              validator: (val) =>
                                  val.isEmpty ? 'Enter an email' : null,
                              onChanged: (val) {
                                setState(() => email = val);
                              },
                            ),
                            SizedBox(height: 5.0),
                            FForms(
                              textInputAction: TextInputAction.done,
                              currentFocus: _passwordFocus,
                              // borderColor: theme.background,
                              underline: true,
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
                              textColor: Colors.black38,
                              width: size.width * 0.90,
                              validator: (val) => val.length < 6
                                  ? 'Enter a password 6+ chars long'
                                  : null,
                              onChanged: (val) {
                                setState(() => password = val);
                              },
                            ),
                            SizedBox(height: 5.0),
                            Container(
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 18.0, horizontal: 18.0),
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
                                onPressed: handleSignIn,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
                                        builder: (context) => SignUp()));
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
                              text: "Login As ",
                              color: textLight_Red2,
                              fontWeight: FontWeight.w800,
                              size: 14.0,
                            ),
                            FancyText(
                              text: "others",
                              color: Colors.black38,
                              fontWeight: FontWeight.w500,
                              size: 14.0,
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
                          )
                  ],
                ),
              ),
            ),
          );
  }
}
