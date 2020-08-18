import 'package:chitwan_hospital/UI/DoctorsModule/DoctorsModule.dart';
import 'package:chitwan_hospital/UI/HospitalModule/HospitalModule.dart';
import 'package:chitwan_hospital/UI/LabModule/LabModule.dart';
import 'package:chitwan_hospital/UI/PharmacyModule/PharmacyModule.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:chitwan_hospital/UI/pages/Home/HomeScreen.dart';
import 'package:chitwan_hospital/blank.dart';
import 'package:chitwan_hospital/state/app.dart';
import 'package:chitwan_hospital/state/doctor.dart';
import 'package:chitwan_hospital/state/hospital.dart';
import 'package:chitwan_hospital/state/lab.dart';
import 'package:chitwan_hospital/state/pharmacy.dart';
import 'package:chitwan_hospital/state/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      theme: theme.serviceLightTheme,
      home: SafeArea(
          child:
              // StreamBuilder(
              //   stream: AuthService.user,
              //   builder: (BuildContext context, AsyncSnapshot<FirebaseUser> user) {
              //     switch (user.connectionState) {
              //       case ConnectionState.waiting:
              //         return BlankLoader();
              //       default:
              //         if (user.data != null && user.data.uid != null) {
              //           return
              FutureBuilder(
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
      )
          // } else {
          //   return SignIn();
          // }
          // }
          //   },
          // ),
          ),
    );
  }
}
