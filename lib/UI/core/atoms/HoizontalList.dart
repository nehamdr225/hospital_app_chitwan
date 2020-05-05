import 'package:chitwan_hospital/UI/core/atoms/Category.dart';
import 'package:flutter/material.dart';

class HorizontalList extends StatefulWidget {
  final listViews;
  final border;

  HorizontalList({
    this.listViews,
    this.border: false,
  });

  @override
  _HorizontalListState createState() => _HorizontalListState();
}

class _HorizontalListState extends State<HorizontalList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.listViews.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(
              decoration: BoxDecoration(
                  border: widget.border == true
                      ? Border.all(color: Colors.grey[200])
                      : null),
              child: Category(
                name: widget.listViews[index]['name'],
                caption: widget.listViews[index]['name'],
                src: widget.listViews[index]['src'],
                height: 40.0,
                width: 40.0,
                onTap: () {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => GenderSpecific(
                  //       gender: widget.listViews[index]['cap'],
                  //     ),
                  //   ),
                  // );
                },
              ),
            ),
          );
        }, //
      ),
    );
  }
}