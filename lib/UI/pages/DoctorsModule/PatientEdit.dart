import 'package:chitwan_hospital/UI/Widget/FRaisedButton.dart';
import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:chitwan_hospital/UI/core/const.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:flutter/material.dart';

class PatientEdit extends StatefulWidget {
  @override
  _PatientEditState createState() => _PatientEditState();
}

class _PatientEditState extends State<PatientEdit> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020, 1),
      lastDate: DateTime(2020, 9),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark(),
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark(),
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedTime)
      setState(() {
        selectedTime = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context).colorScheme;
    var style = TextStyle(
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.bold,
        fontSize: 15,
        color: blueGrey.withOpacity(0.9));
    return Scaffold(
      appBar: PreferredSize(
          child: WhiteAppBar(
            titleColor: theme.primary,
            title: "Edit",
          ),
          preferredSize: Size.fromHeight(60.0)),
      backgroundColor: theme.background,
      body: Column(children: <Widget>[
        Padding(
          //date
          padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FancyText(
                text: "Change date: ",
                size: 16.0,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.left,
              ),
              Container(
                height: 40.0,
                width: size.width * 0.50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.white,
                    border: Border.all(
                      width: 1,
                      color: theme.primary,
                    )),
                child: Center(
                  child: Text(
                    "${selectedDate.day.toString()}-${selectedDate.month.toString()}-${selectedDate.year.toString()}",
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
          padding: const EdgeInsets.only(
              top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FancyText(
                  text: "Change Time:",
                  size: 16.0,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.left,
                ),
                Container(
                  height: 40.0,
                  width: size.width * 0.50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.white,
                      border: Border.all(
                        width: 1,
                        color: theme.primary,
                      )),
                  child: Center(
                    child: Text(
                      "${selectedTime.format(context)}",
                      style: style,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.timer),
                  onPressed: () => _selectTime(context),
                ),
              ]),
        ),
        doctorDecision == "undecided"
            ? Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    FancyText(
                      text: "Accept/Reject:",
                      size: 16.0,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(width: 8.0),
                    FRaisedButton(
                      elevation: 0.0,
                      height: 40.0,
                      width: 90.0,
                      text: "Reject",
                      borderColor: theme.secondary,
                      color: textDark_Yellow,
                      bg: theme.secondary.withOpacity(0.5),
                      onPressed: () {
                        setState(() {
                          doctorDecision = "rejected";
                        });
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
                                        color: theme.secondary,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          doctorDecision = "undecided";
                                        });
                                        Navigator.pop(context);
                                      }),
                                  IconButton(
                                      icon: Icon(
                                        Icons.check_circle,
                                        color: Colors.green[600],
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          doctorDecision = "rejected";
                                        });
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
                      height: 40.0,
                      width: 90.0,
                      text: "Accept",
                      borderColor: Colors.green[600],
                      color: Colors.black,
                      bg: Colors.green[600].withOpacity(0.5),
                      onPressed: () {
                        setState(() {
                          doctorDecision = "accepted";
                        });
                      },
                    )
                  ],
                ))
            : doctorDecision == "rejected"
                ? Row(children: [
                    FancyText(
                      text: "Request has been:",
                      size: 16.0,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(width: 10.0),
                    FancyText(
                      text: "Rejected",
                      color: theme.secondary,
                      fontWeight: FontWeight.w700,
                      size: 15.0,
                    ),
                    SizedBox(width: 20.0),
                    InkWell(
                      onTap: () {
                        setState(() {
                          doctorDecision = "undecided";
                        });
                      },
                      child: FancyText(
                        text: "undo",
                        decoration: TextDecoration.underline,
                        decorationColor: theme.secondary,
                        color: theme.secondary,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ])
                : Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
                    child: Row(
                      children: <Widget>[
                        FancyText(
                          text: "Request has been:",
                          size: 16.0,
                          fontWeight: FontWeight.w500,
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(width: 10.0),
                        FancyText(
                          text: "Accepted",
                          color: Colors.green[600],
                          fontWeight: FontWeight.w700,
                          size: 15.0,
                        ),
                      ],
                    ),
                  ),
        Padding(
          padding: const EdgeInsets.only(
              top: 18.0, left: 10.0, right: 10.0, bottom: 10.0),
          child: FRaisedButton(
            elevation: 0.0,
            height: 40.0,
            width: 220.0,
            text: "Save",
            borderColor: Colors.transparent,
            color: textDark_Yellow,
            bg: theme.primary,
            onPressed: () {},
          ),
        ),
      ]),
    );
  }
}
