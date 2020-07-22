import 'package:chitwan_hospital/UI/HospitalModule/HospitalModule.dart';
import 'package:chitwan_hospital/UI/HospitalModule/HospitalProfile.dart';
import 'package:chitwan_hospital/UI/HospitalModule/PromotionTab.dart';
import 'package:chitwan_hospital/UI/Widget/FRaisedButton.dart';
import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/const.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:chitwan_hospital/UI/pages/Home/DrawerElements.dart';
import 'package:chitwan_hospital/UI/pages/SignIn/SignIn.dart';
import 'package:chitwan_hospital/service/auth.dart';
import 'package:chitwan_hospital/state/hospital.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HospitalDrawerApp extends StatefulWidget {
  @override
  _HospitalDrawerAppState createState() => _HospitalDrawerAppState();
}

class _HospitalDrawerAppState extends State<HospitalDrawerApp> {
  @override
  Widget build(BuildContext context) {
    final hospitalDataStore = Provider.of<HospitalDataStore>(context);
    final user = hospitalDataStore.user;
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
                      text: user != null ? user.name : '',
                      size: 16.0,
                      fontWeight: FontWeight.w600,
                      color: textDark_Yellow,
                    ),
                    accountEmail: FancyText(
                      text: user != null ? user.email : '',
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
                    MaterialPageRoute(builder: (context) => HospitalModule()));
              },
            ),
            // user != null
            //     ? DrawerElements(
            //         //Settings
            //         title: 'Profile',
            //         icon: 'assets/images/drawerIcon/profile.png',
            //         onTap: () {
            //           Navigator.push(
            //               context,
            //               MaterialPageRoute(
            //                   builder: (context) => DoctorProfile()));
            //         },
            //       )
            //     : SizedBox(height:0.0),
            DrawerElements(
              //Home
              title: 'Promotions',
              icon: 'assets/images/drawerIcon/calendar.png',
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PromotionTab()));
              },
            ),
            DrawerElements(
              //Home
              title: 'Profile',
              icon: 'assets/images/drawerIcon/profile.png',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HospitalProfileSettings()));
              },
            ),

            Divider(
              color: Colors.grey[500],
              height: 5.0,
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
            //             text: "Login As User",
            //             onPressed: () {
            //               Navigator.push(
            //                   context,
            //                   MaterialPageRoute(
            //                       builder: (context) => HomeScreen()));
            //             },
            //             color: blueGrey,
            //             bg: Colors.white,
            //             shape: false),
            //       )
            //     : SizedBox(height:0.0),
            user != null
                ? Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 18.0, right: 18.0),
                    child: FRaisedButton(
                        elevation: 0.0,
                        height: 40.0,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                        text: "Sign Out",
                        onPressed: () async {
                          AuthService.signOut();
                          hospitalDataStore.clearState();
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
                : SizedBox(height: 0.0),
            SizedBox(height: 15.0)
          ],
        ),
      ),
    );
  }
}
