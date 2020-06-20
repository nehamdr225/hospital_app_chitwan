import 'package:chitwan_hospital/UI/HospitalModule/InquiryReply.dart';
import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:flutter/material.dart';

class HospitalDetails extends StatelessWidget {
  final String name;
  final String phone;
  HospitalDetails({this.phone, this.name});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: PreferredSize(
        child: WhiteAppBar(
          title: "Inquiry",
          titleColor: theme.primary,
        ),
        preferredSize: Size.fromHeight(40.0),
      ),
      backgroundColor: theme.background,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => InquiryReply()));
          },
          icon: Icon(Icons.calendar_today, color: textDark_Yellow,),
          label: FancyText(
            text: "Diagnosis",
            color: textDark_Yellow,
            fontWeight: FontWeight.w600,
          ),
          backgroundColor: theme.primary,
        ),
      body: ListView(children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top:20.0),
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
          padding: const EdgeInsets.only(left:10.0, top: 20.0, bottom: 20.0, right: 10.0),
          child: FancyText(
            text: "This is the place for inquiry.",
            textAlign: TextAlign.justify,
            size: 16.0,
            fontWeight: FontWeight.normal,
            defaultStyle: false,
            letterSpacing: 1.0
          ),
        ),
      ]),
    );
  }
}
