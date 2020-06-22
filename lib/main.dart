import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:chitwan_hospital/UI/pages/Home/HomeScreen.dart';
import 'package:chitwan_hospital/UI/pages/SignIn/SignIn.dart';
import 'package:chitwan_hospital/service/auth.dart';
import 'package:chitwan_hospital/state/app.dart';
import 'package:chitwan_hospital/state/hospital.dart';
import 'package:chitwan_hospital/state/store.dart';
import 'package:chitwan_hospital/service/user.dart';
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
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => UserDataStore()),
        ChangeNotifierProvider(create: (_) => AppDataStore()),
        ChangeNotifierProvider(create: (_) => HospitalDataStore()),
      ],
      child: HomeApp(),
    );
  }
}

class HomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<STheme>(context);

    return StreamProvider<User>.value(
        value: AuthService().user,
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            //darkTheme: theme.serviceDarkTheme,
            theme: theme.serviceLightTheme,
            home: SafeArea(child: Wrapper() //AppointmentPage()
                )));
  }
}

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserDataStore>(context);
    print(user.uid);
    if (user.uid != null) return HomeScreen();
    return SignIn();
  }
}
