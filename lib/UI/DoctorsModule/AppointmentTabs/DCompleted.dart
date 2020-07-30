import 'package:eMed/UI/DoctorsModule/PatientListCard.dart';
import 'package:eMed/state/doctor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DCompleted extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appointments = Provider.of<DoctorDataStore>(context)
        .appointments
        .where((element) => element['status'] == 'completed')
        .toList();
    return ListView.builder(
        itemCount: appointments.length,
        itemBuilder: (BuildContext context, int index) {
          return PatientListCard(id: appointments[index]['id']);
        });
  }
}
