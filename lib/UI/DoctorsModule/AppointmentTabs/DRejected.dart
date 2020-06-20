import 'package:chitwan_hospital/UI/DoctorsModule/AppointmentTabs/DoctorListCard.dart';
import 'package:chitwan_hospital/UI/core/const.dart';
import 'package:flutter/material.dart';

class DRejected extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   // final theme = Theme.of(context);
    return ListView.builder(
          itemCount: PrescriptionData.length,
          itemBuilder: (BuildContext context, int index) {
            return DoctorListCard(
              name: NearYou[index]['name'],
              caption: NearYou[index]['cap'],
              image: NearYou[index]['src'],
              phone: NearYou[index]['phone'],
              status: 'Rejected',
              date: NearYou[index]['date'],
              time:NearYou[index]['time'],
            );
          }
    );
  }
}
