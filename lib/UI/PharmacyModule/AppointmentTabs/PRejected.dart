import 'package:chitwan_hospital/UI/PharmacyModule/AppointmentTabs/PListCard.dart';
import 'package:chitwan_hospital/state/pharmacy.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PRejected extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    final orders = Provider.of<PharmacyDataStore>(context)
        .orders
        .where((element) => element['status'] == 'rejected')
        .toList();
    return ListView.builder(
        itemCount: orders.length,
        itemBuilder: (BuildContext context, int index) {
          return PListCard(
            id: orders[index]['id'],
          );
        });
  }
}
