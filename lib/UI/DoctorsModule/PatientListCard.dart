import 'package:eMed/UI/Widget/FRaisedButton.dart';
import 'package:eMed/UI/core/atoms/FancyText.dart';
import 'package:eMed/UI/core/theme.dart';
import 'package:eMed/UI/DoctorsModule/PatientDetail.dart';
import 'package:eMed/state/doctor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class PatientListCard extends StatefulWidget {
  final id;
  PatientListCard({
    this.id,
  });

  @override
  _PatientListCardState createState() => _PatientListCardState();
}

class _PatientListCardState extends State<PatientListCard> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final doctorDataStore = Provider.of<DoctorDataStore>(context);
    final appointment = doctorDataStore.appointments.firstWhere(
      (element) => element['id'] == widget.id,
      orElse: () => null,
    );
    String status = appointment['status'] ?? null;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PatientDetail(
                    id: appointment['id'],
                  )));
        },
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Theme.of(context).colorScheme.background,
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
                    color: theme.colorScheme.primary.withOpacity(0.3),
                    offset: Offset(4, 4),
                    blurRadius: 3.0),
                BoxShadow(
                    color: theme.colorScheme.primary.withOpacity(0.3),
                    offset: Offset(.9, .9),
                    blurRadius: 1.0),
              ],
            ),
            width: size.width * 0.95,
            height: 160.0,
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: CircleAvatar(
                      backgroundColor: theme.colorScheme.background,
                      maxRadius: 35.0,
                      child: Image.asset(
                        "assets/images/addProfileImg.png",
                        height: 40.0,
                        width: 40.0,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FancyText(
                            text: appointment['firstName'] +
                                ' ' +
                                appointment['lastName'],
                            fontWeight: FontWeight.w700,
                            size: 15.5,
                            textAlign: TextAlign.left,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 3.0),
                                child: FancyText(
                                  text: "Gender: ",
                                  textAlign: TextAlign.left,
                                  defaultStyle: true,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 3.0),
                                child: FancyText(
                                    text: appointment['gender'].split('.')[1],
                                    textAlign: TextAlign.left,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 2.0),
                                child: FancyText(
                                  text: "Time: ",
                                  textAlign: TextAlign.left,
                                  defaultStyle: true,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 2.0),
                                child: FancyText(
                                    text: appointment['time'] ?? '',
                                    textAlign: TextAlign.left,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 5.0, bottom: 8.0),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.phone,
                                  size: 16.0,
                                  color: theme.colorScheme.primary,
                                ),
                                FancyText(
                                  text: appointment['phoneNum'],
                                  textAlign: TextAlign.left,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          ),
                          status == null
                              ? Row(
                                  children: <Widget>[
                                    FRaisedButton(
                                      elevation: 0.0,
                                      height: 30.0,
                                      width: 100.0,
                                      text: "Reject",
                                      borderColor: Colors.transparent,
                                      color: textDark_Yellow,
                                      bg: theme.colorScheme.secondary,
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: FancyText(
                                                    text: "Are you sure?",
                                                    size: 15.0,
                                                    fontWeight: FontWeight.w600,
                                                    color: blueGrey),
                                                content: FancyText(
                                                    text:
                                                        "Are you sure you want to reject patient request?",
                                                    size: 15.0,
                                                    fontWeight: FontWeight.w400,
                                                    color: blueGrey),
                                                actions: <Widget>[
                                                  IconButton(
                                                      icon: Icon(
                                                        Icons.cancel,
                                                        color: theme.colorScheme
                                                            .secondary,
                                                      ),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      }),
                                                  IconButton(
                                                      icon: Icon(
                                                        Icons.check_circle,
                                                        color:
                                                            Colors.green[600],
                                                      ),
                                                      onPressed: () {
                                                        doctorDataStore
                                                            .setAppointmentStatus(
                                                                appointment[
                                                                    'id'],
                                                                'rejected');

                                                        Navigator.pop(context);
                                                      }),
                                                ],
                                              );
                                            });
                                      },
                                    ),
                                    SizedBox(width: 10.0),
                                    FRaisedButton(
                                      elevation: 0.0,
                                      height: 30.0,
                                      width: 100.0,
                                      text: "Accept",
                                      borderColor: Colors.transparent,
                                      color: textDark_Yellow,
                                      bg: Colors.green[600],
                                      onPressed: () {
                                        doctorDataStore.setAppointmentStatus(
                                            appointment['id'], 'accepted');
                                      },
                                    )
                                  ],
                                )
                              : status == "rejected"
                                  ? Row(children: [
                                      FancyText(
                                        text: "Rejected",
                                        color: theme.colorScheme.secondary,
                                        fontWeight: FontWeight.w700,
                                        size: 15.0,
                                      ),
                                      SizedBox(width: 20.0),
                                      InkWell(
                                        onTap: () {
                                          doctorDataStore.setAppointmentStatus(
                                              appointment['id'], null);
                                        },
                                        child: FancyText(
                                          text: "Undo",
                                          decoration: TextDecoration.underline,
                                          decorationColor:
                                              theme.colorScheme.secondary,
                                          color: theme.colorScheme.secondary,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )
                                    ])
                                  : FancyText(
                                      text: "Accepted",
                                      color: Colors.green[600],
                                      fontWeight: FontWeight.w700,
                                      size: 15.0,
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
    );
  }
}
