import 'package:eMed/UI/LabModule/LabCard.dart';
import 'package:eMed/UI/LabModule/LabDrawer.dart';
import 'package:eMed/UI/LabModule/LabInfoUpload.dart';
import 'package:eMed/UI/LabModule/LabOrder.dart';
import 'package:eMed/UI/LabModule/LabOrderTab.dart';
import 'package:eMed/UI/Widget/MainAppBar.dart';
import 'package:eMed/UI/core/atoms/FancyText.dart';
import 'package:eMed/UI/core/atoms/Indicator.dart';
import 'package:eMed/UI/core/atoms/RaisedButtons.dart';
import 'package:eMed/UI/core/theme.dart';
import 'package:eMed/UI/pages/SignIn/SignIn.dart';
import 'package:eMed/service/auth.dart';
import 'package:eMed/state/lab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum AvalibilityState { online, away, busy }

class LabModule extends StatefulWidget {
  final name;
  LabModule({this.name});

  @override
  _LabModuleState createState() => _LabModuleState();
}

class _LabModuleState extends State<LabModule> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    final labDataStore = Provider.of<LabDataStore>(context);
    labDataStore.handleInitialProfileLoad();
    final orders = labDataStore.orders != null
        ? labDataStore.orders
            .where((element) => element.status == null)
            .toList()
        : [];

    if (labDataStore.user == null)
      Future.delayed(Duration(seconds: 10)).then((value) {
        if (labDataStore.user == null) {
          AuthService.signOut();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => SignIn()),
              (route) => false);
        }
      });

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: MainAppBar(
            department: "Laboratory",
          ),
        ),
        drawer: LabDrawerApp(),
        backgroundColor: theme.background,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LabOrder()));
          },
          icon: Icon(
            Icons.calendar_today,
            color: textDark_Yellow,
          ),
          label: FancyText(
            text: "Create Order",
            color: textDark_Yellow,
            fontWeight: FontWeight.w600,
          ),
          backgroundColor: theme.primary,
        ),
        body: ListView(children: <Widget>[
          Indicator(labDataStore.user),
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
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          content:
                                              FancyText(text: "Coming Soon!"),
                                        );
                                      });
                                })
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0, left: 28.0),
                      child: FancyText(
                          text: labDataStore.user != null
                              ? labDataStore.user.name
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
                          text: "All on going lab tests are shown below.",
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
          orders != null && orders.length > 0
              ? Column(
                  children: orders
                      .map<Widget>((e) => InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LabInfoUpload(
                                          id: e.id,
                                        )),
                              );
                            },
                            child: LabCard(
                              name: e.name,
                              email: e.email,
                              phone: e.phone,
                              title: e.title,
                              timestamp: e.timestamp,
                            ),
                          ))
                      .toList(),
                )
              : Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: FancyText(
                        text: 'You have no new orders!',
                        color: Colors.black87,
                      ),
                    ),
                    FRaisedButton(
                      width: size.width * 0.90,
                      text: 'View all orders',
                      bgcolor: theme.primary,
                      color: textDark_Yellow,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => LabOrderTab(),
                          ),
                        );
                      },
                      radius: 10.0,
                      shape: true,
                    )
                  ],
                )
        ]),
      ),
    );
  }
}
