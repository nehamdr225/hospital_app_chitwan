import 'package:chitwan_hospital/UI/Widget/Forms.dart';
import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:chitwan_hospital/UI/pages/Home/HomeScreen.dart';
import 'package:chitwan_hospital/models/HospitalInquiry.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chitwan_hospital/service/auth.dart';

class HospitalInquiryForm extends StatefulWidget {
  final HospitalInquiry hospitalInquiryForm;
  HospitalInquiryForm({@required this.hospitalInquiryForm});
  @override
  _HospitalInquiryFormState createState() => _HospitalInquiryFormState();
}

class _HospitalInquiryFormState extends State<HospitalInquiryForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final db = Firestore.instance;
  String _phoneNum;
  String _inquiry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: WhiteAppBar(
              titleColor: theme.colorScheme.primary, title: "Inquiry")),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Padding(
              //phone number
              padding: const EdgeInsets.all(10.0),
              child: FForms(
                icon: Icon(
                  Icons.phone,
                  color: theme.iconTheme.color,
                ),
                text: "Phone Number",
                type: TextInputType.phone,
                //width: width * 0.80,
                borderColor: theme.colorScheme.primary,
                formColor: Colors.white,
                textColor: blueGrey.withOpacity(0.7),
                validator: (val) => val.isEmpty || val.length < 8
                    ? 'Phone Number is required'
                    : null,
                onSaved: (value) {
                  _phoneNum = value;
                },
              ),
            ),
            Padding(
              //inquiry
              padding: const EdgeInsets.all(10.0),
              child: FForms(
                icon: Icon(
                  Icons.map,
                  color: theme.iconTheme.color,
                ),
                text: "Inquiry",
                type: TextInputType.text,
                //width: width * 0.80,
                borderColor: theme.colorScheme.primary,
                formColor: Colors.white,
                textColor: blueGrey.withOpacity(0.7),
                validator: (val) => val.isEmpty || val.length < 10
                    ? 'Please type your inquiry'
                    : null,
                onSaved: (value) {
                  _inquiry = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                height: 45.0,
                child: RaisedButton(
                  color: theme.colorScheme.primary,
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
                    widget.hospitalInquiryForm.phoneNum = _phoneNum;
                    widget.hospitalInquiryForm.inquiry = _inquiry;

                    final uid = await AuthService.getCurrentUID();
                    await db
                        .collection("users")
                        .document(uid)
                        .collection("hospitalInquiry")
                        .add(widget.hospitalInquiryForm.toJson());
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
