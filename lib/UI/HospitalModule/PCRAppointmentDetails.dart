import 'package:chitwan_hospital/UI/core/atoms/Indicator.dart';
import 'package:chitwan_hospital/UI/core/atoms/QA.dart';
import 'package:chitwan_hospital/UI/core/atoms/RowInput.dart';
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
    Timestamp date = appointment.timestamp;
    final theme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    final gender = "${appointment.gender}".replaceRange(0, 7, '').toUpperCase();
    final prevTravel =
        "${appointment.previousTravel}".replaceRange(0, 9, '').toUpperCase();
    final closeContactToProbable = "${appointment.closeContactToProbable}"
        .replaceRange(0, 9, '')
        .toUpperCase();

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
                              RowInput(
                                title: 'Gender: ',
                                caption: gender,
                                defaultStyle: false,
                                capColor: textDark_Yellow,
                                titleColor: textDark_Yellow,
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
                                      size: 14.0,
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
        Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 8.0, left: 15.0),
          child: Column(children: <Widget>[
            
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: RowInput(
                defaultStyle: true,
                title: "Date of Birth: ",
                caption: "${appointment.dob}",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: RowInput(
                defaultStyle: true,
                title: "Age: ",
                caption: "${appointment.age}",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: RowInput(
                defaultStyle: true,
                title: "Temporary Address: ",
                caption: "${appointment.temporaryAddress}",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: RowInput(
                defaultStyle: true,
                title: "Permanent Address: ",
                caption: "${appointment.permanentAddress}",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: RowInput(
                defaultStyle: true,
                title: "Name of admitted hospital: ",
                caption: "${appointment.admittedHospital}",
              ),
            ),
           
            "${appointment.occupation}" != "Occupation.others"
                ? Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: RowInput(
                      defaultStyle: true,
                      title: "Occupation: ",
                      caption: "${appointment.occupation}",
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: RowInput(
                      defaultStyle: true,
                      title: "Occupation: ",
                      caption: "${appointment.otherOccupation}",
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: QA(
                defaultStyle: true,
                title:
                    "Has the patient travelled in the 14 days prior to symptom onset?  ",
                caption: prevTravel,
              ),
            ),
            "${appointment.previousTravel}" == "BoolEnum.yes"
                ? Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: RowInput(
                      defaultStyle: true,
                      title: "Travel Location: ",
                      caption: "${appointment.placeOfTravel}",
                    ),
                  )
                : SizedBox.fromSize(),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: QA(
                defaultStyle: true,
                title:
                    "Has the patient had close contact with a probable or confirmed in the 14 days prior to symptom onset?  ",
                caption: closeContactToProbable,
              ),
            ),
            "${appointment.closeContactToProbable}" == "BoolEnum.yes"
                ? Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: RowInput(
                      defaultStyle: true,
                      title: "Contact Details: ",
                      caption:
                          "${appointment.closeContactDetails.probableCases}",
                    ),
                  )
                : SizedBox.fromSize(),
                 "${appointment.closeContactToProbable}" == "BoolEnum.yes"
                ? Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: RowInput(
                      defaultStyle: true,
                      title: "Exposed Location: ",
                      caption:
                          "${appointment.closeContactDetails.exposedLocation}",
                    ),
                  )
                : SizedBox.fromSize(),
            
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: QA(
                defaultStyle: true,
                title:
                    "Have you visited any live animal markets in the 14 days prior to symptom onset?  ",
                caption: "${appointment.liveMarketVisit}"
                    .replaceRange(0, 9, '')
                    .toUpperCase(),
              ),
            ),
            "${appointment.closeContactToProbable}" == "BoolEnum.yes"
                ? Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: RowInput(
                      defaultStyle: true,
                      title: "Contact Details: ",
                      caption: "${appointment.liveMarketLocation}",
                    ),
                  )
                : SizedBox.fromSize(),
            SizedBox(height: 100.0)
          ]),
        )
      ]),
    );
  }
}
