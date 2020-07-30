import 'package:eMed/UI/PharmacyModule/PharmacyCard.dart';
import 'package:eMed/UI/Widget/MainAppBar.dart';
import 'package:eMed/UI/core/atoms/FancyText.dart';
import 'package:eMed/UI/core/atoms/Indicator.dart';
import 'package:eMed/UI/core/theme.dart';
import 'package:eMed/UI/PharmacyModule/PharmacyDrawer.dart';
import 'package:eMed/UI/pages/SignIn/SignIn.dart';
import 'package:eMed/models/PharmacyAppointment.dart';
import 'package:eMed/service/auth.dart';
import 'package:eMed/state/pharmacy.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PharmacyModule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    final pharmacyDataStore = Provider.of<PharmacyDataStore>(context);
    pharmacyDataStore.handleInitialProfileLoad();
    final List<PharmacyAppointment> orders = pharmacyDataStore.orders != null
        ? pharmacyDataStore.orders
            .where((element) => element.status == null)
            .toList()
        : [];
    if (pharmacyDataStore.user == null)
      Future.delayed(Duration(seconds: 10)).then((value) {
        if (pharmacyDataStore.user == null) {
          AuthService.signOut();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => SignIn()),
              (route) => false);
        }
      });
    buildOrderWidgets() {
      return orders != null
          ? orders
              .map<Widget>(
                (each) => PharmacyCard(id: each.id),
              )
              .toList()
          : [SizedBox.shrink()];
    }

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: MainAppBar(
            department: "Pharmacy",
          ),
        ),
        drawer: PharmacyDrawerApp(),
        backgroundColor: theme.background,
        body: ListView(children: <Widget>[
          Indicator(pharmacyDataStore.user),
          Padding(
            padding: const EdgeInsets.only(top: 18.0, bottom: 8.0),
            child: Center(
              child: Container(
                height: 150.0,
                width: size.width * 0.95,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  gradient: gradientColor,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.white60,
                        //offset: Offset(-4, -4),
                        blurRadius: 3.0,
                        spreadRadius: -12.0),
                    BoxShadow(
                        color: Colors.white60,
                        offset: Offset(-4, -4),
                        blurRadius: 3.0),
                    BoxShadow(
                        color: Colors.white60,
                        offset: Offset(-4, -4),
                        blurRadius: 3.0),
                    BoxShadow(
                      color: Color(0xffffffff),
                      offset: Offset(-.9, -.9),
                    ),
                    BoxShadow(
                        color: theme.primary.withOpacity(0.3),
                        offset: Offset(4, 4),
                        blurRadius: 3.0),
                    BoxShadow(
                        color: theme.primary.withOpacity(0.3),
                        offset: Offset(.9, .9),
                        blurRadius: 1.0),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, left: 28.0, bottom: 0.0),
                          child: FancyText(
                              text: "Welcome back!",
                              textAlign: TextAlign.left,
                              size: 22.0,
                              color: textDark_Yellow,
                              fontWeight: FontWeight.w700),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              width: 10.0,
                              height: 10.0,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: RadialGradient(colors: [
                                    Colors.green[300],
                                    Colors.green,
                                  ])),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FancyText(
                                  text: "Online",
                                  textAlign: TextAlign.left,
                                  size: 10.0,
                                  color: textDark_Yellow,
                                  fontWeight: FontWeight.w700),
                            ),
                            IconButton(
                                icon: Icon(
                                  Icons.more_vert,
                                  color: textDark_Yellow,
                                ),
                                onPressed: () {})
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0, left: 28.0),
                      child: FancyText(
                          text: pharmacyDataStore.user != null
                              ? pharmacyDataStore.user.name
                              : 'Loading...',
                          size: 16.0,
                          color: textDark_Yellow,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 6.0, left: 28.0, right: 28.0),
                      child: FancyText(
                          text: "All pharmacy requests are shown below.",
                          textAlign: TextAlign.left,
                          size: 14.0,
                          color: textDark_Yellow,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Column(children: buildOrderWidgets())
        ]),
      ),
    );
  }
}
