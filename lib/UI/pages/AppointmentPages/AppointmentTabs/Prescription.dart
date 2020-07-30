import 'package:eMed/UI/pages/AppointmentPages/AppointmentTabs/PrescriptionCard.dart';
import 'package:eMed/state/user.dart';
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
            id: prescriptions[index].id,
          );
        });
  }
}
