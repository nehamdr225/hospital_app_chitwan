import 'package:chitwan_hospital/UI/DoctorsModule/AppointmentTabs/DCompleted.dart';
import 'package:chitwan_hospital/UI/DoctorsModule/AppointmentTabs/DRejected.dart';
import 'package:chitwan_hospital/UI/DoctorsModule/AppointmentTabs/DUpcoming.dart';
import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:flutter/material.dart';

class DoctorAppointmentPage extends StatefulWidget {
  @override
  _DoctorAppointmentPageState createState() => _DoctorAppointmentPageState();
}

class _DoctorAppointmentPageState extends State<DoctorAppointmentPage>
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
      backgroundColor: theme.colorScheme.background,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: WhiteAppBar(
            titleColor: theme.colorScheme.primary,
            logo: false,
            settings: false,
            tabbar: true,
            title: "Appointment",
            controller: _tabController,
            tabs: <Widget>[
              Tab(
                text: "Completed",
              ),
              Tab(text: "Upcoming"),
              Tab(
                text: "Rejected",
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            DCompleted(),
            DUpcoming(),
            DRejected(),
          ],
        ));
  }
}
