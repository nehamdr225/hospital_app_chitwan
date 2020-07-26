import 'dart:io';
import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/atoms/Indicator.dart';
import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:chitwan_hospital/state/lab.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class LabInfoUpload extends StatefulWidget {
  final id;
  LabInfoUpload({this.id});
  @override
  _LabInfoUploadState createState() => _LabInfoUploadState();
}

class _LabInfoUploadState extends State<LabInfoUpload> {
  File _image;

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile.path);
    });
  }

  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    final labDataStore = Provider.of<LabDataStore>(context);
    final order = labDataStore.getOneOrder(widget.id);

    final theme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
          child: WhiteAppBar(
            title: 'Order Details',
            titleColor: Colors.black,
          ),
          preferredSize: Size.fromHeight(40.0)),
      backgroundColor: theme.background,
      floatingActionButton: order.status != null && order.status == 'ready' ||
              order.status == 'complete'
          ? FloatingActionButton.extended(
              onPressed: isActive
                  ? null
                  : () {
                      setState(() {
                        isActive = true;
                      });
                      labDataStore
                          .setOrderStatus(order.id,
                              order.status == 'ready' ? 'complete' : 'ready')
                          .then((value) => setState(() {
                                isActive = false;
                              }));
                    },
              icon: Icon(
                Icons.calendar_today,
                color: textDark_Yellow,
              ),
              label: FancyText(
                text: order.status == 'ready'
                    ? "Mark Delivered"
                    : order.status == 'complete' ? "Undo Delivered" : '',
                color: textDark_Yellow,
                fontWeight: FontWeight.w600,
              ),
              backgroundColor: theme.primary,
            )
          : SizedBox.shrink(),
      body: ListView(children: <Widget>[
        BoolIndicator(isActive),
        Padding(
          padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
          child: Center(
            child: Container(
                height: 180.0,
                width: size.width * 0.95,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  gradient: gradientColor,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.white60,
                        offset: Offset(-4, -4),
                        blurRadius: 3.0),
                    BoxShadow(
                      color: Color(0xffffffff),
                      offset: Offset(-.9, -.9),
                    ),
                    BoxShadow(
                        color: theme.primary.withOpacity(0.3),
                        offset: Offset(4, 4),
                        blurRadius: 3.0),
                    BoxShadow(
                        color: theme.primary.withOpacity(0.3),
                        offset: Offset(.9, .9),
                        blurRadius: 1.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                          flex: 1,
                          child: CircleAvatar(
                            radius: 50.0,
                            backgroundColor: theme.background,
                            backgroundImage: ExactAssetImage(
                              'assets/images/doctor.png',
                            ),
                          )),
                      Flexible(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 14.0, top: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              order.title != null
                                  ? Padding(
                                      padding: EdgeInsets.only(bottom: 10.0),
                                      child: FancyText(
                                        text: order.title
                                                .substring(0, 1)
                                                .toUpperCase() +
                                            order.title.substring(1),
                                        fontWeight: FontWeight.w800,
                                        size: 15.5,
                                        textAlign: TextAlign.left,
                                        color: Colors.white,
                                      ),
                                    )
                                  : SizedBox.shrink(),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 2.0),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.person_outline,
                                      size: 16.0,
                                      color: Colors.white,
                                    ),
                                    FancyText(
                                      text: '  ' + order.name,
                                      fontWeight: FontWeight.w500,
                                      size: 15.5,
                                      textAlign: TextAlign.left,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 2.0),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.mail_outline,
                                      size: 16.0,
                                      color: Colors.white,
                                    ),
                                    FancyText(
                                      text: '  ' + order.email,
                                      textAlign: TextAlign.left,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 2.0),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.phone,
                                      size: 16.0,
                                      color: Colors.white,
                                    ),
                                    FancyText(
                                      text: '  ' + order.phone,
                                      textAlign: TextAlign.left,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 3.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    FancyText(
                                      text: "Current Status: ",
                                      textAlign: TextAlign.left,
                                      color: textDark_Yellow,
                                    ),
                                    order.status == null
                                        ? Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              ActionChip(
                                                label: FancyText(
                                                  text: "Ready",
                                                  size: 14.0,
                                                ),
                                                backgroundColor: isActive
                                                    ? Colors.grey
                                                    : Colors.green.shade400,
                                                onPressed: isActive
                                                    ? () {}
                                                    : () {
                                                        setState(() {
                                                          isActive = true;
                                                        });
                                                        labDataStore
                                                            .setOrderStatus(
                                                                order.id,
                                                                'ready')
                                                            .then((value) =>
                                                                setState(() {
                                                                  isActive =
                                                                      false;
                                                                }));
                                                      },
                                              ),
                                              SizedBox(width: 10.0),
                                              ActionChip(
                                                label: FancyText(
                                                  text: "Reject ",
                                                  size: 14.0,
                                                  wordSpacing: 1.2,
                                                ),
                                                backgroundColor: theme.secondary
                                                    .withOpacity(0.6),
                                                onPressed: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          title: FancyText(
                                                              text:
                                                                  "Are you sure?",
                                                              size: 15.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: blueGrey),
                                                          content: FancyText(
                                                              text:
                                                                  "Are you sure you want to reject buyer request?",
                                                              size: 15.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: blueGrey),
                                                          actions: <Widget>[
                                                            InkWell(
                                                                child: FancyText(
                                                                    text:
                                                                        "Cancel",
                                                                    color: theme
                                                                        .secondary),
                                                                onTap: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                }),
                                                            SizedBox(
                                                                width: 4.0),
                                                            ActionChip(
                                                                label:
                                                                    FancyText(
                                                                  text:
                                                                      "Reject",
                                                                  color:
                                                                      textDark_Yellow,
                                                                ),
                                                                backgroundColor:
                                                                    Colors.green
                                                                        .shade400,
                                                                onPressed: () {
                                                                  setState(() {
                                                                    isActive =
                                                                        true;
                                                                  });
                                                                  labDataStore
                                                                      .setOrderStatus(
                                                                          order
                                                                              .id,
                                                                          'rejected')
                                                                      .then(
                                                                          (value) {
                                                                    setState(
                                                                        () {
                                                                      isActive =
                                                                          false;
                                                                    });
                                                                    Navigator.pop(
                                                                        context);
                                                                  });
                                                                }),
                                                          ],
                                                        );
                                                      });
                                                },
                                              ),
                                              SizedBox(width: 10.0),
                                            ],
                                          )
                                        : order.status == "rejected"
                                            ? Row(children: [
                                                FancyText(
                                                  text: "Rejected",
                                                  color: Colors.red.shade400,
                                                  fontWeight: FontWeight.w700,
                                                  size: 15.5,
                                                ),
                                                SizedBox(width: 10.0),
                                                InkWell(
                                                  onTap: isActive
                                                      ? null
                                                      : () {
                                                          setState(() {
                                                            isActive = true;
                                                          });
                                                          labDataStore
                                                              .setOrderStatus(
                                                                  order.id,
                                                                  null)
                                                              .then((value) =>
                                                                  setState(() {
                                                                    isActive =
                                                                        false;
                                                                  }));
                                                        },
                                                  child: FancyText(
                                                    text: "undo",
                                                    decoration: TextDecoration
                                                        .underline,
                                                    decorationColor:
                                                        Colors.red[200],
                                                    color: Colors.red[200],
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                )
                                              ])
                                            : order.status == 'complete'
                                                ? FancyText(
                                                    text:
                                                        'Completed & Delivered',
                                                    color: Colors.green,
                                                    fontWeight: FontWeight.w700,
                                                    size: 15.5,
                                                  )
                                                : Row(
                                                    children: <Widget>[
                                                      FancyText(
                                                        text: 'Ready',
                                                        color: Colors.green,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        size: 15.5,
                                                      ),
                                                      SizedBox(width: 10.0),
                                                      InkWell(
                                                        onTap: isActive
                                                            ? null
                                                            : () {
                                                                setState(() {
                                                                  isActive =
                                                                      true;
                                                                });
                                                                labDataStore
                                                                    .setOrderStatus(
                                                                        order
                                                                            .id,
                                                                        null)
                                                                    .then((value) =>
                                                                        setState(
                                                                            () {
                                                                          isActive =
                                                                              false;
                                                                        }));
                                                              },
                                                        child: FancyText(
                                                          text: "undo",
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                          decorationColor:
                                                              Colors.red[200],
                                                          color:
                                                              Colors.red[200],
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                // Text(),
                ),
          ),
        ),
        Padding(
          //date
          padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              FancyText(
                text: "Upload Report: ",
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
                              decoration: BoxDecoration(border: Border.all()),
                              child: Image.file(_image)),
                          Container(
                            height: 100.0,
                            width: 100.0,
                            color: Colors.black26,
                          ),
                        ]),
                      ),
                    ]),
            ],
          ),
        ),
      ]),
    );
  }
}
