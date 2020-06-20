import 'dart:io';

import 'package:chitwan_hospital/UI/Widget/FRaisedButton.dart';
import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class LabInfoUpload extends StatefulWidget {
  @override
  _LabInfoUploadState createState() => _LabInfoUploadState();
}

class _LabInfoUploadState extends State<LabInfoUpload> {
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
    final theme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
          child: WhiteAppBar(), preferredSize: Size.fromHeight(40.0)),
      backgroundColor: theme.background,
      body: ListView(children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: FancyText(
            text: "Report Availability",
            textAlign: TextAlign.center,
            size: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          height: 50.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FRaisedButton(
                width: size.width * 0.45,
                text: "Processing",
                fontWeight: FontWeight.w500,
                color: textDark_Yellow,
                bg: theme.secondary,
                borderColor: theme.secondary,
                onPressed: () {},
              ),
              FRaisedButton(
                width: size.width * 0.45,
                text: "Ready",
                fontWeight: FontWeight.w500,
                color: textDark_Yellow,
                bg: Colors.green,
                borderColor: Colors.green,
                onPressed: () {},
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: FancyText(
            text: "Upload Report",
            textAlign: TextAlign.center,
            size: 16.0,
            fontWeight: FontWeight.bold,
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
                            color: theme.primary,
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
                                    color: theme.primary,
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

      ]),
    );
  }
}
