import 'package:chitwan_hospital/UI/Widget/MainAppBar.dart';
import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/atoms/HoizontalList.dart';
import 'package:chitwan_hospital/UI/core/atoms/Indicator.dart';
import 'package:chitwan_hospital/UI/core/atoms/RaisedButtons.dart';
import 'package:chitwan_hospital/UI/core/atoms/RowInput.dart';
import 'package:chitwan_hospital/UI/core/const.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:chitwan_hospital/UI/pages/AppointmentPages/AppointmentTabs/AppointmentForm.dart';
import 'package:chitwan_hospital/UI/pages/AppointmentPages/PCRAppointment.dart';
import 'package:chitwan_hospital/UI/pages/Home/Drawer.dart';
import 'package:chitwan_hospital/UI/pages/Hospital/HospitalPromoDetails.dart';
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
              bgcolor: Theme.of(context).colorScheme.primary,
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
    final promotions = userDataStore.promotions;
    final size = MediaQuery.of(context).size;

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
        Indicator(promotions),
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
              top: 20.0, right: 10.0, left: 10.0, bottom: 20.0),
          child: FlatButton(
            color: theme.colorScheme.primary,
            //borderSide: BorderSide(color: theme.colorScheme.primary),
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
                color: Colors.white,//theme.colorScheme.primary,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              top: 10.0, right: 10.0, left: 10.0, bottom: 20.0),
          child: FancyText(
            text: "Promotions",
            fontWeight: FontWeight.w600,
            color: theme.textTheme.bodyText2.color,
            size: 17.0,
            textAlign: TextAlign.left,
          ),
        ),
        Column(
          children: promotions != null
              ? promotions
                  .map<Widget>((promotion) => InkWell(
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => HospitalPromoDetails(
                                      promo: promotion,
                                    ))),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, left: 8.0, right: 8.0, bottom: 10.0),
                          child: Container(
                            width: size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: theme.colorScheme.primary,
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
                                    color: theme.colorScheme.primary
                                        .withOpacity(0.3),
                                    offset: Offset(4, 4),
                                    blurRadius: 3.0),
                                BoxShadow(
                                    color: theme.colorScheme.primary
                                        .withOpacity(0.3),
                                    offset: Offset(.9, .9),
                                    blurRadius: 1.0),
                              ],
                            ),
                            child: Stack(
                              alignment: AlignmentDirectional.center,
                              children: <Widget>[
                                Container(
                                    width: size.width * 0.95,
                                    height: 170.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(promotion.image),
                                          fit: BoxFit.fill),
                                      borderRadius: BorderRadius.circular(8.0),
                                    )),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: Colors.black38,
                                  ),
                                ),
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      FancyText(
                                          letterSpacing: 1.0,
                                          text: promotion.title,
                                          color: textDark_Yellow,
                                          size: 17.0,
                                          fontWeight: FontWeight.w600),
                                      RowInput(
                                        title: "Date:  ",
                                        titleColor: textDark_Yellow,
                                        defaultStyle: false,
                                        caption:
                                            "${promotion.fromDate.split('T')[0]} to ${promotion.fromDate.split('T')[0]}",
                                        capColor: textDark_Yellow,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                      )
                                    ]),
                              ],
                            ),
                          ),
                        ),
                      ))
                  .toList()
              : [],
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
