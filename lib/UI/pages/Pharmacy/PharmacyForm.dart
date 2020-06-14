import 'dart:io';

import 'package:chitwan_hospital/UI/Widget/Forms.dart';
import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:chitwan_hospital/UI/pages/Home/HomeScreen.dart';
import 'package:chitwan_hospital/service/pharmacyForm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PharmacyForm extends StatefulWidget {
  final Pharmacy pharmacyForm;
  final doctor;
  final department;
  PharmacyForm(
      {this.doctor, this.department, @required this.pharmacyForm, Key key})
      : super(key: key);
  @override
  _PharmacyFormState createState() => _PharmacyFormState();
}

class _PharmacyFormState extends State<PharmacyForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final db = Firestore.instance;
  List name = [];
  String _fName;
  String _lName;
  String _fPhone;
  String _fAddress;
  File _image;
  File _image2;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile.path);
    });
  }

  Future getImage2() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image2 = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _textController = new TextEditingController();
    _textController.text = widget.pharmacyForm.firstName;
    final theme = Theme.of(context);
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: WhiteAppBar(
              titleColor: theme.colorScheme.primary, title: "Order Form")),
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
              //date
              padding:
                  const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  FancyText(
                    text: "Upload Prescription: ",
                    size: 16.0,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  _image == null
                      ? IconButton(
                          icon: Icon(
                            Icons.add_a_photo,
                            size: 26.0,
                            color: theme.colorScheme.primary,
                          ),
                          onPressed: getImage,
                        )
                      : Row(children: <Widget>[
                          InkWell(
                            onTap: getImage,
                            child: Stack(children: <Widget>[
                              Container(
                                  height: 100.0,
                                  width: 100.0,
                                  decoration:
                                      BoxDecoration(border: Border.all()),
                                  child: Image.file(_image)),
                              Container(
                                height: 100.0,
                                width: 100.0,
                                color: Colors.black26,
                              ),
                            ]),
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          _image2 == null
                              ? IconButton(
                                  icon: Icon(
                                    Icons.add_a_photo,
                                    size: 26.0,
                                    color: theme.colorScheme.primary,
                                  ),
                                  onPressed: getImage2,
                                )
                              : Row(
                                  children: <Widget>[
                                    InkWell(
                                      onTap: getImage2,
                                      child: Stack(children: <Widget>[
                                        Container(
                                            height: 100.0,
                                            width: 100.0,
                                            decoration: BoxDecoration(
                                                border: Border.all()),
                                            child: Image.file(_image2)),
                                        Container(
                                          height: 100.0,
                                          width: 100.0,
                                          color: Colors.black26,
                                        ),
                                      ]),
                                    ),
                                  ],
                                ),
                        ]),
                ],
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
                    widget.pharmacyForm.firstName = _fName;
                    widget.pharmacyForm.lastName = _lName;
                    widget.pharmacyForm.phoneNum = _fPhone;
                    widget.pharmacyForm.address = _fAddress;
                    widget.pharmacyForm.image1 = _image;
                    widget.pharmacyForm.image2 = _image2;

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
