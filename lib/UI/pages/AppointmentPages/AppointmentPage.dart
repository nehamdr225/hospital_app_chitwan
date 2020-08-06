import 'package:chitwan_hospital/UI/pages/AppointmentPages/AppointmentTabs/Apointment.dart';
import 'package:chitwan_hospital/UI/pages/AppointmentPages/AppointmentTabs/Inquiry.dart';
import 'package:chitwan_hospital/UI/pages/AppointmentPages/AppointmentTabs/LabReports.dart';
import 'package:chitwan_hospital/UI/pages/AppointmentPages/AppointmentTabs/Prescription.dart';
import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:flutter/material.dart';

class AppointmentPage extends StatefulWidget {
  final getIndex;
  AppointmentPage({this.getIndex: 1});
  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(
      length: 4,
      vsync: this,
      initialIndex: widget.getIndex,
    );
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
                text: "Prescription",
              ),
              Tab(text: "Appointment"),
              Tab(
                text: "Lab Reports",
              ),
              Tab(
                text: "Inquiry",
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            Prescription(),
            Appointment(),
            LabReports(),
            Inquiry(),
          ],
        ));
  }
}
