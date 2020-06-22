import 'package:chitwan_hospital/UI/HospitalModule/AddPromotion.dart';
import 'package:chitwan_hospital/UI/HospitalModule/AllPromotion.dart';
import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:flutter/material.dart';

class PromotionTab extends StatefulWidget {
  @override
  _PromotionTabState createState() => _PromotionTabState();
}

class _PromotionTabState extends State<PromotionTab>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this, initialIndex: 1);
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
            title: "Promotions",
            controller: _tabController,
            tabs: <Widget>[
              Tab(
                text: "All Promotions",
              ),
              Tab(text: "Add New Promotions"),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            AllPromotions(),
            AddPromotion()
          ],
        ));
  }
}
