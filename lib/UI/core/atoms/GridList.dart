import 'package:chitwan_hospital/UI/core/atoms/GridLook.dart';
import 'package:flutter/material.dart';

class GridList extends StatelessWidget {
  GridList({
    this.listViews,
    this.crossAxisCount,
  });
  final listViews;
  final crossAxisCount;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      primary: false,
      //physics: new NeverScrollableScrollPhysics(),
      itemCount: listViews.length,
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount),
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(14.0),
          child: GridLook(
              name: listViews[index]['name'],
              caption: listViews[index]['cap'],
              src: listViews[index]['src'],
              onTap: () {}),
        );
      },
    );
  }
}
