import 'package:chitwan_hospital/UI/Widget/FRaisedButton.dart';
import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/atoms/SnackBar.dart';
import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:chitwan_hospital/UI/pages/AppointmentPages/AppointmentTabs/AppointmentForm.dart';
import 'package:chitwan_hospital/models/DoctorAppointment.dart';
import 'package:chitwan_hospital/models/Favourites.dart';
import 'package:chitwan_hospital/state/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoctorDetails extends StatelessWidget {
  final id;
  DoctorDetails({this.id});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final userDataStore = Provider.of<UserDataStore>(context);
    final doctor =
        userDataStore.doctors.firstWhere((element) => element.uid == id);
    final isFav = userDataStore.favourites?.firstWhere(
      (element) => element.type == FavouriteType.Doctor && element.favId == id,
      orElse: () => null,
    );
    final newAppointment = new DoctorAppointment(null, null, doctor.department,
        doctor.name, null, null, null, null, null, null);
    print(isFav);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: WhiteAppBar(
          titleColor: theme.colorScheme.primary,
          title: "Doctor's Details",
          color: theme.colorScheme.primary,
          share: true,
          onFavClick: () async {
            if (isFav == null) {
              final fav = Favourite(
                favId: id,
                timestamp: DateTime.now().toIso8601String(),
                userId: userDataStore.user.uid,
                type: FavouriteType.Doctor,
              );
              await userDataStore.favourite(fav.toJson());
              buildAndShowFlushBar(
                text: 'Added to favourites',
                context: context,
                icon: Icons.check,
              );
            } else {
              await userDataStore.deleteFavourite(isFav.id);
              buildAndShowFlushBar(
                text: 'Removed from favourites!',
                context: context,
                icon: Icons.check,
              );
            }
          },
          isFav: isFav != null ? true : false,
        ),
      ),
      backgroundColor: theme.colorScheme.background,
      body: ListView(children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: Center(
            child: Container(
                height: 180.0,
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
                        color: theme.colorScheme.primary.withOpacity(0.3),
                        offset: Offset(4, 4),
                        blurRadius: 3.0),
                    BoxShadow(
                        color: theme.colorScheme.primary.withOpacity(0.3),
                        offset: Offset(.9, .9),
                        blurRadius: 1.0),
                  ],
                ),
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    SizedBox(width: 10.0),
                    Flexible(
                        flex: 1,
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundColor: theme.colorScheme.background,
                          backgroundImage: ExactAssetImage(
                            'assets/images/doctor.png',
                          ),
                        )),
                    Flexible(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 28.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FancyText(
                              text: doctor.name,
                              fontWeight: FontWeight.w700,
                              size: 18.0,
                              textAlign: TextAlign.left,
                              color: textDark_Yellow,
                            ),
                            SizedBox(height: 5.0),
                            FancyText(
                              text: doctor.department ?? '',
                              fontWeight: FontWeight.w400,
                              size: 14.0,
                              textAlign: TextAlign.left,
                              color: textDark_Yellow.withOpacity(0.9),
                            ),
                            SizedBox(height: 2),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow[600],
                                ),
                                SizedBox(width: 1.0),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow[600],
                                ),
                                SizedBox(width: 1.0),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow[600],
                                ),
                                SizedBox(width: 1.0),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow[600],
                                ),
                                SizedBox(width: 1.0),
                                Icon(
                                  Icons.star,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 1.0),
                              ],
                            ),
                            SizedBox(height: 2),
                            FancyText(
                              text: " Rating 4.0",
                              color: textDark_Yellow.withOpacity(0.8),
                              size: 13.0,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )
                // Text(),
                ),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        // Padding(
        //   padding: const EdgeInsets.only(
        //       top: 10.0, right: 10.0, left: 10.0, bottom: 10.0),
        //   child: Container(
        //       alignment: Alignment.center,
        //       height: 90.0,
        //       child: DetailPageOptions(
        //         listViews: Detail_Options,
        //       )),
        // ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 7.0),
          child: FRaisedButton(
            elevation: 1.0,
            width: size.width * 0.95,
            height: 40.0,
            text: "Book Appointment",
            fontSize: 17.0,
            color: textDark_Yellow,
            bg: theme.colorScheme.secondary.withOpacity(0.8),
            shape: true,
            radius: 5.0,
            onPressed: doctor.department != null
                ? () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AppointmentForm(
                                  appointment: newAppointment,
                                  doctor: doctor.name,
                                  department: doctor.department,
                                )));
                  }
                : () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AppointmentForm(
                                  appointment: newAppointment,
                                  doctor: doctor.name,
                                )));
                  },
          ),
        ),
        SizedBox(height: 10.0),
        // SizedBox(
        //   width: size.width,
        //   child: Card(
        //     elevation: 2.0,
        //     child: Padding(
        //       padding: const EdgeInsets.all(12.0),
        //       child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             FancyText(
        //               text: "Pharmacy Information",
        //               textAlign: TextAlign.start,
        //               size: 15.5,
        //               fontWeight: FontWeight.w500,
        //             ),
        //             SizedBox(height: 2.0),
        //             FancyText(
        //               text:
        //                   "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
        //               textAlign: TextAlign.start,
        //               size: 13.5,
        //               fontWeight: FontWeight.w400,
        //             ),
        //           ]),
        //     ),
        //   ),
        // ),
        // Padding(
        //   padding: const EdgeInsets.only(
        //       top: 8.0, bottom: 8.0, left: 15.0, right: 8.0),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: <Widget>[
        //       Row(children: [
        //         Icon(
        //           Icons.phone,
        //           color: theme.colorScheme.primary,
        //         ),
        //         Padding(
        //           padding: const EdgeInsets.only(left: 10.0),
        //           child: Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: <Widget>[
        //               FancyText(
        //                 text: "Phone Number: ",
        //                 textAlign: TextAlign.left,
        //                 size: 15.0,
        //                 fontWeight: FontWeight.w400,
        //               ),
        //               FancyText(
        //                 text: doctor.phone,
        //                 textAlign: TextAlign.left,
        //                 size: 16.0,
        //                 color: theme.colorScheme.secondaryVariant,
        //                 fontWeight: FontWeight.w600,
        //               ),
        //             ],
        //           ),
        //         ),
        //       ]),
        //       RaisedButton(
        //           shape: RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(5.0),
        //           ),
        //           color: Theme.of(context).colorScheme.primary,
        //           textColor: Colors.white,
        //           child: Icon(Icons.phone_forwarded),
        //           onPressed: () {
        //             // _makePhoneCall(('tel: ${contact[0]}'));
        //           }),
        //     ],
        //   ),
        // ),
      ]),
    );
  }
}
