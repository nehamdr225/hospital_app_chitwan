import 'package:chitwan_hospital/UI/pages/SubsPage/Subscription/Apointment.dart';
import 'package:chitwan_hospital/UI/pages/SubsPage/Subscription/Contacts.dart';
import 'package:chitwan_hospital/UI/pages/SubsPage/Subscription/Prescription.dart';
import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:flutter/material.dart';

class AppointmentPage extends StatefulWidget {
  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this, initialIndex: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      bottomNavigationBar: Container(height:75.0, color: theme.colorScheme.background,),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: WhiteAppBar(
            logo: false,
            settings: false,
            tabbar: true,
            title: "Appointment",
            controller: _tabController,
            tabs: <Widget>[
              Tab(
                text: "Prescription",
              ),
              Tab(text: "Appointment"),
              Tab(
                text: "Contacts",
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            Prescription(),
            Appointment(),
            Contacts(),
          ],
        ));
  }
}
