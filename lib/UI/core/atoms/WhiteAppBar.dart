import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WhiteAppBar extends StatelessWidget {
  final elevation;
  final color;
  final bool logo;
  final bool leading;
  final bool settings;
  final String title;
  final tabbar;
  final controller;
  final List<Widget> tabs;
  WhiteAppBar(
      {this.elevation: 0.0,
      this.logo,
      this.leading: true,
      this.settings,
      this.tabbar: false,
      this.tabs,
      this.controller,
      this.title: "",
      this.color: Colors.white});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      elevation: 0.0,
      primary: true,
      iconTheme: theme.iconTheme.copyWith(color: color),
      backgroundColor: Theme.of(context).colorScheme.background,
      centerTitle: true,
      bottom: tabbar == true
          ? TabBar(
              indicatorColor: theme.colorScheme.secondaryVariant,
              unselectedLabelStyle: theme.textTheme.body1,
              unselectedLabelColor:
                  theme.textTheme.body1.color, //unselectedWidgetColor,
              labelColor: theme.colorScheme.onPrimary,
              tabs: tabs,
              controller: controller,
            )
          : null,
      title: FancyText(
        text: title,
        fontWeight: FontWeight.w600,
        size: 18.0,
        color: theme.colorScheme.primary,
      ),
      leading: leading == true
          ? logo == true
              ? Padding(
                  padding: const EdgeInsets.only(top: 5.0, left: 7.0),
                  child: Image.asset(
                    "assets/images/caduceus.png",
                  ),
                )
              : IconButton(
                  icon: Icon(
                    CupertinoIcons.back,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
          : null,
      actions: <Widget>[
        settings == true
            ? IconButton(
                icon: Icon(
                  Icons.settings,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () {},
              )
            : Text(''),
      ],
    );
  }
}
