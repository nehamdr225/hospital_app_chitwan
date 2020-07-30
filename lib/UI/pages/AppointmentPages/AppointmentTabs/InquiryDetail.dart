import 'package:eMed/UI/core/atoms/FancyText.dart';
import 'package:eMed/UI/core/atoms/WhiteAppBar.dart';
import 'package:eMed/state/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InquiryDetail extends StatelessWidget {
  final id;
  InquiryDetail({this.id});
  @override
  Widget build(BuildContext context) {
    final inquiry = Provider.of<UserDataStore>(context)
        .inquiries
        .firstWhere((element) => element.id == id);

    return Scaffold(
      appBar: PreferredSize(
          child: WhiteAppBar(
            title: inquiry.hospitalName,
            titleColor: Theme.of(context).colorScheme.primaryVariant,
          ),
          preferredSize: Size.fromHeight(50.0)),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 18.0),
        child: ListView(children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.title),
              // FancyText(
              //   text: '(Title)',
              // ),
              SizedBox(width: 10.0),
              FancyText(
                text: inquiry.title,
                textOverflow: TextOverflow.visible,
                fontWeight: FontWeight.w600,
                size: 18.0,
                textAlign: TextAlign.left,
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            children: <Widget>[
              SizedBox(width: 2.0),
              Icon(
                Icons.chat_bubble_outline,
                size: 20.0,
              ),
              // FancyText(
              //   text: '(Inquiry)',
              // ),
              SizedBox(width: 10.0),
              FancyText(
                text: inquiry.inquiry,
                textOverflow: TextOverflow.visible,
                fontWeight: FontWeight.w400,
                size: 15.0,
                textAlign: TextAlign.left,
              ),
            ],
          ),
          SizedBox(height: 30.0),
          FancyText(
            text: inquiry.answer ??
                'This inquiry is yet to be answered. Thank you for your patience!',
            textOverflow: TextOverflow.visible,
            fontWeight: FontWeight.w700,
            size: 15.5,
            textAlign: TextAlign.left,
          )
        ]),
      ),
    );
  }
}
