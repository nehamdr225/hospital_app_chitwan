import 'package:eMed/UI/LabModule/LabCard.dart';
import 'package:eMed/UI/LabModule/LabInfoUpload.dart';
import 'package:eMed/UI/core/atoms/WhiteAppBar.dart';
import 'package:eMed/state/lab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LabOrderTab extends StatefulWidget {
  @override
  _LabOrderTabState createState() => _LabOrderTabState();
}

class _LabOrderTabState extends State<LabOrderTab>
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
            title: "Laboratory",
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
            LabCompleted(),
            LabOngoing(),
            LabRejected(),
          ],
        ));
  }
}

class LabOngoing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    final orders = Provider.of<LabDataStore>(context)
        .orders
        .where((element) => element.status == null || element.status == 'ready')
        .toList();
    return ListView.builder(
        itemCount: orders.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LabInfoUpload(
                          id: orders[index].id,
                        )),
              );
            },
            child: LabCard(
              email: orders[index].email,
              name: orders[index].name,
              phone: orders[index].phone,
              title: orders[index].title,
              timestamp: orders[index].timestamp,
            ),
          );
        });
  }
}

class LabCompleted extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    final orders = Provider.of<LabDataStore>(context)
        .orders
        .where(
            (element) => element.status != null && element.status == 'complete')
        .toList();
    return ListView.builder(
        itemCount: orders.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LabInfoUpload(id: orders[index].id)),
              );
            },
            child: LabCard(
              email: orders[index].email,
              name: orders[index].name,
              phone: orders[index].phone,
              title: orders[index].title,
              timestamp: orders[index].timestamp,
            ),
          );
        });
  }
}

class LabRejected extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    final orders = Provider.of<LabDataStore>(context)
        .orders
        .where(
            (element) => element.status != null && element.status == 'rejected')
        .toList();
    return ListView.builder(
        itemCount: orders.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LabInfoUpload(id: orders[index].id)),
              );
            },
            child: LabCard(
              email: orders[index].email,
              name: orders[index].name,
              phone: orders[index].phone,
              title: orders[index].title,
              timestamp: orders[index].timestamp,
            ),
          );
        });
  }
}
