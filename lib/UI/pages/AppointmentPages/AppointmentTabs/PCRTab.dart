import 'package:chitwan_hospital/UI/HospitalModule/PCRTabs.dart';
import 'package:chitwan_hospital/state/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PCRTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appointments = Provider.of<UserDataStore>(context).pcr;
    return ListView.builder(
      itemCount: appointments.length,
      itemBuilder: (BuildContext context, int index) {
        return PCRCard(
          date: appointments[index].date,
          name: appointments[index].firstName +
              ' ' +
              appointments[index].lastName,
          phone: appointments[index].phoneNum,
          status: appointments[index].status,
          time: appointments[index].time,
        );
      },
    );
  }
}
