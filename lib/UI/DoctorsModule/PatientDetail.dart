import 'package:chitwan_hospital/UI/core/atoms/RowInput.dart';
import 'package:chitwan_hospital/UI/core/const.dart';
import 'package:chitwan_hospital/UI/DoctorsModule/PatientEdit.dart';
import 'package:chitwan_hospital/UI/DoctorsModule/PatientHistoryPage.dart';
import 'package:chitwan_hospital/UI/DoctorsModule/RecordForm.dart';
import 'package:chitwan_hospital/state/doctor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:provider/provider.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';

class PatientDetail extends StatefulWidget {
  final id;
  PatientDetail({this.id});

  @override
  _PatientDetailState createState() => _PatientDetailState();
}

class _PatientDetailState extends State<PatientDetail> {
  @override
  Widget build(BuildContext context) {
    final doctorDataStore = Provider.of<DoctorDataStore>(context);
    final appointment = doctorDataStore.appointments
        .firstWhere((element) => element['id'] == widget.id);
    Timestamp date = appointment['date'];
    final theme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    final diagnosis = appointment['diagnosis'] ?? [];

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
                    Text(doodle.time, style: textTheme.caption),
                    const SizedBox(
                      height: 2.0,
                    ),
                    Text(
                      doodle.title,
                      style: textTheme.caption,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      doodle.diagnosis,
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
            title: "Patient History",
          ),
          preferredSize: Size.fromHeight(60.0)),
      backgroundColor: theme.background,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RecordForm(
                        id: appointment['id'],
                      )));
        },
        icon: Icon(
          Icons.calendar_today,
          color: textDark_Yellow,
        ),
        label: FancyText(
          text: "Diagnosis",
          color: textDark_Yellow,
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: theme.primary,
      ),
      body: ListView(children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: FancyText(
              text: "Edit",
              color: Colors.blueGrey.withOpacity(0.7),
              fontWeight: FontWeight.w700,
              size: 15.0,
              textAlign: TextAlign.end,
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => PatientEdit()));
              }),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 2.0, bottom: 8.0),
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
                                padding: const EdgeInsets.only(right: 25.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  // crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    IconButton(
                                        icon: Icon(
                                          Icons.chat,
                                          color: textDark_Yellow,
                                        ),
                                        onPressed: () {}),
                                    IconButton(
                                        icon: Icon(
                                          Icons.video_call,
                                          size: 29.0,
                                          color: textDark_Yellow,
                                        ),
                                        onPressed: () {}),
                                  ],
                                ),
                              ),
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
                                    appointment['time'] != null
                                        ? FancyText(
                                            text: appointment['time'],
                                            color: textDark_Yellow,
                                          )
                                        : FancyText(
                                            text: "Not set",
                                            color: textDark_Yellow,
                                          )
                                  ],
                                ),
                              ),
                              FancyText(
                                text:
                                    '${appointment['firstName']} ${appointment['lastName']}',
                                fontWeight: FontWeight.w700,
                                size: 15.5,
                                textAlign: TextAlign.left,
                                color: textDark_Yellow,
                              ),
                              RowInput(
                                defaultStyle: false,
                                title: "Last Appointment: ",
                                titleColor: textDark_Yellow,
                                capColor: textDark_Yellow,
                                caption: appointment['diagnosis'] != null
                                    ? ' ${date.toDate().year}-${date.toDate().month}-${date.toDate().day}'
                                    : ' No history',
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
                                    appointment['status'] == null
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
                                                    doctorDataStore
                                                        .setAppointmentStatus(
                                                            widget.id,
                                                            'accepted');
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
                                                                SizedBox(width: 4.0),
                                                            ActionChip(
                                                                label:
                                                                    FancyText(
                                                                  text:
                                                                      "Reject",
                                                                  color: textDark_Yellow,
                                                                ),
                                                                backgroundColor:
                                                                    Colors.green
                                                                        .shade400,
                                                                onPressed: () {
                                                                  doctorDataStore
                                                                      .setAppointmentStatus(
                                                                          widget
                                                                              .id,
                                                                          'rejected');
                                                                  Navigator.pop(
                                                                      context);
                                                                }),
                                                          ],
                                                        );
                                                      });
                                                },
                                              ),
                                              
                                              SizedBox(width: 10.0),
                                            ],
                                          )
                                        : appointment['status'] == "rejected"
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
                                                    doctorDataStore
                                                        .setAppointmentStatus(
                                                            widget.id, null);
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
                                            : Row(
                                                children: <Widget>[
                                                  FancyText(
                                                    text: "Accepted",
                                                    color: Colors.green,
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
                                                      doctorDataStore
                                                          .setAppointmentStatus(
                                                              widget.id, null);
                                                    },
                                                    child: FancyText(
                                                      text: "Undo",
                                                      decoration: TextDecoration
                                                          .underline,
                                                      decorationColor:
                                                          Colors.red[200],
                                                      color: Colors.red[200],
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
        Container(
          height: size.height * 0.60,
          child: Timeline.builder(
              physics: ClampingScrollPhysics(),
              position: TimelinePosition.Left,
              itemCount: appointment['diagnosis'] != null
                  ? appointment['diagnosis'].length
                  : 0,
              //
              // appointment['diagnosis'].length
              // : 0,

              itemBuilder: centerTimelineBuilder),
        )
      ]),
    );
  }
}
