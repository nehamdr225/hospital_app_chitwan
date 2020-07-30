import 'package:eMed/UI/core/atoms/WhiteAppBar.dart';
import 'package:eMed/UI/core/const.dart';
import 'package:eMed/UI/pages/Ambulance/AmbulanceListCard.dart';
import 'package:flutter/material.dart';

class AmbulanceTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            child: WhiteAppBar(
              title: "All Ambulances",
              titleColor: Theme.of(context).colorScheme.primary,
            ),
            preferredSize: Size.fromHeight(50.0)),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: ListView.builder(
            itemCount: Ambulance_List.length,
            itemBuilder: (BuildContext context, int index) {
              return AmbulanceListCard(
                hospitalName: Ambulance_List[index]['name'],
                hospitalLocation: Ambulance_List[index]['location'],
                driverName: Ambulance_List[index]['driver'],
                image: Ambulance_List[index]['src'],
                phone: Ambulance_List[index]['phone'],
              );
            })
       
        );
  }
}