import 'package:chitwan_hospital/UI/Widget/FRaisedButton.dart';
import 'package:chitwan_hospital/UI/Widget/Forms.dart';
import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/atoms/Indicator.dart';
import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:chitwan_hospital/state/hospital.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HospitalInquiryDetail extends StatefulWidget {
  final id;
  HospitalInquiryDetail({Key key, this.id}) : super(key: key);

  @override
  _HospitalInquiryDetailState createState() => _HospitalInquiryDetailState();
}

class _HospitalInquiryDetailState extends State<HospitalInquiryDetail> {
  String inquiryAnswer;
  bool isActive = false;
  @override
  Widget build(BuildContext context) {
    final hospitalDataStore = Provider.of<HospitalDataStore>(context);
    final inquiry = hospitalDataStore.inquiries
        .firstWhere((element) => element.id == widget.id);

    return Scaffold(
      appBar: PreferredSize(
          child: WhiteAppBar(
            title: inquiry.phone,
            titleColor: Theme.of(context).colorScheme.primaryVariant,
          ),
          preferredSize: Size.fromHeight(50.0)),
      backgroundColor: Theme.of(context).colorScheme.background,
      persistentFooterButtons: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: FRaisedButton(
              height: 45.0,
              width: MediaQuery.of(context).size.width,
              text: 'Answer Inquiry',
              color: textDark_Yellow,
              bg: Theme.of(context).colorScheme.primaryVariant,
              onPressed: inquiryAnswer != null && inquiryAnswer.length > 20
                  ? () {
                      setState(() {
                        isActive = true;
                      });
                    }
                  : null),
        ),
      ],
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 18.0),
        child: ListView(children: <Widget>[
          BoolIndicator(isActive),
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
          FForms(
            text: 'Inquiry Answer',
            maxLines: 10,
            minLines: 2,
            textColor: Theme.of(context).colorScheme.primaryVariant,
            borderColor: Theme.of(context).colorScheme.primaryVariant,
            validator: (val) => val.length < 20
                ? 'Answer must be more than 20 charatcers!'
                : null,
          )
        ]),
      ),
    );
  }
}
