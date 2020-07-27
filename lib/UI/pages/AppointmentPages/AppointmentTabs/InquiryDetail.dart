import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:flutter/material.dart';

class InquiryDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: WhiteAppBar(), preferredSize: Size.fromHeight(50.0)),
          backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 18.0),
              child: ListView(children: <Widget>[
          FancyText(
            text: "Title",
            textOverflow: TextOverflow.ellipsis,
            fontWeight: FontWeight.w700,
            size: 16.0,
            textAlign: TextAlign.left,
          ),
          FancyText(
            text: "Description: ",
            textOverflow: TextOverflow.ellipsis,
            fontWeight: FontWeight.w400,
            size: 15.0,
            textAlign: TextAlign.left,
          ),
          FancyText(
            text: "Reply: ",
            textOverflow: TextOverflow.ellipsis,
            fontWeight: FontWeight.w700,
            size: 15.5,
            textAlign: TextAlign.left,
          )
        ]),
      ),
    );
  }
}
