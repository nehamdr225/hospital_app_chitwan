import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:chitwan_hospital/UI/core/const.dart';
import 'package:chitwan_hospital/UI/pages/Hospital/HospitalList.dart';
import 'package:chitwan_hospital/state/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class HospitalTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final hospitals = Provider.of<UserDataStore>(context).hospitals;
    return Scaffold(
        appBar: PreferredSize(
            child: WhiteAppBar(
              title: "Hospitals",
              titleColor: Theme.of(context).colorScheme.primary,
            ),
            preferredSize: Size.fromHeight(50.0)),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: ListView.builder(
            itemCount: hospitals != null ? hospitals.length : 0,
            itemBuilder: (BuildContext context, int index) {
              return HospitalList(
                id: hospitals[index].uid,
              );
            }));
  }
}
