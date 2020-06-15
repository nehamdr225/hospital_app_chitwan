import 'package:chitwan_hospital/UI/Widget/Forms.dart';
import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:chitwan_hospital/UI/pages/Home/HomeScreen.dart';
import 'package:chitwan_hospital/service/BloodRequest.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chitwan_hospital/service/auth.dart';

class BloodBankForm extends StatefulWidget {
  final BloodRequest bloodRequestForm;
  BloodBankForm({@required this.bloodRequestForm});
  @override
  _BloodBankFormState createState() => _BloodBankFormState();
}

class _BloodBankFormState extends State<BloodBankForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final db = Firestore.instance;
  List name = [];
  String _fName;
  String _lName;
  String _fPhone;
  String _fAddress;
  String _bGroup;
  List _group = [
    "A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"
  ];

  @override
  Widget build(BuildContext context) {
    TextEditingController _textController = new TextEditingController();
    _textController.text = widget.bloodRequestForm.firstName;
    final theme = Theme.of(context);
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: WhiteAppBar(
              titleColor: theme.colorScheme.primary, title: "Request Blood")),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Container(
              // first and last name
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  FForms(
                    borderColor: theme.colorScheme.primary,
                    formColor: Colors.white,
                    text: "First Name",
                    textColor: blueGrey.withOpacity(0.7),
                    width: width * 0.40,
                    // validator: (val) =>
                    //     val.isEmpty ? 'First Name is required' : null,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'First Name is Reqired';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _fName = value;
                    },
                  ),
                  SizedBox(width: 10.0),
                  FForms(
                    borderColor: theme.colorScheme.primary,
                    formColor: Colors.white,
                    text: "Last Name",
                    type: TextInputType.text,
                    textColor: blueGrey.withOpacity(0.7),
                    width: width * 0.515,
                    validator: (val) =>
                        val.isEmpty ? 'Last Name is required' : null,
                    onSaved: (value) {
                      _lName = value;
                    },
                  )
                ],
              ),
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
                  _fPhone = value;
                },
              ),
            ),
            Padding(
              //phone number
              padding: const EdgeInsets.all(10.0),
              child: FForms(
                icon: Icon(
                  Icons.map,
                  color: theme.iconTheme.color,
                ),
                text: "Address",
                type: TextInputType.text,
                //width: width * 0.80,
                borderColor: theme.colorScheme.primary,
                formColor: Colors.white,
                textColor: blueGrey.withOpacity(0.7),
                validator: (val) => val.isEmpty || val.length < 10
                    ? 'Your Address is required'
                    : null,
                onSaved: (value) {
                  _fAddress = value;
                },
              ),
            ),
            Padding(
              //phone number
              padding: const EdgeInsets.all(10.0),
              child: FForms(
                icon: Icon(
                  Icons.question_answer,
                  color: theme.iconTheme.color,
                ),
                text: "Reason",
                type: TextInputType.text,
                //width: width * 0.80,
                borderColor: theme.colorScheme.primary,
                formColor: Colors.white,
                textColor: blueGrey.withOpacity(0.7),
                validator: (val) => val.isEmpty || val.length < 10
                    ? 'Tell us your requirement reason.'
                    : null,
                onSaved: (value) {
                  _fAddress = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FancyText(
                      text: "Blood Group: ",
                      size: 16.0,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.left,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10.0),
                      height: 40.0,
                      // width: width * 0.40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.white,
                          border: Border.all(
                            width: 1,
                            color: theme.colorScheme.primary,
                          )),
                      child: DropdownButton(
                        underline: SizedBox(),
                        hint: Container(
                            height: 45.0,
                            width: width * 0.45,
                            alignment: Alignment.center,
                            child: FancyText(
                              text: "Blood Group",
                              color: blueGrey,
                              fontWeight: FontWeight.w500,
                            )),
                        value: _bGroup,
                        items: _group.map((value) {
                          return DropdownMenuItem(
                            child: FancyText(
                              text: value,
                              color: blueGrey,
                              fontWeight: FontWeight.w500,
                            ),
                            value: value,
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _bGroup = value;
                          });
                        },
                      ),
                    ),
                    Icon(Icons.timer)
                  ]),
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
                    widget.bloodRequestForm.firstName = _fName;
                    widget.bloodRequestForm.lastName = _lName;
                    widget.bloodRequestForm.phoneNum = _fPhone;
                    widget.bloodRequestForm.address = _fAddress;

                    final uid =
                        await Provider.of<AuthService>(context).getCurrentUID();
                    await db
                        .collection("users")
                        .document(uid)
                        .collection("bloodBank")
                        .add(widget.bloodRequestForm.toJson());

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
