import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:chitwan_hospital/UI/core/const.dart';
import 'package:chitwan_hospital/UI/pages/Hospital/HospitalList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HospitalTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            child: WhiteAppBar(
              title: "Hospitals",
              titleColor: Theme.of(context).colorScheme.primary,
            ),
            preferredSize: Size.fromHeight(50.0)),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: ListView.builder(
            itemCount: Hospital_List.length,
            itemBuilder: (BuildContext context, int index) {
              return HospitalList(
                hospitalName: Hospital_List[index]['name'],
              );
            }));
  }
}
