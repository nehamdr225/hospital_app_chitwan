import 'dart:io';
import 'package:eMed/UI/HospitalModule/HospitalModule.dart';
import 'package:eMed/UI/Widget/Forms.dart';
import 'package:eMed/UI/core/atoms/FancyText.dart';
import 'package:eMed/UI/core/atoms/Indicator.dart';
import 'package:eMed/UI/core/atoms/SnackBar.dart';
import 'package:eMed/UI/core/theme.dart';
import 'package:eMed/models/HospitalPromotion.dart';
import 'package:eMed/state/hospital.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddPromotion extends StatefulWidget {
  @override
  _AddPromotionState createState() => _AddPromotionState();
}

class _AddPromotionState extends State<AddPromotion> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  HospitalPromotion promo = HospitalPromotion(
    fromDate: DateTime.now().toIso8601String(),
    toDate: DateTime.now().toIso8601String(),
    isArchived: false,
  );

  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile?.path != null)
      setState(() {
        _image = File(pickedFile.path);
      });
  }

  Future<Null> _selectFromDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020, 1),
      lastDate: DateTime(2020, 9),
    );
    if (picked != null)
      setState(() {
        promo.fromDate = picked.toIso8601String();
      });
  }

  Future<Null> _selectToDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020, 1),
      lastDate: DateTime(2020, 9),
    );
    if (picked != null)
      setState(() {
        promo.toDate = picked.toIso8601String();
      });
  }

  bool isActive = false;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var width = MediaQuery.of(context).size.width;
    var style = TextStyle(
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.bold,
        fontSize: 15,
        color: blueGrey.withOpacity(0.9));
    final hospitalDataStore = Provider.of<HospitalDataStore>(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      persistentFooterButtons: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: SizedBox(
            height: 45.0,
            width: width,
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
                if (!_formKey.currentState.validate() || _image == null) {
                  buildAndShowFlushBar(
                    context: context,
                    text: 'Please provide all data!',
                    backgroundColor: theme.colorScheme.error,
                    icon: Icons.error,
                  );
                  return;
                }
                _formKey.currentState.save();
                setState(() {
                  isActive = true;
                });
                final uploadTask = hospitalDataStore.uploadFile(_image);
                uploadTask.events.listen((event) async {
                  if (uploadTask.isComplete) {
                    promo.hospitalId = hospitalDataStore.user.uid;
                    promo.hospital = hospitalDataStore.user.name;
                    promo.image = await event.snapshot.ref.getDownloadURL();
                    await hospitalDataStore.createPromotion(promo.toJson());
                    buildAndShowFlushBar(
                      context: context,
                      text: 'Promotion created!',
                      icon: Icons.check,
                    );
                    setState(() {
                      isActive = false;
                    });
                    await Future.delayed(Duration(seconds: 2));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HospitalModule()));
                  }
                });
              },
            ),
          ),
        )
      ],
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            BoolIndicator(isActive),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
              child: FForms(
                icon: Icon(
                  Icons.title,
                  color: theme.colorScheme.primary,
                ),
                borderColor: theme.colorScheme.primary,
                labeltext: true,
                text: 'Title',
                textColor: theme.colorScheme.primary,
                onChanged: (value) {
                  setState(() {
                    promo.title = value;
                  });
                },
                validator: (val) => val.length < 10
                    ? 'Title must be at least 10 characters!'
                    : null,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
              child: FForms(
                // icon: Icon(
                //   Icons.description,
                //   color: theme.colorScheme.primary,
                // ),
                minLines: 1,
                maxLines: 10,
                borderColor: theme.colorScheme.primary,
                labeltext: true,
                text: 'Description',
                textColor: theme.colorScheme.primary,
                onChanged: (value) {
                  setState(() {
                    promo.description = value;
                  });
                },
                validator: (val) => val.length < 20
                    ? 'Description must be at least 20 characters!'
                    : null,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
              child: FancyText(
                text: "Promotion Picture ",
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
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  FancyText(
                    text: "From date:     ",
                    size: 16.0,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.left,
                  ),
                  InkWell(
                    onTap: () {
                      _selectFromDate(context);
                    },
                    child: Container(
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
                          "${promo.fromDate.split('T')[0]}",
                          style: style,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () => _selectFromDate(context),
                  ),
                ],
              ),
            ),
            Padding(
              //date
              padding:
                  const EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  FancyText(
                    text: "To date:          ",
                    size: 16.0,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.left,
                  ),
                  InkWell(
                    onTap: () {
                      _selectToDate(context);
                    },
                    child: Container(
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
                          "${promo.toDate.split('T')[0]}",
                          style: style,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () => _selectToDate(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
