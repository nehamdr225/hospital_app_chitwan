import 'package:flutter/material.dart';

class DrawerElements extends StatelessWidget {
  final String title;
  final icon;
  final iconSize;
  final onTap;
  final bool titleWidgets;
  final Widget widgets;
  DrawerElements(
      {this.title,
      this.icon,
      this.iconSize: 30.0,
      this.onTap,
      this.titleWidgets: false,
      this.widgets});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: titleWidgets == false
          ? Text(title,
              style: Theme.of(context).textTheme.body1.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 15.0
            ))
          : widgets,
      leading: Image.asset(
        icon,
        height: iconSize,
        width: iconSize,
        //color: gradient,
      ),
      trailing: Icon(Icons.arrow_right),
      onTap: onTap,
    );
  }
}
