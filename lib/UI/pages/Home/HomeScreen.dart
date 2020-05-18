import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/atoms/HoizontalList.dart';
import 'package:chitwan_hospital/UI/core/const.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:chitwan_hospital/UI/pages/AppointmentForm.dart';
import 'package:chitwan_hospital/UI/pages/Home/Drawer.dart';
import 'package:chitwan_hospital/UI/pages/Home/HomeListCard.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          elevation: 0.0,
          primary: true,
          iconTheme: theme.iconTheme,
          backgroundColor: Theme.of(context).colorScheme.background,
          centerTitle: true,
          title: FancyText(
            text: "Hospital",
            fontWeight: FontWeight.w600,
            size: 20.0,
            color: theme.colorScheme.primary,
          ),
          leading: Builder(builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.sort),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              iconSize: 30.0,
            );
          }),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.more_vert,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
      backgroundColor: theme.colorScheme.background,
      drawer: DrawerApp(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => AppointmentForm()));
        },
        icon: Icon(Icons.calendar_today),
        label: FancyText(
          text: "Make Appointment",
          color: textDark_Yellow,
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: theme.colorScheme.primary,
      ),
      body: ListView(children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
              top: 10.0, right: 10.0, left: 10.0, bottom: 10.0),
          child: Container(
              alignment: Alignment.center,
              height: 110.0,
              child: HorizontalList(
                listViews: Options,
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(
              top: 10.0, right: 10.0, left: 10.0, bottom: 20.0),
          child: FancyText(
            text: "Featured",
            fontWeight: FontWeight.w600,
            color: theme.textTheme.body1.color,
            size: 17.0,
            textAlign: TextAlign.left,
          ),
        ),
        Container(
            height: MediaQuery.of(context).size.height * 0.70,
            child: ListView.builder(
                itemCount: NearYou.length - 1,
                itemBuilder: (BuildContext context, int index) {
                  return HomeListCard(
                    name: NearYou[index]['name'],
                    caption: NearYou[index]['cap'],
                    image: NearYou[index]['src'],
                    phone: NearYou[index]['phone'],
                    status: NearYou[index]['status'],
                    date: NearYou[index]['date'],
                    time: NearYou[index]['time'],
                  );
                })),
      ]),
    );
  }
}
