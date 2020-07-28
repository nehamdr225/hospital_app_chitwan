import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WhiteAppBar extends StatelessWidget {
  final elevation;
  final color;
  final bool logo;
  final bool leading;
  final bool settings;
  final bool download;
  final String title;
  final Color titleColor;
  final Color backgroundColor;
  final fontSize;
  final tabbar;
  final controller;
  final share;
  final bottom;
  final List<Widget> tabs;
  final onFavClick;
  bool isFav;
  WhiteAppBar({
    this.elevation: 0.0,
    this.logo,
    this.fontSize: 18.0,
    this.leading: true,
    this.settings,
    this.tabbar: false,
    this.tabs,
    this.share: false,
    this.download: false,
    this.titleColor,
    this.controller,
    this.title: "",
    this.backgroundColor,
    this.color,
    this.bottom,
    this.isFav,
    this.onFavClick,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      elevation: 0.0,
      primary: true,
      iconTheme: theme.iconTheme.copyWith(color: color),
      backgroundColor: backgroundColor != null
          ? backgroundColor
          : Theme.of(context).colorScheme.background,
      centerTitle: true,
      bottom: tabbar == true
          ? TabBar(
              indicatorColor: theme.colorScheme.secondaryVariant,
              unselectedLabelStyle: theme.textTheme.bodyText2,
              unselectedLabelColor:
                  theme.textTheme.bodyText2.color, //unselectedWidgetColor,
              labelColor: theme.colorScheme.onPrimary,
              tabs: tabs,
              controller: controller,
              isScrollable: true,
            )
          : bottom,
      title: FancyText(
        text: title,
        fontWeight: FontWeight.w600,
        size: fontSize, //18.0,
        color: titleColor, //theme.colorScheme.primary,
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
                    color: color != null
                        ? color
                        : Theme.of(context).colorScheme.primary,
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
            : SizedBox.shrink(),
        share == true
            ? IconButton(
                icon: Icon(
                  Icons.share,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () {})
            : SizedBox.shrink(),
        onFavClick != null
            ? IconButton(
                icon: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onPressed: onFavClick)
            : SizedBox.shrink(),
        download == true
            ? IconButton(
                icon: Icon(
                  Icons.file_download,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () {},
              )
            : SizedBox.shrink(),
      ],
    );
  }
}
