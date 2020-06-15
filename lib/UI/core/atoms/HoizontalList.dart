import 'package:chitwan_hospital/UI/core/atoms/Category.dart';
import 'package:chitwan_hospital/UI/pages/Home/DoctorsTab.dart';
import 'package:chitwan_hospital/UI/pages/Lab/LabTab.dart';
import 'package:chitwan_hospital/UI/pages/Pharmacy/PharmacyTab.dart';
import 'package:flutter/material.dart';

class HorizontalList extends StatefulWidget {
  final listViews;
  final border;
  final scrollDirection;

  HorizontalList({
    this.listViews,
    this.border: false,
    this.scrollDirection: Axis.horizontal,
  });

  @override
  _HorizontalListState createState() => _HorizontalListState();
}

class _HorizontalListState extends State<HorizontalList> {
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
            height: 60.0,
            width: 50.0,
            containerWidth: 110.0,
            onTap: () {
              if (widget.listViews[index]['id'] == 0) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DoctorsTab(),
                  ),
                );
              } else if (widget.listViews[index]['id'] == 1) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PharmacyTab(),
                  ),
                );
              } else if (widget.listViews[index]['id'] == 3) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => LabTab(),
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
