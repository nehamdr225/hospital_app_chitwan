import 'package:chitwan_hospital/UI/pages/AppointmentPages/atoms/PrescriptionListCard.dart';
import 'package:chitwan_hospital/state/store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Appointment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appointments = Provider.of<UserDataStore>(context).appointments;
    return ListView.builder(
      itemCount: appointments.length,
      itemBuilder: (BuildContext context, int index) {
        return ListCard(id: appointments[index]['id']);
      },
    );
  }
}
