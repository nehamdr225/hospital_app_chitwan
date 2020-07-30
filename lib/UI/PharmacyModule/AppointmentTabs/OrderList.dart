import 'package:eMed/UI/PharmacyModule/AppointmentTabs/PCompleted.dart';
import 'package:eMed/UI/PharmacyModule/AppointmentTabs/POngoing.dart';
import 'package:eMed/UI/PharmacyModule/AppointmentTabs/PRejected.dart';
import 'package:eMed/UI/core/atoms/WhiteAppBar.dart';
import 'package:flutter/material.dart';

class OrderList extends StatefulWidget {
  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList>
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
            title: "Pharmacy",
            controller: _tabController,
            tabs: <Widget>[
              Tab(
                text: "Completed",
              ),
              Tab(text: "On-Going"),
              Tab(
                text: "Rejected",
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            PCompleted(),
            POngoing(),
            PRejected(),
          ],
        ));
  }
}
