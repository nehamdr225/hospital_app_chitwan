import 'package:eMed/UI/Widget/MainAppBar.dart';
import 'package:eMed/UI/core/atoms/FancyText.dart';
import 'package:eMed/UI/core/atoms/HoizontalList.dart';
import 'package:eMed/UI/core/atoms/Indicator.dart';
import 'package:eMed/UI/core/const.dart';
import 'package:eMed/UI/core/theme.dart';
import 'package:eMed/UI/pages/AppointmentPages/AppointmentTabs/AppointmentForm.dart';
import 'package:eMed/UI/pages/Home/Drawer.dart';
import 'package:eMed/UI/pages/Home/HomeListCard.dart';
import 'package:eMed/UI/pages/SignIn/SignIn.dart';
import 'package:eMed/models/DoctorAppointment.dart';
import 'package:eMed/service/auth.dart';
import 'package:eMed/state/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newAppointment = new DoctorAppointment(null, null, "Department",
        "Dr. ", "Female", "online", "Neha", "KMC", "Mdr", "9840056679");
    final theme = Theme.of(context);
    final userDataStore = Provider.of<UserDataStore>(context);
    userDataStore.handleInitialProfileLoad();
    final doctors = userDataStore.doctors;
    if (userDataStore.user == null)
      Future.delayed(Duration(seconds: 10)).then((value) {
        if (userDataStore.user == null) {
          AuthService.signOut();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => SignIn()),
              (route) => false);
        }
      });

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
                    .map<Widget>((each) => HomeListCard(id: each.uid))
                    .toList()
                : [Text('')]),
      ]),
    );
  }
}
