import 'dart:ui';
import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:chitwan_hospital/UI/pages/Home/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HospitalDetails extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final String name;
  final String phone;
  HospitalDetails({this.phone, this.name});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        child: WhiteAppBar(
          title: "Inquiry",
          titleColor: theme.primary,
        ),
        preferredSize: Size.fromHeight(40.0),
      ),
      backgroundColor: theme.background,
      
      body: ListView(children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: FancyText(
            text: name,
            textAlign: TextAlign.center,
            size: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: FancyText(
            text: phone,
            textAlign: TextAlign.center,
            size: 15.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 10.0, top: 10.0, bottom: 20.0, right: 10.0),
          child: FancyText(
              text:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
              textAlign: TextAlign.justify,
              size: 16.0,
              fontWeight: FontWeight.normal,
              defaultStyle: false,
              letterSpacing: 0.7),
        ),
        Padding(
            padding: const EdgeInsets.only(
                left: 10.0, top: 20.0, bottom: 20.0, right: 10.0),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: theme.primary, width: 0.5),
                  borderRadius: BorderRadius.circular(5.0)),
              height: 150.0,
              width: size.width * 0.95,
              child: CupertinoTextField(
                keyboardType: TextInputType.multiline,
                textAlignVertical: TextAlignVertical.top,
                maxLines: null,
                placeholder: "Your Reply !",
              ),
            )),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                height: 45.0,
                child: RaisedButton(
                  color: theme.primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0)),
                  child: FancyText(
                    text: "SUBMIT",
                    size: 16.0,
                    color: textDark_Yellow,
                    fontWeight: FontWeight.w600,
                  ),
                  onPressed: () async {
                    if (!_formKey.currentState.validate()) {
                      return;
                    }
                    _formKey.currentState.save();
                    
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                ),
              ),
            )
      ]),
    );
  }
}
