import 'package:chitwan_hospital/UI/core/atoms/Indicator.dart';
import 'package:chitwan_hospital/state/hospital.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:provider/provider.dart';

class PCRAppointmentDetails extends StatefulWidget {
  final id;
  PCRAppointmentDetails({this.id});

  @override
  _PCRAppointmentDetailsState createState() => _PCRAppointmentDetailsState();
}

class _PCRAppointmentDetailsState extends State<PCRAppointmentDetails> {
  bool isActive = false;
  @override
  Widget build(BuildContext context) {
    final hospitalDataStore = Provider.of<HospitalDataStore>(context);
    final appointment = hospitalDataStore.appointments
        .firstWhere((element) => element.id == widget.id);
    Timestamp date = Timestamp.fromDate(appointment.date);
    final theme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
          child: WhiteAppBar(
            titleColor: theme.primary,
            title: "PCR Test Request",
          ),
          preferredSize: Size.fromHeight(60.0)),
      backgroundColor: theme.background,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            isActive = true;
          });
          hospitalDataStore
              .setAppointmentStatus(widget.id, 'completed')
              .then((value) => setState(() {
                    isActive = false;
                  }));
        },
        icon: Icon(
          Icons.calendar_today,
          color: textDark_Yellow,
        ),
        label: FancyText(
          text: appointment.status == 'completed'
              ? "Undo Complete"
              : "Mark Completed",
          color: textDark_Yellow,
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: theme.primary,
      ),
      body: ListView(children: <Widget>[
        // Padding(
        //   padding: const EdgeInsets.only(right: 12.0),
        //   child: FancyText(
        //       text: "Edit",
        //       color: Colors.blueGrey.withOpacity(0.7),
        //       fontWeight: FontWeight.w700,
        //       size: 15.0,
        //       textAlign: TextAlign.end,
        //       onTap: () {
        //         Navigator.of(context).push(
        //             MaterialPageRoute(builder: (context) => PatientEdit()));
        //       }),
        // ),
        BoolIndicator(isActive),
        Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 8.0),
          child: Center(
            child: Container(
                height: 200.0,
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
                          padding: const EdgeInsets.only(left: 14.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 0.0, bottom: 5.0),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.calendar_today,
                                      size: 16.0,
                                      color: textDark_Yellow,
                                    ),
                                    date != null
                                        ? FancyText(
                                            color: textDark_Yellow,
                                            text:
                                                ' ${date.toDate().year}-${date.toDate().month}-${date.toDate().day}')
                                        : FancyText(
                                            text: "Not set",
                                            color: textDark_Yellow,
                                          ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 3.0),
                                      child: Icon(
                                        Icons.timer,
                                        size: 16.0,
                                        color: textDark_Yellow,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              FancyText(
                                text:
                                    '${appointment.firstName} ${appointment.lastName}',
                                fontWeight: FontWeight.w700,
                                size: 15.5,
                                textAlign: TextAlign.left,
                                color: textDark_Yellow,
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
                                    appointment.status == null
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
                                                  onPressed: () {
                                                    setState(() {
                                                      isActive = true;
                                                    });
                                                    hospitalDataStore
                                                        .setAppointmentStatus(
                                                            widget.id,
                                                            'accepted')
                                                        .then((value) =>
                                                            setState(() {
                                                              isActive = false;
                                                            }));
                                                  }),
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
                                                                  hospitalDataStore
                                                                      .setAppointmentStatus(
                                                                          widget
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
                                        : appointment.status == "rejected"
                                            ? Row(children: [
                                                FancyText(
                                                  text: "Rejected",
                                                  color: theme.secondary,
                                                  fontWeight: FontWeight.w700,
                                                  size: 15.0,
                                                ),
                                                SizedBox(width: 10.0),
                                                InkWell(
                                                  onTap: () {
                                                    // setState(() {
                                                    //   doctorDecision =
                                                    //       "undecided";
                                                    // });
                                                    setState(() {
                                                      isActive = true;
                                                    });
                                                    hospitalDataStore
                                                        .setAppointmentStatus(
                                                            widget.id, null)
                                                        .then((value) =>
                                                            setState(() {
                                                              isActive = false;
                                                            }));
                                                  },
                                                  child: FancyText(
                                                    text: "Undo",
                                                    decoration: TextDecoration
                                                        .underline,
                                                    decorationColor:
                                                        Colors.red[200],
                                                    color: Colors.red[200],
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                )
                                              ])
                                            : appointment.status == 'completed'
                                                ? FancyText(
                                                    text: "Completed",
                                                    color: Colors.green,
                                                    fontWeight: FontWeight.w700,
                                                    size: 15.0,
                                                  )
                                                : Row(
                                                    children: <Widget>[
                                                      FancyText(
                                                        text: "Accepted",
                                                        color: Colors.green,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        size: 15.0,
                                                      ),
                                                      SizedBox(width: 10.0),
                                                      InkWell(
                                                        onTap: () {
                                                          // setState(() {
                                                          //   doctorDecision =
                                                          //       "undecided";
                                                          // });
                                                          setState(() {
                                                            isActive = true;
                                                          });
                                                          hospitalDataStore
                                                              .setAppointmentStatus(
                                                                  widget.id,
                                                                  null)
                                                              .then((value) =>
                                                                  setState(() {
                                                                    isActive =
                                                                        false;
                                                                  }));
                                                        },
                                                        child: FancyText(
                                                          text: "Undo",
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
                              SizedBox(height: 20.0),
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
      ]),
    );
  }
}
