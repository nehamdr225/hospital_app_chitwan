import 'package:chitwan_hospital/UI/core/atoms/GridLook.dart';
import 'package:chitwan_hospital/UI/pages/DoctorsModule//DoctorsModule.dart';
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
          padding: const EdgeInsets.all(8.0),
          child: GridLook(
            color: Colors.white,
              name: listViews[index]['name'],
              caption: listViews[index]['cap'],
              src: listViews[index]['src'],
              onTap: () {
              if (listViews[index]['id'] == 0) {
                print("Doctors Module");
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => DoctorsModule()));
              } else if (listViews[index]['id'] == 1){
                print("Pharmacy Module");
              }

              }),
              
        );
      },
    );
  }
}
