import 'package:eMed/UI/core/atoms/FancyText.dart';
import 'package:eMed/UI/core/theme.dart';
import 'package:eMed/UI/pages/AppointmentPages/AppointmentTabs/AppointmentForm.dart';
import 'package:eMed/UI/pages/Home/DoctorDetails.dart';
import 'package:eMed/models/DoctorAppointment.dart';
import 'package:eMed/state/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class HomeListCard extends StatefulWidget {
  final id;
  HomeListCard({this.id});

  @override
  _HomeListCardState createState() => _HomeListCardState();
}

class _HomeListCardState extends State<HomeListCard> {
  @override
  Widget build(BuildContext context) {
    final doctor = Provider.of<UserDataStore>(context)
        .doctors
        .firstWhere((element) => element.uid == widget.id);

    final newAppointment = new DoctorAppointment(null, null, doctor.department,
        doctor.name, "Female", "online", "Neha", "KMC", "Mdr", "9840056679");
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DoctorDetails(
                    id: doctor.uid,
                  )));
        },
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Theme.of(context).colorScheme.background,
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
                    color: theme.colorScheme.primary.withOpacity(0.3),
                    offset: Offset(4, 4),
                    blurRadius: 3.0),
                BoxShadow(
                    color: theme.colorScheme.primary.withOpacity(0.3),
                    offset: Offset(.9, .9),
                    blurRadius: 1.0),
              ],
            ),
            width: size.width * 0.95,
            height: 160.0,
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: CircleAvatar(
                      backgroundColor: theme.colorScheme.background,
                      backgroundImage:
                          ExactAssetImage("assets/images/doctor.png"),
                      maxRadius: 45.0,
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FancyText(
                            text: doctor.name,
                            fontWeight: FontWeight.w700,
                            size: 15.5,
                            textAlign: TextAlign.left,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 2.0),
                                child: FancyText(
                                  text: "Department: ",
                                  textAlign: TextAlign.left,
                                  defaultStyle: true,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 2.0),
                                child: FancyText(
                                    text: doctor.department ?? 'Not available',
                                    textAlign: TextAlign.left,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 3.0),
                                child: FancyText(
                                  text: "Hospital: ",
                                  textAlign: TextAlign.left,
                                  defaultStyle: true,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 3.0),
                                child: FancyText(
                                    text: "CMC Hospital",
                                    textAlign: TextAlign.left,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 5.0, bottom: 8.0),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.phone,
                                  size: 16.0,
                                  color: theme.colorScheme.primary,
                                ),
                                FancyText(
                                  text: "  ${doctor.phone}",
                                  textAlign: TextAlign.left,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                            child: RaisedButton(
                              onPressed: doctor.department != null
                                  ? () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AppointmentForm(
                                                    appointment: newAppointment,
                                                    doctor: doctor.name,
                                                    department:
                                                        doctor.department,
                                                  )));
                                    }
                                  : () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AppointmentForm(
                                                    appointment: newAppointment,
                                                    doctor: doctor.name,
                                                  )));
                                    },
                              color: theme.colorScheme.secondary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0)),
                              child: FancyText(
                                text: "Book Appointment",
                                size: 15.0,
                                color: textDark_Yellow,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
            // Text(),
            ),
      ),
    );
  }
}
