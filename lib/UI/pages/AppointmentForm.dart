import 'package:chitwan_hospital/UI/Widget/Forns.dart';
import 'package:chitwan_hospital/UI/Widget/InputForm.dart';
import 'package:chitwan_hospital/UI/core/atoms/RaisedButtons.dart';
import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:flutter/material.dart';

class AppointmentForm extends StatefulWidget {
  @override
  _AppointmentFormState createState() => _AppointmentFormState();
}

class _AppointmentFormState extends State<AppointmentForm> {
  List name = [];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var width = MediaQuery.of(context).size.width;
    // final user = Provider.of<UserModel>(context);
    // final userData = user.user;

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: WhiteAppBar(title: "Appointment Form")),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                FForms(
                  borderColor: theme.colorScheme.primary,
                  formColor: theme.colorScheme.background,
                  text: "First Name",
                  textColor: blueGrey.withOpacity(0.7),
                  height: 40.0,
                  width: width * 0.40,
                ),
                SizedBox(width: 10.0),
                FForms(
                  borderColor: theme.colorScheme.primary,
                  formColor: theme.colorScheme.background,
                  text: "Last Name",
                  textColor: blueGrey.withOpacity(0.7),
                  height: 40.0,
                  width: width * 0.50,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: InputField(
              //value: userData['email'],
              title: 'Email',
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            child: InputField(
              //value: userData['contact'],
              title: 'Contact',
            ),
          ),
          Container(
            alignment: Alignment.topRight,
            child: OutlineButton(
              child: Text(
                'Save Changes',
                style: TextStyle(fontSize: 18.0, color: textDark),
              ),
              onPressed: null,
              // () {
              // Navigator.push(context,
              //           MaterialPageRoute(builder: (context) => ChangePassword()));
              // },
              // fontSize: 20.0,
              // fontWeight: FontWeight.w600,
              // height: 50.0,
              // elevation: 0.0,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          FRaisedButton(
            text: 'Change Password',
            color: textDark,
            bgcolor: Colors.white,
            width: width * 0.50,
            fontSize: 15.0,
            fontWeight: FontWeight.w700,
            height: 45.0,
            elevation: 0.0,
            onPressed: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => ResetPage()));
            },
          ),
          FRaisedButton(
            text: 'Deactivate Account',
            color: textDark,
            bgcolor: Colors.white,
            width: width * 0.50,
            fontSize: 15.0,
            fontWeight: FontWeight.w700,
            height: 45.0,
            elevation: 0.0,
            onPressed: () {
              // Navigator.push(context,
              //           MaterialPageRoute(builder: (context) => ChangePassword()));
            },
          ),
          FRaisedButton(
            text: 'Delete Account',
            color: textDark,
            bgcolor: Colors.white,
            width: width * 0.50,
            fontSize: 15.0,
            fontWeight: FontWeight.w700,
            height: 45.0,
            elevation: 0.0,
            onPressed: () {
              // Navigator.push(context,
              //           MaterialPageRoute(builder: (context) => ChangePassword()));
            },
          ),
        ],
      ),
    );
  }
}
