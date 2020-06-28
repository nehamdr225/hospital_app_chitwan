import 'package:chitwan_hospital/UI/DoctorsModule/DoctorProfile.dart';
import 'package:chitwan_hospital/UI/Widget/MainAppBar.dart';
import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/atoms/RaisedButtons.dart';
import 'package:chitwan_hospital/UI/core/const.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:chitwan_hospital/UI/DoctorsModule/DoctorDrawer.dart';
import 'package:chitwan_hospital/UI/DoctorsModule/PatientListCard.dart';
import 'package:chitwan_hospital/state/doctor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoctorsModule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    final doctor = Provider.of<DoctorDataStore>(context).user;
    final appointments = Provider.of<DoctorDataStore>(context).appointments;
    Provider.of<DoctorDataStore>(context).handleInitialProfileLoad();
    print(appointments);
    buildAppointmentRequests() {
      List<Widget> widgets = appointments != null
          ? appointments.map<Widget>((each) {
              return PatientListCard(id: each['id']);
            }).toList()
          : [Text('')];
      return widgets;
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: MainAppBar(
          department: "Doctor",
        ),
      ),
      drawer: DoctorDrawerApp(),
      backgroundColor: theme.background,
      body: ListView(children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 18.0, bottom: 8.0),
          child: Center(
            child: Container(
              height: 150.0,
              width: size.width * 0.95,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                gradient: gradientColor,
                boxShadow: [
                  BoxShadow(
                      color: Colors.white60,
                      //offset: Offset(-4, -4),
                      blurRadius: 3.0,
                      spreadRadius: -12.0),
                  BoxShadow(
                      color: Colors.white60,
                      offset: Offset(-4, -4),
                      blurRadius: 3.0),
                  BoxShadow(
                      color: Colors.white60,
                      offset: Offset(-4, -4),
                      blurRadius: 3.0),
                  BoxShadow(
                    color: Color(0xffffffff),
                    offset: Offset(-.9, -.9),
                  ),
                  BoxShadow(
                      color: theme.primary.withOpacity(0.3),
                      offset: Offset(4, 4),
                      blurRadius: 3.0),
                  BoxShadow(
                      color: theme.primary.withOpacity(0.3),
                      offset: Offset(.9, .9),
                      blurRadius: 1.0),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, left: 28.0, bottom: 0.0),
                        child: FancyText(
                            text:
                                "Hello ${doctor != null ? doctor['name'] : 'Doctor'}!",
                            textAlign: TextAlign.left,
                            size: 22.0,
                            color: textDark_Yellow,
                            fontWeight: FontWeight.w700),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            width: 10.0,
                            height: 10.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: RadialGradient(colors: [
                                  Colors.green[300],
                                  Colors.green,
                                ])),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FancyText(
                                text: "Online",
                                textAlign: TextAlign.left,
                                size: 10.0,
                                color: textDark_Yellow,
                                fontWeight: FontWeight.w700),
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.more_vert,
                                color: textDark_Yellow,
                              ),
                              onPressed: () {})
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0.0, left: 28.0),
                    child: FancyText(
                        text: "Welcome Back",
                        size: 16.0,
                        color: textDark_Yellow,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(top: 0.0, left: 26.0),
                    child: Row(children: [
                      doctor != null && doctor['isVerified']
                          ? Icon(
                              Icons.verified_user,
                              color: Colors.green,
                            )
                          : Icon(
                              Icons.cancel,
                              color: Colors.red,
                            ),
                      SizedBox(
                        height: 2,
                        width: 2,
                      ),
                      doctor != null && doctor['isVerified']
                          ? Text(
                              'Verified',
                              style: TextStyle(
                                color: textDark_Yellow,
                              ),
                            )
                          : Text(
                              'Not Verified',
                              style: TextStyle(
                                color: textDark_Yellow,
                              ),
                            ),
                    ]),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 6.0, left: 28.0, right: 28.0),
                    child: FancyText(
                        text: "All appointment requests are shown below.",
                        textAlign: TextAlign.left,
                        size: 14.0,
                        color: textDark_Yellow,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ),
        ),
        doctor != null && doctor['department'] == null
            ? Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: FRaisedButton(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    needIcon: true,
                    leadingIcon: Stack(
                      alignment: Alignment.topRight,
                      children: <Widget>[
                        Icon(
                          Icons.notifications,
                          color: textDark_Yellow,
                        ),
                        Container(
                          width: 10.0,
                          height: 10.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: RadialGradient(colors: [
                                Colors.red,
                                theme.secondary,
                              ])),
                        ),
                      ],
                    ),
                    trailingIcon: Text(""),
                    shape: true,
                    radius: 5.0,
                    elevation: 1.0,
                    fontSize: 14.5,
                    text: 'Update your Profile!',
                    color: textDark_Yellow,
                    bgcolor: blueGrey,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DoctorProfile()));
                    },
                  ),
                ))
            : Text(''),
        Column(
          // height: MediaQuery.of(context).size.height * 0.70,
          children: buildAppointmentRequests(),
        ),
      ]),
    );
  }
}
