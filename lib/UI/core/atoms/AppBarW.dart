import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarW extends StatelessWidget {
  final elevation;
  final color;
  final bool logo;
  final bool settings;
  final String title;
  final Color backButtonColor;
  final onPressed;
  final settingOnPressed;
  AppBarW(
      {this.elevation: 0.0,
      this.logo,
      this.settings,
      this.title: "",
      this.color,
      this.backButtonColor,
      this.onPressed,
      this.settingOnPressed});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      elevation: 0.0,
      primary: false,
      iconTheme: theme.iconTheme.copyWith(color: color),
      backgroundColor: Theme.of(context).colorScheme.primaryVariant,
      centerTitle: true,
      title: Text(title, style: theme.textTheme.bodyText1),
      leading: logo == true
          ? Padding(
              padding: EdgeInsets.only(top: 16.0, left: 8.0),
              child: Text(
                'LOGO',
                style: theme.textTheme.bodyText2
                    .copyWith(fontWeight: FontWeight.w800),
              ))
          : IconButton(
              icon: Icon(CupertinoIcons.back, color: backButtonColor,),
              onPressed: onPressed,
            ),
      actions: <Widget>[
        settings == true
            ? IconButton(
                icon: Icon(
                  Icons.settings,
                  color: backButtonColor,
                ),
                onPressed: settingOnPressed,
              )
            : Text(''),
      ],
    );
  }
}
