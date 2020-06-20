import 'package:chitwan_hospital/UI/LabModule/LabModule.dart';
import 'package:chitwan_hospital/UI/LabModule/LabProfile.dart';
import 'package:chitwan_hospital/UI/Widget/FRaisedButton.dart';
import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/const.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:chitwan_hospital/UI/pages/Home/DrawerElements.dart';
import 'package:chitwan_hospital/UI/pages/Home/HomeScreen.dart';
import 'package:chitwan_hospital/UI/pages/SignIn/SignIn.dart';
import 'package:chitwan_hospital/service/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LabDrawerApp extends StatefulWidget {
  @override
  _LabDrawerAppState createState() => _LabDrawerAppState();
}

class _LabDrawerAppState extends State<LabDrawerApp> {
  final AuthService _auth = AuthService();
  final user = AuthService().user;

  @override
  Widget build(BuildContext context) {
    //final name = Firestore.instance.collection("users").document(uid).snapshots().toString();
    //final uid = Provider.of<AuthService>(context).getCurrentUid;
    final theme = Theme.of(context);
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            user != null
                ? FutureBuilder(
                    future: Provider.of<AuthService>(context).getCurrentUser(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return UserAccountsDrawerHeader(
                          accountName: FancyText(
                            text: "Name", //"${snapshot.data.displayName}",
                            size: 16.0,
                            fontWeight: FontWeight.w600,
                            color: textDark_Yellow,
                          ),
                          accountEmail: FancyText(
                            text: "Email", //snapshot.data.email,
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
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    })
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
                    MaterialPageRoute(builder: (context) => LabModule()));
              },
            ),
            user != null
                ? DrawerElements(
                    //Settings
                    title: 'Profile',
                    icon: 'assets/images/drawerIcon/profile.png',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LabProfile()));
                    },
                  )
                : Text(" "),
            
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
            user != null
                ? Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 18.0, right: 18.0),
                    child: FRaisedButton(
                        elevation: 0.0,
                        height: 40.0,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                        text: "Login As User",
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        },
                        color: blueGrey,
                        bg: Colors.white,
                        shape: false),
                  )
                : Text(' '),
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
                          _auth.signOut();
                          setState(() {
                            loggedIn = false;
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignIn()));
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
