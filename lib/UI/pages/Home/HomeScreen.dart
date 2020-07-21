import 'package:chitwan_hospital/UI/Widget/MainAppBar.dart';
import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/atoms/HoizontalList.dart';
import 'package:chitwan_hospital/UI/core/atoms/Indicator.dart';
import 'package:chitwan_hospital/UI/core/const.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:chitwan_hospital/UI/pages/AppointmentPages/AppointmentTabs/AppointmentForm.dart';
import 'package:chitwan_hospital/UI/pages/Home/Drawer.dart';
import 'package:chitwan_hospital/UI/pages/Home/HomeListCard.dart';
import 'package:chitwan_hospital/models/DoctorAppointment.dart';
import 'package:chitwan_hospital/state/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newAppointment = new DoctorAppointment(null, null, "Department",
        "Dr. ", "Female", "online", "Neha", "KMC", "Mdr", "9840056679");
    final theme = Theme.of(context);
    Provider.of<UserDataStore>(context).handleInitialProfileLoad();
    final List doctors = Provider.of<UserDataStore>(context).doctors;

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: MainAppBar(
            department: "Hospital",
          )),
      backgroundColor: theme.colorScheme.background,
      drawer: DrawerApp(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AppointmentForm(
                        appointment: newAppointment,
                      )));
        },
        icon: Icon(
          Icons.calendar_today,
          color: textDark_Yellow,
        ),
        label: FancyText(
          text: "Make Appointment",
          color: textDark_Yellow,
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: theme.colorScheme.primary,
      ),
      body: ListView(children: <Widget>[
        Indicator(doctors),
        Padding(
          padding: const EdgeInsets.only(
              top: 10.0, right: 10.0, left: 10.0, bottom: 10.0),
          child: Container(
              alignment: Alignment.center,
              height: 110.0,
              child: HorizontalList(
                listViews: Options,
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(
              top: 10.0, right: 10.0, left: 10.0, bottom: 20.0),
          child: FancyText(
            text: "Featured",
            fontWeight: FontWeight.w600,
            color: theme.textTheme.bodyText2.color,
            size: 17.0,
            textAlign: TextAlign.left,
          ),
        ),
        Column(
            children: doctors != null
                ? doctors
                    .map<Widget>((each) => HomeListCard(
                          doctorName: each['name'] ?? '',
                          department: each['department'] ?? '',
                          image: each['src'] ?? '',
                          phone: each['phone'] ?? '',
                          status: each['status'] ?? '',
                          date: each['date'] ?? '',
                          time: each['time'] ?? '',
                        ))
                    .toList()
                : [Text('')]),
      ]),
    );
  }
}
