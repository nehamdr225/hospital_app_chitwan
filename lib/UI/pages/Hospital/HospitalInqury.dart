import 'package:chitwan_hospital/UI/Widget/Forms.dart';
import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:chitwan_hospital/UI/pages/Home/HomeScreen.dart';
import 'package:chitwan_hospital/models/HospitalInquiry.dart';
import 'package:chitwan_hospital/state/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HospitalInquiryForm extends StatefulWidget {
  final id;
  HospitalInquiryForm({@required this.id});
  @override
  _HospitalInquiryFormState createState() => _HospitalInquiryFormState();
}

class _HospitalInquiryFormState extends State<HospitalInquiryForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  HospitalInquiry inquiry = HospitalInquiry();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final userDataStore = Provider.of<UserDataStore>(context);
    if (inquiry.hospitalId == null) {
      setState(() {
        inquiry.hospitalId = widget.id;
        inquiry.userId = userDataStore.user?.uid;
        inquiry.phone = userDataStore.user?.phone;
      });
    }
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: WhiteAppBar(
              titleColor: theme.colorScheme.primary, title: "Inquiry")),
      backgroundColor: Theme.of(context).colorScheme.background,
      persistentFooterButtons: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: SizedBox(
            height: 45.0,
            width: MediaQuery.of(context).size.width,
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
              onPressed: _formKey.currentState != null &&
                      _formKey.currentState.validate()
                  ? () async {
                      if (!_formKey.currentState.validate()) {
                        return;
                      }
                      _formKey.currentState.save();
                      print(inquiry.toJson());
                      return;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    }
                  : null,
            ),
          ),
        )
      ],
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
                initialValue: inquiry.phone ?? '',
                text: "Phone Number",
                type: TextInputType.phone,
                //width: width * 0.80,
                borderColor: theme.colorScheme.primary,
                formColor: Colors.white,
                textColor: blueGrey.withOpacity(0.7),
                validator: (val) => val.isEmpty || val.length < 8
                    ? 'Phone Number is required'
                    : null,
                onChanged: (value) {
                  setState(() {
                    inquiry.phone = value;
                  });
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
                maxLines: 5,
                text: "Inquiry",
                type: TextInputType.text,
                //width: width * 0.80,
                borderColor: theme.colorScheme.primary,
                formColor: Colors.white,
                textColor: blueGrey.withOpacity(0.7),
                validator: (val) => val.isEmpty || val.length < 20
                    ? 'Inquiry must be longer than 20 characters!'
                    : null,
                onChanged: (value) {
                  setState(() {
                    inquiry.inquiry = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
