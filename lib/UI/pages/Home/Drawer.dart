import 'package:chitwan_hospital/UI/Chat/ChatHome.dart';
import 'package:chitwan_hospital/UI/Widget/FRaisedButton.dart';
import 'package:chitwan_hospital/UI/core/atoms/DrawerEPanel.dart';
import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/const.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:chitwan_hospital/UI/pages/Home/AccountPage.dart';
import 'package:chitwan_hospital/UI/pages/Home/DoctorsTab.dart';
import 'package:chitwan_hospital/UI/pages/Home/DrawerElements.dart';
import 'package:chitwan_hospital/UI/pages/Home/FavoritePage.dart';
import 'package:chitwan_hospital/UI/pages/Home/HomeScreen.dart';
import 'package:chitwan_hospital/UI/pages/SignIn/SignIn.dart';
import 'package:chitwan_hospital/UI/pages/AppointmentPages/AppointmentPage.dart';
import 'package:chitwan_hospital/service/auth.dart';
import 'package:chitwan_hospital/state/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerApp extends StatefulWidget {
  @override
  _DrawerAppState createState() => _DrawerAppState();
}

class _DrawerAppState extends State<DrawerApp> {
  @override
  Widget build(BuildContext context) {
    final userDataStore = Provider.of<UserDataStore>(context);
    final user = userDataStore.user;

    final theme = Theme.of(context);

    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            user != null
                ? UserAccountsDrawerHeader(
                    accountName: FancyText(
                      text: user.name,
                      size: 16.0,
                      fontWeight: FontWeight.w600,
                      color: textDark_Yellow,
                    ),
                    accountEmail: FancyText(
                      text: user.email,
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
                                          fontWeight: FontWeight.w500,
                                          color: textDark_Yellow)),
                              contentPadding: EdgeInsets.only(left: 5.0),
                              trailing: Icon(
                                Icons.arrow_right,
                                color: theme.iconTheme.color,
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignIn()));
                              },
                              // onTap: () {
                              //   setState(() {
                              //     loggedIn = true;
                              //   });
                              // },
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
            user != null
                ? DrawerElements(
                    //Favorite
                    title: 'Favourites',
                    icon: 'assets/images/drawerIcon/favorite.png',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FavoritePage()));
                    },
                  )
                : SizedBox(height: 0.0),
            DrawerEPanel([
              ListItem(
                  title: Image.asset(
                    'assets/images/drawerIcon/calendar.png',
                    height: 25.0,
                    width: 25.0,
                  ),
                  subtitle: "Appointment & Orders",
                  bodyBuilder: (context) => Column(children: <Widget>[
                        user != null
                            ? DrawerElements(
                                //Appointments
                                title: 'Appointments',
                                icon: 'assets/images/drawerIcon/calendar.png',
                                iconSize: 0.0,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AppointmentPage()));
                                },
                              )
                            : SizedBox.shrink(),
                        user != null
                            ? DrawerElements(
                                //Appointments
                                title: 'Prescription',
                                icon: 'assets/images/drawerIcon/calendar.png',
                                iconSize: 0.0,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AppointmentPage(
                                                getIndex: 0,
                                              )));
                                },
                              )
                            : SizedBox.shrink(),
                        user != null
                            ? DrawerElements(
                                //Appointments
                                title: 'Lab Reports',
                                icon: 'assets/images/drawerIcon/calendar.png',
                                iconSize: 0.0,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AppointmentPage(
                                                getIndex: 2,
                                              )));
                                },
                              )
                            : SizedBox.shrink(),
                      ]))
            ]),

            DrawerElements(
              //Specialities
              title: 'Specialities',
              icon: 'assets/images/drawerIcon/specialist.png',
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DoctorsTab()));
              },
            ),
            user != null
                ? DrawerElements(
                    //Appointments
                    title: 'Messages',
                    icon: 'assets/images/drawerIcon/chat.png',
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ChatHome()));
                    },
                  )
                : SizedBox.shrink(),
            // DrawerElements(
            //   //Settings
            //   title: 'Settings',
            //   icon: 'assets/images/drawerIcon/setting.png',
            //   onTap: () {
            //     // Navigator.push(context,
            //     //     MaterialPageRoute(builder: (context) => CartPage()));
            //   },
            // ),
            user != null
                ? DrawerElements(
                    //Settings
                    title: 'Profile',
                    icon: 'assets/images/drawerIcon/profile.png',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AccountPage()));
                    },
                  )
                : SizedBox(height: 0.0),
            Divider(
              color: Colors.grey[500],
              height: 5.0,
            ),
            DrawerElements(
              //Share
              title: 'Share',
              icon: 'assets/images/drawerIcon/shareButton.png',
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: FancyText(
                            text: "Share",
                            defaultStyle: true,
                            fontWeight: FontWeight.w700,
                            size: 17.0,
                            opacity: 1.0,
                          ),
                          content: Row(
                              //crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  "assets/images/facebookicon.png",
                                  height: 45.0,
                                  width: 45.0,
                                ),
                                SizedBox(width: 10.0),
                                Image.asset(
                                  "assets/images/googleicon.png",
                                  height: 30.0,
                                  width: 30.0,
                                ),
                              ]),
                        ));
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
            // user != null
            //     ? Padding(
            //         padding: const EdgeInsets.only(
            //             top: 10.0, left: 18.0, right: 18.0),
            //         child: FRaisedButton(
            //             elevation: 0.0,
            //             height: 40.0,
            //             fontSize: 15.0,
            //             fontWeight: FontWeight.w600,
            //             text: "Login As...",
            //             onPressed: () {
            //               Navigator.push(
            //                   context,
            //                   MaterialPageRoute(
            //                       builder: (context) => OthersLogin()));
            //             },
            //             color: blueGrey,
            //             bg: Colors.white,
            //             shape: false),
            //       )
            //     : Text(' '),
            user != null
                ? Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 18.0, right: 18.0),
                    child: FRaisedButton(
                        elevation: 0.0,
                        height: 40.0,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                        borderColor: theme.colorScheme.secondary,
                        text: "Sign Out",
                        onPressed: () async {
                          AuthService.signOut();
                          userDataStore.clearState();
                          setState(() {
                            loggedIn = false;
                          });
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => SignIn()),
                              (Route<dynamic> route) => false);
                        },
                        color: textDark_Yellow,
                        bg: theme.colorScheme.secondary,
                        shape: false),
                  )
                : Text(' '),
            SizedBox(height: 15.0)
          ],
        ),
      ),
    );
  }
}
