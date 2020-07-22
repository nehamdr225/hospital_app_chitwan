import 'package:chitwan_hospital/UI/core/atoms/Indicator.dart';
import 'package:chitwan_hospital/UI/core/atoms/RaisedButtons.dart';
import 'package:chitwan_hospital/UI/core/atoms/SnackBar.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:chitwan_hospital/UI/pages/SignIn/SignIn.dart';
import 'package:chitwan_hospital/service/auth.dart';
import 'package:flutter/material.dart';

import 'Widget/Forms.dart';
import 'core/atoms/AppBarW.dart';

class ResetPassword extends StatefulWidget {
  final email, signout;
  ResetPassword({this.email, this.signout});

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  String localEmail;
  bool isActive = false;

  @override
  void initState() {
    super.initState();
    if (widget.email != null)
      setState(() {
        localEmail = widget.email;
      });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: AppBarW(
              title: "Reset Password",
              backButtonColor: textDark_Yellow,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          backgroundColor: textDark_Yellow,
          body: ListView(
            children: <Widget>[
              BoolIndicator(isActive),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                child: FForms(
                  initialValue: localEmail ?? '',
                  textInputAction: TextInputAction.next,
                  borderColor: blueGrey,
                  formColor: Colors.white,
                  text: "Enter your email address",
                  textColor: blueGrey.withOpacity(0.7),
                  width: size.width * 0.90,
                  validator: (val) => val.isEmpty ? 'Enter password' : null,
                  onChanged: (value) {
                    setState(() {
                      localEmail = value;
                    });
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                child: FRaisedButton(
                  text: 'Reset Password',
                  bgcolor: theme.primaryVariant,
                  color: textDark_Yellow,
                  onPressed: localEmail != null &&
                          localEmail.length > 8 &&
                          !isActive
                      ? () {
                          setState(() {
                            isActive = true;
                          });
                          print(localEmail);
                          // return;
                          AuthService.resetPassword(widget.email ?? localEmail)
                              .then((value) async {
                            setState(() {
                              isActive = false;
                            });
                            buildAndShowFlushBar(
                                context: context,
                                backgroundColor: theme.primaryVariant,
                                icon: Icons.check,
                                text:
                                    'Password reset link has been emailed to you!');
                            await Future.delayed(Duration(seconds: 2));
                            if (widget.signout != null) {
                              AuthService.signOut();
                              widget.signout();
                            }
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => SignIn(),
                                ),
                                (route) => false);
                          });
                        }
                      : null,
                ),
              ),
            ],
          )),
    );
  }
}
