import 'package:chitwan_hospital/UI/DoctorsModule/DoctorsModule.dart';
import 'package:chitwan_hospital/UI/HospitalModule/HospitalModule.dart';
import 'package:chitwan_hospital/UI/LabModule/LabModule.dart';
import 'package:chitwan_hospital/UI/PharmacyModule/PharmacyModule.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:chitwan_hospital/UI/pages/Home/HomeScreen.dart';
import 'package:chitwan_hospital/UI/pages/SignIn/SignIn.dart';
import 'package:chitwan_hospital/blank.dart';
import 'package:chitwan_hospital/service/auth.dart';
import 'package:chitwan_hospital/state/app.dart';
import 'package:chitwan_hospital/state/doctor.dart';
import 'package:chitwan_hospital/state/hospital.dart';
import 'package:chitwan_hospital/state/lab.dart';
import 'package:chitwan_hospital/state/pharmacy.dart';
import 'package:chitwan_hospital/state/store.dart';
import 'package:chitwan_hospital/service/user.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

Future main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Color(0xff091654),
  ));
  runApp(BootStrapper());
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class BootStrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => new STheme()),
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => UserDataStore()),
        ChangeNotifierProvider(create: (_) => HospitalDataStore()),
        ChangeNotifierProvider(create: (_) => DoctorDataStore()),
        ChangeNotifierProvider(create: (_) => PharmacyDataStore()),
        ChangeNotifierProvider(create: (_) => LabDataStore()),
      ],
      child: HomeApp(),
    );
  }
}

class HomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<STheme>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //darkTheme: theme.serviceDarkTheme,
      theme: theme.serviceLightTheme,
      home: SafeArea(child: Wrapper() //AppointmentPage()
          ),
    );
  }
}

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  // FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     new FlutterLocalNotificationsPlugin();

  // @override
  // void initState() {
  //   super.initState();
  //   var initializationSettingsAndroid =
  //       new AndroidInitializationSettings('@mipmap/ic_launcher');

  //   var initializationSettingsIOS = new IOSInitializationSettings(
  //       onDidReceiveLocalNotification: onDidRecieveLocalNotification);

  //   var initializationSettings = new InitializationSettings(
  //       initializationSettingsAndroid, initializationSettingsIOS);

  //   flutterLocalNotificationsPlugin.initialize(initializationSettings,
  //       onSelectNotification: onSelectNotification);

  //   _firebaseMessaging.configure(
  //     onMessage: (Map<String, dynamic> message) {
  //       print('on message ${message}');
  //       // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  //       displayNotification(message);
  //       // _showItemDialog(message);
  //     },
  //     onResume: (Map<String, dynamic> message) {
  //       print('on resume $message');
  //     },
  //     onLaunch: (Map<String, dynamic> message) {
  //       print('on launch $message');
  //     },
  //   );
  //   _firebaseMessaging.requestNotificationPermissions(
  //       const IosNotificationSettings(sound: true, badge: true, alert: true));
  //   _firebaseMessaging.onIosSettingsRegistered
  //       .listen((IosNotificationSettings settings) {
  //     print("Settings registered: $settings");
  //   });
  //   _firebaseMessaging.getToken().then((String token) {
  //     assert(token != null);
  //     print(token);
  //   });
  // }

  // Future displayNotification(Map<String, dynamic> message) async {
  //   var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
  //       'channelid', 'flutterfcm', 'your channel description',
  //       importance: Importance.Max, priority: Priority.High);
  //   var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
  //   var platformChannelSpecifics = new NotificationDetails(
  //       androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  //   await flutterLocalNotificationsPlugin.show(
  //     0,
  //     message['notification']['title'],
  //     message['notification']['body'],
  //     platformChannelSpecifics,
  //     payload: 'hello',
  //   );
  // }

  // Future onSelectNotification(String payload) async {
  //   if (payload != null) {
  //     debugPrint('notification payload: ' + payload);
  //   }
  //   // await FlutterToast.showToast(
  //   // msg: "Notification Clicked",
  //   // toastLength: Toast.LENGTH_SHORT,
  //   // gravity: ToastGravity.BOTTOM,
  //   // timeInSecForIos: 1,
  //   // backgroundColor: Colors.black54,
  //   // textColor: Colors.white,
  //   // fontSize: 16.0);
  //   /*Navigator.push(
  //     context,
  //     new MaterialPageRoute(builder: (context) => new SecondScreen(payload)),
  //   );*/
  // }

  // Future onDidRecieveLocalNotification(
  //     int id, String title, String body, String payload) async {
  //   // display a dialog with the notification details, tap ok to go to another page
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) => new CupertinoAlertDialog(
  //       title: new Text(title),
  //       content: new Text(body),
  //       actions: [
  //         CupertinoDialogAction(
  //           isDefaultAction: true,
  //           child: new Text('Ok'),
  //           onPressed: () async {
  //             // Navigator.of(context, rootNavigator: true).pop();
  //             // return FlutterToast(context, );
  //             //     msg: "Notification Clicked",
  //             //     toastLength: Toast.LENGTH_SHORT,
  //             //     gravity: ToastGravity.BOTTOM,
  //             //     timeInSecForIos: 1,
  //             //     backgroundColor: Colors.black54,
  //             //     textColor: Colors.white,
  //             //     fontSize: 16.0);
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: AuthService().user,
        builder: (BuildContext context, AsyncSnapshot<User> user) {
          switch (user.connectionState) {
            case ConnectionState.waiting:
              return BlankLoader();
            default:
              print(user.data);
              if (user.data != null && user.data.uid != null) {
                return FutureBuilder(
                  future: getLocalUserData('userType'),
                  builder: (BuildContext context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return BlankLoader();
                      default:
                        if (snapshot.data == 'doctor')
                          return DoctorsModule();
                        else if (snapshot.data == 'hospital')
                          return HospitalModule();
                        else if (snapshot.data == 'pharmacy')
                          return PharmacyModule();
                        else if (snapshot.data == 'lab') return LabModule();
                        return HomeScreen();
                    }
                  },
                );
              } else {
                return SignIn();
              }
          }
        });

    // return SignIn();
  }
}
