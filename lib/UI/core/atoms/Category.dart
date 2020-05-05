import 'package:flutter/material.dart';
class Category extends StatelessWidget {
  final String src;
  final caption;
  final String name;
  final Function onTap;
  final width;
  final height;

  Category({this.caption, this.src, this.name, this.onTap, this.height: 70.0, this.width: 70.0});

  @override
  Widget build(BuildContext context) { 
    return Padding(
      padding: EdgeInsets.all(2.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
            width: 110.0,
            child: ListTile(
              title: Image.asset(
                src,
                width: width,
                height: height,
              ),
              contentPadding: EdgeInsets.all(1.0),
              subtitle: Padding(
                padding: const EdgeInsets.only(top:10.0),
                child: Container(
                  alignment: Alignment.topCenter,
                  child: Text(
                    caption,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.body1,
                  ),
                ),
              ),
            )),
        ));
  }
}