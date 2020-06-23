import 'package:chitwan_hospital/UI/core/const.dart';
import 'package:chitwan_hospital/UI/pages/AppointmentPages/atoms/PrescriptionListCard.dart';
import 'package:flutter/material.dart';

class POngoing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    return ListView.builder(
        itemCount: PrescriptionData.length,
        itemBuilder: (BuildContext context, int index) {
          return ListCard(
            id: '',
            data: true,
          );
        });
  }
}
