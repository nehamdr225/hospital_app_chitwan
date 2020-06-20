import 'package:chitwan_hospital/UI/DoctorsModule/AppointmentTabs/DoctorListCard.dart';
import 'package:chitwan_hospital/UI/core/const.dart';
import 'package:flutter/material.dart';

class PRejected extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   // final theme = Theme.of(context);
    return ListView.builder(
          itemCount: PrescriptionData.length,
          itemBuilder: (BuildContext context, int index) {
            return 
            
            DoctorListCard(
              name: PrescriptionData[index]['name'],
              caption: PrescriptionData[index]['cap'],
              image: PrescriptionData[index]['src'],
              phone: PrescriptionData[index]['phone'],
              //status: PrescriptionData[index]['status'],
              status: "Rejected",
              date: PrescriptionData[index]['date'],
              time:PrescriptionData[index]['time'],
              take: PrescriptionData[index]['take'],
              data: true,
            );
          }
    );
  }
}
