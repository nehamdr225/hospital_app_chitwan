import 'dart:io';
import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:chitwan_hospital/UI/pages/Home/HomeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPromotion extends StatefulWidget {
  @override
  _AddPromotionState createState() => _AddPromotionState();
}

class _AddPromotionState extends State<AddPromotion> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final db = Firestore.instance;
  List name = [];
  //String _description;
  File _image;
  DateTime selectedfromDate = DateTime.now();
  DateTime selectedtoDate = DateTime.now();
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile.path);
    });
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedfromDate,
      firstDate: DateTime(2020, 1),
      lastDate: DateTime(2020, 9),
    );
    if (picked != null && picked != selectedfromDate)
      setState(() {
        selectedfromDate = picked;
      });
  }
  Future<Null> _selectDate2(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedfromDate,
      firstDate: DateTime(2020, 1),
      lastDate: DateTime(2020, 9),
    );
    if (picked != null && picked != selectedfromDate)
      setState(() {
        selectedfromDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var width = MediaQuery.of(context).size.width;
    var style = TextStyle(
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.bold,
        fontSize: 15,
        color: blueGrey.withOpacity(0.9));

    return Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left:10.0, top:10.0, right: 10.0),
              child: FancyText(
                text: "Add Promotion Picture: ",
                size: 16.0,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.left,
              ),
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
                            decoration: BoxDecoration(border: Border.all()),
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
                  ]),
            Padding(
              //date
              padding:
                  const EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FancyText(
                    text: "From date: ",
                    size: 16.0,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.left,
                  ),
                  Container(
                    height: 40.0,
                    width: width * 0.50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                        border: Border.all(
                          width: 1,
                          color: theme.colorScheme.primary,
                        )),
                    child: Center(
                      child: Text(
                        "${selectedfromDate.day.toString()}-${selectedfromDate.month.toString()}-${selectedfromDate.year.toString()}",
                        style: style,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context),
                  ),
                ],
              ),
            ),
            Padding(
              //date
              padding:
                  const EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FancyText(
                    text: "To date: ",
                    size: 16.0,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.left,
                  ),
                  Container(
                    height: 40.0,
                    width: width * 0.50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                        border: Border.all(
                          width: 1,
                          color: theme.colorScheme.primary,
                        )),
                    child: Center(
                      child: Text(
                        "${selectedtoDate.day.toString()}-${selectedtoDate.month.toString()}-${selectedtoDate.year.toString()}",
                        style: style,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () => _selectDate2(context),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:10.0, top:25.0, right: 10.0),
              child: FancyText(
                text: "Add Description: ",
                size: 16.0,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, top: 20.0, bottom: 20.0, right: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: theme.colorScheme.primary, width: 0.5),
                      borderRadius: BorderRadius.circular(5.0)),
                  height: 150.0,
                  width: width * 0.95,
                  child: CupertinoTextField(
                    keyboardType: TextInputType.multiline,
                    textAlignVertical: TextAlignVertical.top,
                    maxLines: null,
                    placeholder: "Add Description!",
                  ),
                )),
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

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                ),
              ),
            )
          ],
        ),
      
    );
  }
}
