import 'package:chitwan_hospital/UI/DoctorsModule/PatientHistoryPage.dart';
import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:chitwan_hospital/UI/core/const.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:chitwan_hospital/state/store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';

class AppointmentDetail extends StatelessWidget {
  final id;
  AppointmentDetail({
    this.id,
  });
  // bool isActive = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final appointment =
        Provider.of<UserDataStore>(context).getOneAppointment(id);
    final Timestamp date = appointment['date'] ?? Timestamp.now();
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
                      patient: true,
                      id: appointment['id'],
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
        preferredSize: Size.fromHeight(50.0),
        child: WhiteAppBar(
          titleColor: theme.colorScheme.primary,
          title: "Appointment Detail",
        ),
      ),
      backgroundColor: theme.colorScheme.background,
      body: ListView(children: <Widget>[
        // Indicator(isActive),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
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
                        //offset: Offset(-4, -4),
                        blurRadius: 3.0,
                        spreadRadius: -12.0),
                    BoxShadow(
                        color: Colors.white60,
                        offset: Offset(-4, -4),
                        blurRadius: 3.0),
                    BoxShadow(
                        color: Colors.white60,
                        offset: Offset(-4, -4),
                        blurRadius: 3.0),
                    BoxShadow(
                      color: Color(0xffffffff),
                      offset: Offset(-.9, -.9),
                    ),
                    BoxShadow(
                        color: theme.colorScheme.primary.withOpacity(0.3),
                        offset: Offset(4, 4),
                        blurRadius: 3.0),
                    BoxShadow(
                        color: theme.colorScheme.primary.withOpacity(0.3),
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
                            backgroundColor: theme.colorScheme.background,
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
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.calendar_today,
                                      size: 16.0,
                                      color: textDark_Yellow,
                                    ),
                                    FancyText(
                                        color: textDark_Yellow,
                                        text:
                                            ' ${date.toDate().year}-${date.toDate().month}-${date.toDate().day}'),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Icon(
                                        Icons.timer,
                                        size: 16.0,
                                        color: textDark_Yellow,
                                      ),
                                    ),
                                    FancyText(
                                      text: appointment["time"] ?? 'Not set',
                                      color: textDark_Yellow,
                                    )
                                  ],
                                ),
                              ),
                              FancyText(
                                text: appointment['doctor'],
                                fontWeight: FontWeight.w700,
                                size: 15.5,
                                textAlign: TextAlign.left,
                                color: textDark_Yellow,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2.0),
                                    child: FancyText(
                                      text: "Department: ",
                                      textAlign: TextAlign.left,
                                      color: textDark_Yellow,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2.0),
                                    child: FancyText(
                                      text: appointment['department'] ?? '',
                                      textAlign: TextAlign.left,
                                      fontWeight: FontWeight.w500,
                                      color: textDark_Yellow,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 3.0),
                                    child: FancyText(
                                      text: "Hospital: ",
                                      textAlign: TextAlign.left,
                                      color: textDark_Yellow,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 3.0),
                                    child: FancyText(
                                        text: appointment['hospital'],
                                        textAlign: TextAlign.left,
                                        color: textDark_Yellow,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 3.0),
                                child: Row(
                                  children: <Widget>[
                                    FancyText(
                                      text: "Current Status: ",
                                      textAlign: TextAlign.left,
                                      color: textDark_Yellow,
                                    ),
                                    FancyText(
                                      text: appointment["status"] ?? 'pending',
                                      textAlign: TextAlign.left,
                                      size: 15.0,
                                      fontWeight: FontWeight.w700,
                                      color: textLight_Red,
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
          padding: const EdgeInsets.only(
              top: 8.0, bottom: 8.0, left: 15.0, right: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(children: [
                Icon(
                  Icons.phone,
                  color: theme.colorScheme.secondary,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FancyText(
                        text: "Phone Number: ",
                        textAlign: TextAlign.left,
                        size: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                      FancyText(
                        text: appointment["phoneNum"] ?? "",
                        textAlign: TextAlign.left,
                        size: 16.0,
                      ),
                    ],
                  ),
                ),
              ]),
              RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  color: Theme.of(context).colorScheme.secondary,
                  textColor: Colors.white,
                  child: Icon(Icons.phone_forwarded),
                  onPressed: () {
                    // _makePhoneCall(('tel: ${contact[0]}'));
                  }),
            ],
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Container(
        //     height: size.height * 0.35,
        //     width: size.width * 0.95,
        //     decoration: BoxDecoration(
        //       border: Border.all(
        //         color: theme.colorScheme.primary.withOpacity(0.2),
        //       ),
        //       color: theme.colorScheme.background,
        //       borderRadius: BorderRadius.circular(5.0),
        //     ),
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: <Widget>[
        //         Padding(
        //           padding: const EdgeInsets.all(16.0),
        //           child: FancyText(
        //             text: "Description",
        //             size: 15.0,
        //             fontWeight: FontWeight.w500,
        //           ),
        //         ),
        //         Padding(
        //           padding: const EdgeInsets.only(
        //             top: 8.0,
        //             left: 16.0,
        //           ),
        //           child: FancyText(
        //             text: "- Having severe head ache from 3 years.\n- Diabetic",
        //             size: 15.5,
        //             fontWeight: FontWeight.w400,
        //             textAlign: TextAlign.left,
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // )
        Container(
          constraints: BoxConstraints(
            minHeight: size.height * 0.60,
          ),
          height: size.height * 0.60,
          child: Timeline.builder(
              physics: ClampingScrollPhysics(),
              position: TimelinePosition.Left,
              itemCount: diagnosis.length,
              itemBuilder: centerTimelineBuilder),
        )
      ]),
    );
  }
}
