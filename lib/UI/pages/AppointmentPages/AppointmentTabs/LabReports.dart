import 'package:chitwan_hospital/UI/LabModule/LabCard.dart';
import 'package:chitwan_hospital/state/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LabReports extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    final labs = Provider.of<UserDataStore>(context).labs;
    return ListView.builder(
        itemCount: labs != null ? labs.length : 0,
        itemBuilder: (BuildContext context, int index) {
          return LabCard(
            email: labs[index].email,
            name: labs[index].name,
            phone: labs[index].phone,
            title: labs[index].timestamp,
            status: labs[index].status,
          );
        });
  }
}
