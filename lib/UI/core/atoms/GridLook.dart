import 'package:eMed/UI/core/atoms/FancyText.dart';
import 'package:flutter/material.dart';

class GridLook extends StatelessWidget {
  final src;
  final imgheight;
  final name;
  final caption;
  final wishlist;
  final onTap;
  final color;
  GridLook({
    this.src,
    this.imgheight,
    this.name,
    this.caption,
    this.wishlist,
    this.onTap,
    this.color,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    //final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 0.0, color: Colors.transparent),
          borderRadius: BorderRadius.circular(8.0),
          color: color, //Theme.of(context).colorScheme.background,
          boxShadow: [
            BoxShadow(
                color: theme.colorScheme.background.withOpacity(0.3),
                offset: Offset(-4, -4),
                blurRadius: 3.0),
            BoxShadow(
              color: theme.colorScheme.background.withOpacity(0.3),
              offset: Offset(-.9, -.9),
            ),
            BoxShadow(
                color: theme.colorScheme.primary.withOpacity(0.3),
                offset: Offset(4, 4),
                blurRadius: 3.0),
            BoxShadow(
                color: theme.colorScheme.primary.withOpacity(0.3),
                offset: Offset(.9, .9),
                blurRadius: 1.0),
          ]),
      child: InkWell(
        onTap: onTap,
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              height: 70.0,
              width: 70.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  src,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            FancyText(
              text: name,
              size: 16.0,
            ),
            //Divider(),

            //SizedBox(height: 5,)
          ],
        ),
      ),
    );
  }
}
