import 'package:chitwan_hospital/UI/Widget/MainAppBar.dart';
import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/atoms/HoizontalList.dart';
import 'package:chitwan_hospital/UI/core/atoms/RaisedButtons.dart';
import 'package:chitwan_hospital/UI/core/const.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:chitwan_hospital/UI/pages/AppointmentPages/AppointmentTabs/AppointmentForm.dart';
import 'package:chitwan_hospital/UI/pages/AppointmentPages/PCRAppointment.dart';
import 'package:chitwan_hospital/UI/pages/Home/Drawer.dart';
import 'package:chitwan_hospital/UI/pages/SignIn/SignIn.dart';
import 'package:chitwan_hospital/models/DoctorAppointment.dart';
import 'package:chitwan_hospital/state/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget promptLoginDialog(context) => Dialog(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0),
            child: FRaisedButton(
              text: 'Login to continue',
              color: textDark_Yellow,
              bgcolor: Theme.of(context).colorScheme.primaryVariant,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SignIn(),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newAppointment = new DoctorAppointment(null, null, "Department",
        "Dr. ", "Female", "online", "Neha", "KMC", "Mdr", "9840056679");
    final theme = Theme.of(context);
    final userDataStore = Provider.of<UserDataStore>(context);
    userDataStore.handleInitialProfileLoad();
    // final doctors = userDataStore.doctors;

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
        // Indicator(doctors),
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
              top: 30.0, right: 10.0, left: 10.0, bottom: 20.0),
          child: OutlineButton(
            color: theme.colorScheme.primary,
            borderSide: BorderSide(color: theme.colorScheme.primary),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      PCRAppointment(appointment: newAppointment),
                ),
              );
            },
            child: Text(
              'Book Online PCR Test',
              style: TextStyle(
                color: theme.colorScheme.primary,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        // Padding(
        //   padding: const EdgeInsets.only(
        //       top: 10.0, right: 10.0, left: 10.0, bottom: 20.0),
        //   child: FancyText(
        //     text: "Featured",
        //     fontWeight: FontWeight.w600,
        //     color: theme.textTheme.bodyText2.color,
        //     size: 17.0,
        //     textAlign: TextAlign.left,
        //   ),
        // ),
        // Column(
        //     children: doctors != null
        //         ? doctors
        //             .map<Widget>((each) => HomeListCard(id: each.uid))
        //             .toList()
        //         : [Text('')]),
      ]),
    );
  }
}
