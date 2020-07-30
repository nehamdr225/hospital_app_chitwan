import 'package:eMed/UI/core/atoms/Category.dart';
import 'package:eMed/UI/pages/Home/DoctorsTab.dart';
import 'package:eMed/UI/pages/Pharmacy/PharmacyTab.dart';
import 'package:flutter/material.dart';

class DetailPageOptions extends StatefulWidget {
  final listViews;
  final border;
  final scrollDirection;

  DetailPageOptions({
    this.listViews,
    this.border: false,
    this.scrollDirection:Axis.horizontal,
  });

  @override
  _DetailPageOptionsState createState() => _DetailPageOptionsState();
}

class _DetailPageOptionsState extends State<DetailPageOptions> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: widget.scrollDirection,
      itemCount: widget.listViews.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(
            right: 8.0,
          ),
          child: Category(
            name: widget.listViews[index]['name'],
            caption: widget.listViews[index]['name'],
            src: widget.listViews[index]['src'],
            height: 40.0,
            width: 40.0,
            containerWidth: 90.0,
            onTap: () {
              if(widget.listViews[index]['id']==0){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DoctorsTab(
                  ),
                ),
              );
              }
              else if(widget.listViews[index]['id']==1){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PharmacyTab(
                  ),
                ),
              );
              }
            },
          ),
        );
      }, //
    );
  }
}
