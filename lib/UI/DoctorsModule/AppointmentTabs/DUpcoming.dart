import 'package:chitwan_hospital/UI/DoctorsModule/PatientListCard.dart';
import 'package:chitwan_hospital/UI/core/const.dart';
import 'package:flutter/material.dart';

class DUpcoming extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    return ListView.builder(
        itemCount: PrescriptionData.length,
        itemBuilder: (BuildContext context, int index) {
          return PatientListCard(id: '');
        });
  }
}
