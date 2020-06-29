import 'package:chitwan_hospital/UI/core/const.dart';
import 'package:chitwan_hospital/UI/pages/AppointmentPages/AppointmentTabs/PrescriptionCard.dart';
import 'package:chitwan_hospital/UI/pages/AppointmentPages/atoms/PrescriptionListCard.dart';
import 'package:chitwan_hospital/state/store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Prescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    final prescriptions = Provider.of<UserDataStore>(context).prescriptions;
    // print(prescriptions);
    return ListView.builder(
        itemCount: prescriptions.length,
        itemBuilder: (BuildContext context, int index) {
          return PrescriptionCard(
            id: prescriptions[index]['id'],
            medicine: prescriptions[index]['medicine'],
            status: prescriptions[index]['status'] ?? null,
          );
        });
  }
}
