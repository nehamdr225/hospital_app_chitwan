import 'package:chitwan_hospital/UI/core/atoms/Indicator.dart';
import 'package:chitwan_hospital/UI/core/atoms/RaisedButtons.dart';
import 'package:chitwan_hospital/UI/core/atoms/SnackBar.dart';
import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:chitwan_hospital/UI/pages/AppointmentPages/AppointmentTabs/AppointmentDetail.dart';
import 'package:chitwan_hospital/state/user.dart';
import 'package:flutter/material.dart';
import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:provider/provider.dart';

class PatientHistoryPage extends StatefulWidget {
  final String date;
  final String diagnosis;
  final String title;
  final String medicine;
  final String followUp;
  final bool patient;
  final String id;
  PatientHistoryPage({
    this.date,
    this.diagnosis,
    this.followUp: "no data",
    this.title: "no data",
    this.medicine,
    this.patient: false,
    this.id,
  });

  @override
  _PatientHistoryPageState createState() => _PatientHistoryPageState();
}

class _PatientHistoryPageState extends State<PatientHistoryPage> {
  bool isActive = false;
  @override
  Widget build(BuildContext context) {
    final userDataStore = Provider.of<UserDataStore>(context);
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: PreferredSize(
            child: WhiteAppBar(
              titleColor: Theme.of(context).colorScheme.primary,
              leading: true,
              title: widget.date,
              fontSize: 15.0,
              bottom: PreferredSize(
                child: BoolIndicator(isActive),
                preferredSize: Size.fromHeight(1),
              ),
            ),
            preferredSize: Size.fromHeight(51.0)),
        body: ListView(children: [
          Table(children: <TableRow>[
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.only(top: 18.0, left: 8.0),
                child: FancyText(
                  text: "Title: ",
                  textAlign: TextAlign.left,
                  fontWeight: FontWeight.w800,
                  size: 15.0,
                  color: blueGrey.withOpacity(0.7),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: FancyText(
                  text: widget.title,
                  textAlign: TextAlign.left,
                  size: 15.5,
                  fontWeight: FontWeight.w700,
                  color: blueGrey,
                ),
              )
            ]),
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.only(top: 18.0, left: 8.0),
                child: FancyText(
                  text: "Diagnosis: ",
                  textAlign: TextAlign.left,
                  fontWeight: FontWeight.w800,
                  size: 15.0,
                  color: blueGrey.withOpacity(0.7),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: FancyText(
                  text: widget.diagnosis,
                  textAlign: TextAlign.left,
                  size: 15.5,
                  fontWeight: FontWeight.w700,
                  color: blueGrey,
                ),
              )
            ]),
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.only(top: 18.0, left: 8.0),
                child: FancyText(
                  text: "Medicines: ",
                  textAlign: TextAlign.left,
                  fontWeight: FontWeight.w800,
                  size: 15.0,
                  color: blueGrey.withOpacity(0.7),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: FancyText(
                  text: widget.medicine ?? 'none',
                  textAlign: TextAlign.left,
                  size: 15.5,
                  fontWeight: FontWeight.w700,
                  color: blueGrey,
                ),
              )
            ]),
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.only(top: 18.0, left: 8.0),
                child: FancyText(
                  text: "Follow Up: ",
                  textAlign: TextAlign.left,
                  fontWeight: FontWeight.w800,
                  size: 15.0,
                  color: blueGrey.withOpacity(0.7),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: FancyText(
                  text: widget.followUp,
                  textAlign: TextAlign.left,
                  size: 15.5,
                  fontWeight: FontWeight.w700,
                  color: blueGrey,
                ),
              ),
            ]),
          ]),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: widget.patient &&
                    widget.medicine != null &&
                    widget.medicine.length > 0
                ? FRaisedButton(
                    text: 'Order Medicine',
                    onPressed: isActive
                        ? null
                        : () {
                            setState(() {
                              isActive = true;
                            });
                            userDataStore
                                .orderMedicine(
                                    widget.id, widget.medicine, widget.title)
                                .then((bool result) {
                              setState(() {
                                isActive = false;
                              });
                              if (result) {
                                buildAndShowFlushBar(
                                  context: context,
                                  icon: Icons.check,
                                  text: 'Medicine ordered sucessfully!',
                                );
                                Future.delayed(Duration(seconds: 2)).then(
                                  (_) => Navigator.of(context)
                                      .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AppointmentDetail(
                                                    id: widget.id,
                                                  )),
                                          (route) => false),
                                );
                              } else {
                                buildAndShowFlushBar(
                                  context: context,
                                  icon: Icons.error_outline,
                                  text: 'Error ocurred!',
                                  backgroundColor:
                                      Theme.of(context).colorScheme.error,
                                );
                              }
                            });
                          },
                    bgcolor: Theme.of(context).primaryColorDark,
                    color: textDark_Yellow,
                  )
                : Text(''),
          )
        ]));
  }
}
