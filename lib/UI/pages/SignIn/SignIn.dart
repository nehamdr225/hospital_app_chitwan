import 'package:chitwan_hospital/UI/Widget/Forms.dart';
import 'package:chitwan_hospital/UI/Widget/loading.dart';
import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:chitwan_hospital/UI/pages/Home/HomeScreen.dart';
import 'package:chitwan_hospital/UI/pages/OthersLogin.dart';
import 'package:chitwan_hospital/UI/pages/SignUp.dart';
import 'package:chitwan_hospital/service/auth.dart';
import 'package:chitwan_hospital/state/app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chitwan_hospital/state/store.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
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
    final userDataStore = Provider.of<UserDataStore>(context);

    handleSignIn() async {
      try {
        if (_formKey.currentState.validate()) {
          setState(() {
            loading = true;
          });
          _formKey.currentState.save();
          dynamic result =
              await _auth.signInWithEmailAndPassword(email, password);
          setState(() {
            loading = false;
          });
          if (result == null) {
            setState(() {
              error = 'Could not sign in with those credentials';
            });
          } else {
            userDataStore.uid = result.uid;
            userDataStore.type = 'user';
            userDataStore.fetchUserData();
            setLocalUserData('userType', 'user');
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
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
            body: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      alignment: Alignment.center,
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/img1.jpeg"))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
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
                            textInputAction: TextInputAction.next,
                            currentFocus: _emailFocus,
                            nextFocus: _passwordFocus,
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
                            textInputAction: TextInputAction.done,
                            currentFocus: _passwordFocus,
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
                              onPressed: handleSignIn,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  InkWell(
                     onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUp()));
                            },
                    child: Container(
                       padding: EdgeInsets.all(8.0),
                      color: Colors.black38,
                      width: 250.0,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FancyText(
                              text: "Don't have an account? ",
                              color: textDark_Yellow,
                              fontWeight: FontWeight.w600,
                              size: 14.0,
                            ),
                            FancyText(
                              text: "Sign Up",
                              color: textLight_Red2,
                              fontWeight: FontWeight.w700,
                              size: 14.0,
                            ),
                          ]),
                    ),
                  ),
                  SizedBox(height:10.0),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OthersLogin()));
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      color: Colors.black38,
                      width: 150.0,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FancyText(
                              text: "Login As ",
                              color: textLight_Red2,
                              fontWeight: FontWeight.w700,
                              size: 14.0,
                            ),
                            FancyText(
                              text: "others",
                              color: textDark_Yellow,
                              fontWeight: FontWeight.w600,
                              size: 14.0,
                            ),
                          ]),
                    ),
                  ),
                  error == '' ?
                            Container(child: Text(" ")):Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              padding: EdgeInsets.all(8.0),
                              color: theme.secondary,
                              child:
                                  FancyText(text: error, color: Colors.white)),
                        )
                     
                ],
              ),
            ),
          );
  }
}
