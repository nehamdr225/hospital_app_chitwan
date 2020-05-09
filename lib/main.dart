import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:chitwan_hospital/UI/pages/HomeScreen.dart';
import 'package:chitwan_hospital/UI/pages/SubsPage/AppointmentPage.dart';
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
    // Fetch _fetch = Fetch();
    // CoreSecureStorage _storage = CoreSecureStorage();
    // ProductApi _productApi = ProductApi(_fetch);
    // UserApi _userApi = UserApi(_fetch, _storage);
    // Validator _validator = Validator();

    return MultiProvider(
      providers: [
      //   ChangeNotifierProvider(create: (_) => new ProductModel(_productApi)),
      //   ChangeNotifierProvider(
      //       create: (_) => new UserModel(_userApi, _storage, _validator)),
        ChangeNotifierProvider(create: (_) => new STheme())
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
      home: SafeArea(
        child: HomeScreen()//AppointmentPage()
      )
    );
  }
}
