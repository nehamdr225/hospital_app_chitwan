import 'package:flutter/material.dart';
class Category extends StatelessWidget {
  final String src;
  final caption;
  final String name;
  final Function onTap;
  final width;
  final containerWidth;
  final height;

  Category({this.caption, this.src, this.name, this.onTap, this.height: 70.0, this.width: 70.0, this.containerWidth:110});

  @override
  Widget build(BuildContext context) { 
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
            width: containerWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              color: theme.colorScheme.background,
              boxShadow: [                
                BoxShadow(
                    color: Colors.white60,
                    offset: Offset(-4, -4),
                    blurRadius: 3.0),
                BoxShadow(
                  color: Color(0xffffffff),
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
              ],
            ),
            child: ListTile(
              title: Image.asset(
                src,
                width: width,
                height: height,
              ),
              contentPadding: EdgeInsets.all(1.0),
              subtitle: Padding(
                padding: const EdgeInsets.only(top:8.0),
                child: Container(
                  alignment: Alignment.topCenter,
                  child: Text(
                    caption,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
              ),
            )),
        ));
  }
}