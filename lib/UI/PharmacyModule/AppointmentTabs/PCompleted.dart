import 'package:chitwan_hospital/UI/PharmacyModule/AppointmentTabs/PListCard.dart';
import 'package:chitwan_hospital/state/pharmacy.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PCompleted extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<PharmacyDataStore>(context)
        .orders
        .where((element) =>
            element['status'] != null && element['status'] == 'ready')
        .toList();

    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (BuildContext context, int index) {
        return PListCard(
          id: orders[index]['id'],
          status: "completed"
        );
      },
    );
  }
}
