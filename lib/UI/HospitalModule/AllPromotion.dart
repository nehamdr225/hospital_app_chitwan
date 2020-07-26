import 'package:chitwan_hospital/UI/HospitalModule/PromotionListCard.dart';
import 'package:chitwan_hospital/state/hospital.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllPromotions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final promotions = Provider.of<HospitalDataStore>(context).promotions;
    return ListView.builder(
      itemCount: promotions != null ? promotions.length : 0,
      itemBuilder: (context, index) {
        return PromotionListCard(id: promotions[index].id);
      },
    );
  }
}
