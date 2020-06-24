import 'package:chitwan_hospital/UI/HospitalModule/DoctorCards.dart';
import 'package:chitwan_hospital/UI/HospitalModule/HospitalDrawer.dart';
import 'package:chitwan_hospital/UI/HospitalModule/HospitalProfile.dart';
import 'package:chitwan_hospital/UI/Widget/MainAppBar.dart';
import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/atoms/RaisedButtons.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:chitwan_hospital/state/hospital.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HospitalModule extends StatelessWidget {
  final name;
  HospitalModule({this.name});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    Provider.of<HospitalDataStore>(context).handleInitialProfileLoad();
    final hospital = Provider.of<HospitalDataStore>(context).user;
    final List doctors = Provider.of<HospitalDataStore>(context).doctors;
    // print(doctors);
    buildHospitalDoctors() {
      return doctors
          .map<Widget>((e) => HospitalDoctorListCard(id: e['id']))
          .toList();
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: MainAppBar(
          department: "Hospital",
        ),
      ),
      drawer: HospitalDrawerApp(),
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
                                hospital != null ? hospital['name'] : "Hello!",
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
                  SizedBox(
                    height: 40.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 6.0, left: 28.0, right: 28.0),
                    child: FancyText(
                        text: "All inquiries requests are shown below.",
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
        hospital != null && hospital['departments'] == null
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
                          builder: (context) => HospitalProfileSettings()));
                    },
                  ),
                ))
            : Text(''),
        Column(children: buildHospitalDoctors()),
      ]),
    );
  }
}
