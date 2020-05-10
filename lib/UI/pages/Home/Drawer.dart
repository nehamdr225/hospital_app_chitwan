import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:chitwan_hospital/UI/pages/Home/DrawerElements.dart';
import 'package:chitwan_hospital/UI/pages/HomeScreen.dart';
import 'package:chitwan_hospital/UI/pages/SubsPage/AppointmentPage.dart';
import 'package:flutter/material.dart';

class DrawerApp extends StatelessWidget {
  final bool loggedIn;
  DrawerApp({this.loggedIn: true});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            loggedIn == true
                ? UserAccountsDrawerHeader(
                    accountName: FancyText(
                      text: "Neha Mdr.",
                      size: 16.0,
                      fontWeight: FontWeight.w600,
                      color: textDark_Yellow,
                    ),
                    accountEmail: FancyText(
                      text: "himalayaninfotechnp@gmail.com",
                      size: 13.0,
                      fontWeight: FontWeight.w500,
                      color: textDark_Yellow,
                    ),
                    currentAccountPicture: GestureDetector(
                      child: CircleAvatar(
                        backgroundColor: Colors.white54,
                        child: Icon(Icons.person, color: Colors.black45),
                      ),
                    ),
                    decoration: BoxDecoration(
                      gradient: gradientColor,
                    ),
                  )
                : DrawerHeader(
                    decoration: BoxDecoration(
                      //color: primary,
                      gradient: gradientColor,
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 40.0,
                            child: Image.asset(
                              'assets/images/doctor.png',
                              height: 45.0,
                              width: 35.0,
                            ),
                          ),
                          Container(
                            //login/signup
                            color: Colors.transparent,
                            alignment: Alignment.bottomLeft,
                            child: ListTile(
                              title: Text('Log in   .   Sign up',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500)),
                              contentPadding: EdgeInsets.only(left: 5.0),
                              trailing: Icon(
                                Icons.arrow_right,
                                color: theme.iconTheme.color,
                              ),
                              onTap: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => UserPromptApp()));
                              },
                            ),
                          )
                        ])),
            Padding(
              padding: EdgeInsets.all(3.0),
            ),
            DrawerElements(
              //Home
              title: 'Home',
              icon: 'assets/images/drawerIcon/home.png',
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
            ),
            DrawerElements(
              //Favorite
              title: 'Favorite',
              icon: 'assets/images/drawerIcon/favorite.png',
              onTap: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => HomePageApp()));
              },
            ),
            DrawerElements(
              //Appointments
              title: 'Appointments',
              icon: 'assets/images/drawerIcon/calendar.png',
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AppointmentPage()));
              },
            ),
            DrawerElements(
              //Specialities
              title: 'Specialities',
              icon: 'assets/images/drawerIcon/specialist.png',
              onTap: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => CartPage()));
              },
            ),
            DrawerElements(
              //Settings
              title: 'Settings',
              icon: 'assets/images/drawerIcon/setting.png',
              onTap: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => CartPage()));
              },
            ),
            Divider(
              color: Colors.grey[500],
              height: 5.0,
            ),
            DrawerElements(
              //Share
              title: 'Share',
              icon: 'assets/images/drawerIcon/shareButton.png',
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => HelpCenter()),
                // );
              },
            ),
            DrawerElements(
              // About Us
              title: 'About Us',
              icon: 'assets/images/drawerIcon/about.png',
              onTap: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => AboutPage()));
              },
            ),
            DrawerElements(
              // Terms & Conditions
              title: 'Terms & Conditions',
              icon: 'assets/images/drawerIcon/terms.png',
              onTap: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => AboutPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
