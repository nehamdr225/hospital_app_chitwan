import 'package:chitwan_hospital/UI/core/atoms/RaisedButtons.dart';
import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:chitwan_hospital/UI/pages/Home/HomeScreen.dart';
import 'package:chitwan_hospital/state/store.dart';
import 'package:flutter/material.dart';
import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:provider/provider.dart';

class PatientHistoryPage extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final userDataStore = Provider.of<UserDataStore>(context);
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
                  text: title,
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
                  text: medicine ?? 'none',
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
              ),
            ]),
          ]),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: patient && medicine != null && medicine.length > 0
                ? FRaisedButton(
                    text: 'Order Medicine',
                    onPressed: () {
                      userDataStore
                          .orderMedicine(id, medicine, title)
                          .then((bool result) {
                        if (result) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => HomeScreen()));
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
