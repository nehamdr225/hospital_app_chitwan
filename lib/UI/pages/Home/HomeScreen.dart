import 'package:chitwan_hospital/UI/Widget/MainAppBar.dart';
import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/atoms/HoizontalList.dart';
import 'package:chitwan_hospital/UI/core/const.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:chitwan_hospital/UI/pages/AppointmentPages/AppointmentTabs/AppointmentForm.dart';
import 'package:chitwan_hospital/UI/pages/Home/Drawer.dart';
import 'package:chitwan_hospital/UI/pages/Home/HomeListCard.dart';
import 'package:chitwan_hospital/service/database.dart';
import 'package:flutter/material.dart';
import 'package:chitwan_hospital/service/appointment.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newAppointment = new Appointments(null, null, "Department", "Dr. ",
        "Female", "online", "Neha", "KMC", "Mdr", "9840056679");
    final theme = Theme.of(context);
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
        Container(
            height: MediaQuery.of(context).size.height * 0.70,
            child: StreamBuilder(
              stream: DatabaseService.getDoctors(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Text("Loading");
                return ListView.builder(
                    itemCount: snapshot.data.documents.length - 1,
                    itemBuilder: (BuildContext context, int index) {
                      return HomeListCard(
                        doctorName: snapshot.data.documents[index]['name'],
                        department: snapshot.data.documents[index]['field'],
                        image: snapshot.data.documents[index]['src'],
                        phone: snapshot.data.documents[index]['phone'],
                        status: snapshot.data.documents[index]['status'],
                        date: snapshot.data.documents[index]['date'],
                        time: snapshot.data.documents[index]['time'],
                      );
                    });
              },
            )),
      ]),
    );
  }
}
