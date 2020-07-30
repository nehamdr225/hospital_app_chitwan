import 'package:eMed/UI/core/atoms/FancyText.dart';
import 'package:eMed/UI/core/atoms/WhiteAppBar.dart';
import 'package:eMed/UI/core/theme.dart';
import 'package:flutter/material.dart';

class WorkSchedule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: PreferredSize(
            child: WhiteAppBar(
              titleColor: Theme.of(context).colorScheme.primary,
              leading: true,
              title: "Work Schedule",
              fontSize: 15.0,
            ),
            preferredSize: Size.fromHeight(50.0)),
        
        body: Table(children: <TableRow>[
          TableRow(children: [
            Padding(
              padding: const EdgeInsets.only(top: 18.0, left: 8.0),
              child: FancyText(
                text: "Sunday ",
                textAlign: TextAlign.left,
                fontWeight: FontWeight.w800,
                size: 15.0,
                color: blueGrey.withOpacity(0.7),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: FancyText(
                text: "Available",
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
                text: "Monday ",
                textAlign: TextAlign.left,
                fontWeight: FontWeight.w800,
                size: 15.0,
                color: blueGrey.withOpacity(0.7),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: FancyText(
                text: "Available",
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
                text: "Tuesday",
                textAlign: TextAlign.left,
                fontWeight: FontWeight.w800,
                size: 15.0,
                color: blueGrey.withOpacity(0.7),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: FancyText(
                text: "Available",
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
                text: "Wednesday ",
                textAlign: TextAlign.left,
                fontWeight: FontWeight.w800,
                size: 15.0,
                color: blueGrey.withOpacity(0.7),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: FancyText(
                text: "Available",
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
                text: "Thursday ",
                textAlign: TextAlign.left,
                fontWeight: FontWeight.w800,
                size: 15.0,
                color: blueGrey.withOpacity(0.7),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: FancyText(
                text: "Not Available",
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
                text: "Friday ",
                textAlign: TextAlign.left,
                fontWeight: FontWeight.w800,
                size: 15.0,
                color: blueGrey.withOpacity(0.7),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: FancyText(
                text: "Not Available",
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
                text: "Saturday ",
                textAlign: TextAlign.left,
                fontWeight: FontWeight.w800,
                size: 15.0,
                color: blueGrey.withOpacity(0.7),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: FancyText(
                text: "Available",
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