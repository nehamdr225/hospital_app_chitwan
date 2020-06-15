import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:chitwan_hospital/UI/core/const.dart';
import 'package:chitwan_hospital/UI/pages/Lab/LabratoryListCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class LabTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            child: WhiteAppBar(
              title: "All Labratories",
              titleColor: Theme.of(context).colorScheme.primary,
            ),
            preferredSize: Size.fromHeight(50.0)),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: ListView.builder(
            itemCount: Lab_List.length,
            itemBuilder: (BuildContext context, int index) {
              return LabratoryListCard(
                labName: Lab_List[index]['name'],
                labLocation: Lab_List[index]['location'],
                image: Lab_List[index]['src'],
                phone: Lab_List[index]['phone'],
              );
            })
       
        );
  }
}
