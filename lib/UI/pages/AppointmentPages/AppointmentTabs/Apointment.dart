import 'package:chitwan_hospital/UI/core/const.dart';
import 'package:chitwan_hospital/UI/pages/AppointmentPages/atoms/PrescriptionListCard.dart';
import 'package:chitwan_hospital/state/store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Appointment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appointments = Provider.of<UserDataStore>(context).appointments;
    print(appointments);
    return ListView.builder(
      itemCount: appointments.length,
      itemBuilder: (BuildContext context, int index) {
        Timestamp time = appointments[index]['date'];

        return ListCard(
          name: appointments[index]['doctor'] ?? '',
          caption: appointments[index]['cap'] ?? '',
          image: appointments[index]['src'] ?? '',
          phone: appointments[index]['phone'] ?? '',
          status: appointments[index]['status'] ?? 'Pending',
          date: time?.toDate()??'',
          time: appointments[index]['time'] ?? '',
        );
      },
    );
  }
}
