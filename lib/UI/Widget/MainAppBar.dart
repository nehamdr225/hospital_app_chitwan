import 'package:eMed/UI/core/atoms/FancyText.dart';
import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget {
  final String department;
  MainAppBar({this.department});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      elevation: 0.0,
      primary: true,
      iconTheme: theme.iconTheme,
      backgroundColor: Theme.of(context).colorScheme.background,
      centerTitle: true,
      title: FancyText(
        text: department,
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
    );
  }
}
