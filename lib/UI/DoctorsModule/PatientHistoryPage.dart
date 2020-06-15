import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';

class PatientHistoryPage extends StatelessWidget {
  final String date;
  final String diagnosis;
  final String investigation;
  final String medicine;
  final String followUp;
  PatientHistoryPage(
      {this.date,
      this.diagnosis: "no data",
      this.followUp: "no data",
      this.investigation: "no data",
      this.medicine: "no data"});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: PreferredSize(
            child: WhiteAppBar(
              titleColor: Theme.of(context).colorScheme.primary,
              leading: true,
              title: date,
              fontSize: 15.0,
            ),
            preferredSize: Size.fromHeight(50.0)),
        
        body: Table(children: <TableRow>[
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
                text: diagnosis,
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
                text: "Investigation: ",
                textAlign: TextAlign.left,
                fontWeight: FontWeight.w800,
                size: 15.0,
                color: blueGrey.withOpacity(0.7),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: FancyText(
                text: investigation,
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
                text: "Medicine: ",
                textAlign: TextAlign.left,
                fontWeight: FontWeight.w800,
                size: 15.0,
                color: blueGrey.withOpacity(0.7),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: FancyText(
                text: medicine,
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
                text: followUp,
                textAlign: TextAlign.left,
                size: 15.5,
                fontWeight: FontWeight.w700,
                color: blueGrey,
              ),
            )
          ]),
        ]));
  }
}
