import 'package:chitwan_hospital/UI/DoctorsModule/PatientHistoryPage.dart';
import 'package:chitwan_hospital/UI/PharmacyModule/RejectRemarkform.dart';
import 'package:chitwan_hospital/UI/core/atoms/Indicator.dart';
import 'package:chitwan_hospital/UI/core/atoms/RowInput.dart';
import 'package:chitwan_hospital/UI/core/const.dart';
import 'package:chitwan_hospital/state/pharmacy.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:provider/provider.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';

class BuyerDetail extends StatefulWidget {
  final buyerName;
  final buyerPhone;
  final status;
  final time;
  final id;
  BuyerDetail(
      {this.buyerName, this.buyerPhone, this.status, this.time, this.id});

  @override
  _BuyerDetailState createState() => _BuyerDetailState();
}

class _BuyerDetailState extends State<BuyerDetail> {
  List diagnosis;
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    final pharmacyDataStore = Provider.of<PharmacyDataStore>(context);
    final order = pharmacyDataStore.getOneOrder(widget.id);
    if (diagnosis == null)
      pharmacyDataStore
          .getAppointment(order['appointmentId'])
          .then((value) => setState(() {
                diagnosis = value.data['diagnosis'];
              }));

    // print(appointment);
    TimelineModel centerTimelineBuilder(BuildContext context, int i) {
      final textTheme = Theme.of(context).textTheme;
      Timestamp date = diagnosis[i]['date'];
      String time =
          ' ${date.toDate().year}-${date.toDate().month}-${date.toDate().day},  ';
      if (date.toDate().hour > 12) {
        time +=
            '${date.toDate().hour - 12}:${date.toDate().minute}:${date.toDate().second} PM';
      } else {
        time +=
            '${date.toDate().hour}:${date.toDate().minute}:${date.toDate().second} AM';
      }
      final doodle = Doodle(
          title: diagnosis[i]['title'],
          time: time,
          diagnosis: diagnosis[i]['diagnosis'],
          iconBackground: Color(0xff173A7B),
          medicines: diagnosis[i]['medicines'],
          image: [
            "assets/images/img3.jpeg",
            "assets/images/img4.jpeg",
          ]);
      return TimelineModel(
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PatientHistoryPage(
                      date: doodle.time,
                      diagnosis: doodle.diagnosis,
                      medicine: doodle.medicines,
                      title: doodle.title,
                    )));
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.80,
            child: Card(
              margin: EdgeInsets.symmetric(vertical: 16.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              clipBehavior: Clip.antiAlias,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          "Tap to view...",
                          style: TextStyle(
                              fontSize: 12.0, color: blueGrey.withOpacity(0.7)),
                        )),
                    Text(doodle.time, style: textTheme.caption),
                    const SizedBox(
                      height: 2.0,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      doodle.medicines,
                      style: textTheme.headline6.copyWith(fontSize: 16.0),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        position: TimelineItemPosition.left,
        iconBackground: doodle.iconBackground,
      );
    }

    return Scaffold(
      appBar: PreferredSize(
          child: WhiteAppBar(
            titleColor: theme.primary,
            title: "Buyer History",
          ),
          preferredSize: Size.fromHeight(60.0)),
      backgroundColor: theme.background,
      floatingActionButton: order['status'] == "accepted" ||
              order['status'] == "ready"
          ? FloatingActionButton.extended(
              onPressed: isActive
                  ? null
                  : () {
                      if (order['status'] != 'ready') {
                        setState(() {
                          isActive = true;
                        });
                        pharmacyDataStore
                            .setOrderStatus(order['id'], 'ready')
                            .then((value) => setState(() {
                                  isActive = false;
                                }));
                      } else {
                        setState(() {
                          isActive = true;
                        });
                        pharmacyDataStore
                            .setOrderStatus(order['id'], 'accepted')
                            .then((value) => setState(() {
                                  isActive = false;
                                }));
                      }
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => PharmacyReady(
                      //             // appointment: newAppointment,
                      //             )));
                    },
              icon: Icon(
                Icons.calendar_today,
                color: textDark_Yellow,
              ),
              label: FancyText(
                text: order['status'] == "ready" ? 'Undo Ready' : "Mark Ready",
                color: textDark_Yellow,
                fontWeight: FontWeight.w600,
              ),
              backgroundColor: theme.primary,
            )
          : null,
      body: ListView(children: <Widget>[
        Indicator(diagnosis),
        BoolIndicator(isActive),
        Padding(
          padding: const EdgeInsets.only(top: 6.0, bottom: 8.0),
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
                              FancyText(
                                text: widget.buyerName,
                                fontWeight: FontWeight.w700,
                                size: 15.5,
                                textAlign: TextAlign.left,
                                color: textDark_Yellow,
                              ),
                              // RowInput(
                              //   title: "Date:  ",
                              //   caption: '',
                              //   titleColor: textDark_Yellow,
                              //   capColor: textDark_Yellow,
                              //   defaultStyle: false,
                              // ),
                              RowInput(
                                title: "Phone Number:  ",
                                caption: widget.buyerPhone,
                                titleColor: textDark_Yellow,
                                capColor: textDark_Yellow,
                                defaultStyle: false,
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
                                    order['status'] == null
                                        ? Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              ActionChip(
                                                label: FancyText(
                                                  text: "Accept",
                                                  size: 14.0,
                                                ),
                                                backgroundColor:
                                                    Colors.green.shade400,
                                                onPressed: isActive
                                                    ? (){}
                                                    : () {
                                                        setState(() {
                                                          isActive = true;
                                                        });
                                                        pharmacyDataStore
                                                            .setOrderStatus(
                                                                order['id'],
                                                                'accepted')
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
                                                                  pharmacyDataStore
                                                                      .setOrderStatus(
                                                                          order[
                                                                              'id'],
                                                                          'rejected')
                                                                      .then(
                                                                          (value) {
                                                                    setState(
                                                                        () {
                                                                      isActive =
                                                                          false;
                                                                    });
                                                                    Navigator.of(
                                                                            context)
                                                                        .push(
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                RejectRemarkForm(id: order['id']),
                                                                      ),
                                                                    );
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
                                        : order['status'] == "rejected"
                                            ? Row(children: [
                                                FancyText(
                                                  text: "Rejected",
                                                  color: theme.secondary,
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
                                                          pharmacyDataStore
                                                              .setOrderStatus(
                                                                  order['id'],
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
                                            : Row(
                                                children: <Widget>[
                                                  FancyText(
                                                    text: order['status'] ==
                                                            'ready'
                                                        ? 'Ready'
                                                        : "Accepted",
                                                    color: Colors.green,
                                                    fontWeight: FontWeight.w700,
                                                    size: 15.5,
                                                  ),
                                                  SizedBox(width: 10.0),
                                                  order['status'] == 'ready'
                                                      ? SizedBox.shrink()
                                                      : InkWell(
                                                          onTap: isActive
                                                              ? null
                                                              : () {
                                                                  setState(() {
                                                                    isActive =
                                                                        true;
                                                                  });
                                                                  pharmacyDataStore
                                                                      .setOrderStatus(
                                                                          order[
                                                                              'id'],
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
                              order['status'] == 'rejected'
                                  ? RowInput(
                                      title: "Remark:  ",
                                      caption: order['remark'] ?? '',
                                      titleColor: textDark_Yellow,
                                      capColor: textDark_Yellow,
                                      defaultStyle: false,
                                    )
                                  : Text(''),
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
        Container(
          height: size.height * 0.60,
          child: Timeline.builder(
              physics: ClampingScrollPhysics(),
              position: TimelinePosition.Left,
              itemCount: diagnosis != null ? diagnosis.length : 0,
              itemBuilder: centerTimelineBuilder),
        )
      ]),
    );
  }
}
